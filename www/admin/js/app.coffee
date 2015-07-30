'use strict'

angular.module 'AdminApp', [
  'ui.bootstrap'
  'ngRoute'
  'ngResource'
  'ngTable'
]
.config [
  '$routeProvider', '$locationProvider',
  ($routeProvider, $locationProvider) ->
    $routeProvider
      .when '/travel', {
        templateUrl: 'partials/travel.html'
        controller: 'EditTravelController'
      }
      .otherwise '/travel'

    $locationProvider.html5Mode(false)
]
