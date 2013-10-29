'use strict'

angular.module('angularOpenLayersExample', ['ngRoute'])
  .config ($routeProvider) ->
    $routeProvider
      .when '/from_url',
        templateUrl: 'views/from_url.html'
        reloadOnSearch: false
      .when '/from_name',
        templateUrl: 'views/from_name.html'
      .when '/from_coords_in_template',
        templateUrl: 'views/from_coords.html'
      .otherwise
        redirectTo: '/from_coords_in_template'
