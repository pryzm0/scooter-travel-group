'use strict'

angular.module('AdminApp')
  .controller 'MainController', ['$scope', '$route', 'Session',
    ($scope, $route, Session) ->
      $scope.session = Session
  ]
  .controller 'LoginController', ['$scope', 'Session',
    ($scope, Session) ->
      $scope.formData = {}
      $scope.formError = false
      $scope.login = ->
        Session.login($scope.formData).then null, ->
          $scope.formError = true
  ]
