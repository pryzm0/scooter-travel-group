'use strict'

angular.module 'AdminApp', [
  'ui.bootstrap'
  'ngRoute'
  'ngResource'
  'ngTable'
  'ngFileUpload'
  'pouchdb'
]
.constant 'Conf', {
  database: 'http://localhost:5984/travelapp'
}
.config ['$routeProvider', '$locationProvider',
  ($routeProvider, $locationProvider) ->
    $routeProvider
      .when '/travel', {
        templateUrl: 'partials/travel/list.html'
        controller: 'ListTravelController'
      }
      .when '/travel/new', {
        templateUrl: 'partials/travel/create.html'
        controller: 'CreateTravelController'
      }
      .when '/travel/:key', {
        templateUrl: 'partials/travel/edit.html'
        controller: 'EditTravelController'
      }
      .otherwise '/travel'

    $locationProvider.html5Mode(false)
]
