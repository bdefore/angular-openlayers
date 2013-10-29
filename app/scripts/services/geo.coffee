'use strict'

app = angular.module('angularOpenLayersExample')

app.factory 'geo', ->
  London:
    lat: 51.5072
    lon: 0.1275
    zoom: 5
  Sydney:
    lat: -33.8600
    lon: 151.2111
    zoom: 5
