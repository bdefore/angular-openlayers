'use strict'

app = angular.module('angularOpenLayersExample')

app.directive 'openlayers', ($location) ->
  link: (scope, elem, attrs, ctrl) ->

    # TODO: Why is elem an array and requires [0]? Change in angular api?
    elem = elem[0]

    # Marking areas where performance optimizations may be made for mobile
    emphasizePerformance = false;

    transformLatLon = (lat, lon) ->
      # Google.v3 uses web mercator as projection, so we have to transform our coordinates
      # new OpenLayers.LonLat(lon, lat)
      new OpenLayers.LonLat(lon, lat).transform('EPSG:4326', 'EPSG:3857')

    updateCoords = (lat, lon) ->
      map.setCenter transformLatLon( lat, lon ), getZoom(), false

    getZoom = () ->
      return scope.zoom + Number(attrs.zoomDelta) if attrs.zoomDelta
      return scope.zoom

    onMove = (event, eventElem) ->
      center = new OpenLayers.LonLat( event.object.center.lon, event.object.center.lat ).transform('EPSG:3857', 'EPSG:4326')
      # Since openlayers fires a 'moveend' event both for dragging and responses to map.setCenter calls, detect if 
      # angular is already updating its bindings using scope.$$phase. Also fires when zoom changes.
      if !scope.$$phase
        scope.$apply () ->
          # console.log 'transformed lat/lon: ' + center.lat + " / " + center.lon
          scope.lat = center.lat
          scope.lon = center.lon
          # Ignore updating binding for zoom if it's the preview pane that is digesting
          if !attrs.zoomDelta
            scope.zoom = event.object.zoom
            if $location.path() == "/from_url" && !emphasizePerformance
              $location.search( { lat: center.lat, lon: center.lon, zoom: event.object.zoom } )

    switch attrs.layerType
      when "satellite"
        layer = new OpenLayers.Layer.Google("Google Satellite", { type: google.maps.MapTypeId.SATELLITE, numZoomLevels: 16 } )
      when "terrain"
        layer = new OpenLayers.Layer.Google("Google Physical", { type: google.maps.MapTypeId.TERRAIN } )
      else
        throw "OpenLayer directive requires a layer type"

    console.log "lat: " + scope.lat + " lon: " + scope.lon + " zoom: " + scope.zoom + " zoomDelta: " + attrs.zoomDelta

    controls = [
        new OpenLayers.Control.Navigation()
    ]

    # Only show large controls when map is sufficiently large
    if angular.element(elem).prop('offsetWidth') > 200
      controls.push new OpenLayers.Control.PanZoomBar()
      controls.push new OpenLayers.Control.ScaleLine()
      controls.push new OpenLayers.Control.KeyboardDefaults()
      # controls.push new OpenLayers.Control.OverviewMap()

    map = new OpenLayers.Map elem,
      layers: [ layer ]
      zoom: getZoom()
      controls: controls

    # Map moves more seamlessly with move event, but may be too heavy in some cases
    moveEvent = if emphasizePerformance then 'moveend' else 'move'
    map.events.register moveEvent, elem, onMove

    scope.$watch 'zoom', () ->
      # TODO: Can we rely on the first layer in the array being the limiter for zoom?
      scope.zoom = Math.min(map.options.layers[0].maxZoomLevel, scope.zoom)
      scope.zoom = Math.max(map.options.layers[0].minZoomLevel, scope.zoom)
      map.zoomTo getZoom() 

    scope.$watch 'lat', () ->
      console.log elem.id + ' heard lat change: ' + scope.lat
      updateCoords scope.lat, scope.lon

    scope.$watch 'lon', () ->
      console.log elem.id + ' heard lon change: ' + scope.lon
      updateCoords scope.lat, scope.lon

    console.log 'openlayers for elem "' + elem.id + '" completed initializing'
