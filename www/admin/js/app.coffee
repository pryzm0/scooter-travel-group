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
  database: 'http://128.199.180.237:5984/travelapp'
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
      .when '/guide', {
        templateUrl: 'partials/guide/list.html'
        controller: 'ListGuideController'
      }
      .when '/guide/new', {
        templateUrl: 'partials/guide/create.html'
        controller: 'CreateGuideController'
      }
      .when '/guide/:key', {
        templateUrl: 'partials/guide/edit.html'
        controller: 'EditGuideController'
      }
      .otherwise '/travel'

    $locationProvider.html5Mode(false)
]
