'use strict'

angular.module 'AdminApp', [
  'ui.bootstrap'
  'ngRoute'
  'ngResource'
  'ngTable'
  'pouchdb'
]
.constant 'Conf', {
  database: 'http://localhost:5984/travelapp'
}
.directive 'markdownEditor', ->
  ($scope, $element) -> $element.markdown()
.config ['$routeProvider', '$locationProvider',
  ($routeProvider, $locationProvider) ->
    $routeProvider
      .when '/travel', {
        templateUrl: 'partials/travel.html'
        controller: 'EditTravelController'
      }
      .otherwise '/travel'

    $locationProvider.html5Mode(false)
]
