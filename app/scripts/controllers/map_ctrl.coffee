'use strict'

app = angular.module('angularOpenLayersExample')

app.controller 'mapCtrl', [ '$scope', '$location', 'geo', ($scope, $location, geo) ->
  # defaults
  $scope.zoom = 5
  $scope.lat = 37.7833 # lat of san francisco
  $scope.lon = -122.4167 # lon of san francisco

  $scope.initFromCoords = (lat, lon, zoom) ->
    $scope.lat = lat
    $scope.lon = lon
    $scope.zoom = zoom

  $scope.initFromName = (name) ->
    coords = geo[name]
    $scope.lat = coords.lat
    $scope.lon = coords.lon
    $scope.zoom = coords.zoom

  $scope.initFromURL = () ->
    urlParams = $location.search()
    $scope.lat = Number(urlParams.lat)
    $scope.lon = Number(urlParams.lon)
    $scope.zoom = Number(urlParams.zoom)
    console.log $scope
]
