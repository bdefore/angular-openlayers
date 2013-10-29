'use strict'

app = angular.module('angularOpenLayersExample')

app.directive 'geoInput', () ->
  replace: true
  template: """
    <div class="geo-input-form">
      <label for="zoomInput">
        Zoom
      </label>
      <input id="zoomInput" type="number" ng-model="zoom" />
      <label for="zoomInput">
        Latitude
      </label>
      <input type="number" ng-model="lat" />
      <label for="zoomInput">
        Longitude
      </label>
      <input type="number" ng-model="lon" />
    </div>
  """
  link: (scope, elem, attrs) ->
    console.log "Geo inputs loaded"