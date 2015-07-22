'use strict'

angular.module 'AdminApp', [
  'ngRoute'
  'ngResource'
]
.config [
  '$routeProvider', '$locationProvider',
  ($routeProvider, $locationProvider) ->
    $routeProvider
      .when '/routes', {
        templateUrl: 'partials/routes.html'
      }
      .when '/staff', {
        templateUrl: 'partials/staff.html'
      }

    $locationProvider.html5Mode(true)
]
