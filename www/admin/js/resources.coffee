'use strict'

angular.module('AdminApp')
  .factory 'TravelList', ['$resource', ($resource) ->
    $resource '/pub/travel'
  ]
  .factory 'Travel', ['$resource', ($resource) ->
    $resource '/pub/travel/:key', {
      key: '@_id'
    }
  ]
