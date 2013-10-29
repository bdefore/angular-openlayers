'use strict'

describe 'Controller: MapCtrl', () ->

  # load the controller's module
  beforeEach module 'angularOpenLayersExample'

  MapCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    MapCtrl = $controller 'MapCtrl', {
      $scope: scope
    }

  it 'should have a default latitude and longitude', () ->
    expect(scope.lat).toNotBe null
    expect(scope.lon).toNotBe null
    expect(scope.zoom).toNotBe null
