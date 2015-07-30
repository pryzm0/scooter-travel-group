'use strict'

TABLECONF =
  noPager: true
  page: 1
  count: 10

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
  .controller 'EditTravelController', [
    '$scope', '$timeout', 'ngTableParams', 'TravelList', 'Travel'
    ($scope, $timeout, ngTableParams, TravelList, Travel) ->
      $scope.travelEdit = null

      $scope.tableParams = new ngTableParams(TABLECONF, {
        total: 0
        counts: []
        getData: ($defer, params) ->
          TravelList.get params.url(), (data) ->
            $timeout ->
              params.total(data.total)
              $defer.resolve(data.rows)
            , 500
          return
      })

      $scope.create = ->
        $scope.travelEdit = new Travel({
          type: 'article'
          link: ''
          keywords: ''
          description: ''
          title: ''
          author: ''
          content: ''
        })

      $scope.load = (row) ->
        $scope.travelEdit = new Travel()
        $scope.travelEdit.$get { key: row.id }

      $scope.update = ->
        (if $scope.travelEdit._rev
          $scope.travelEdit.$save()
        else
          $scope.travelEdit = TravelList.save($scope.travelEdit)
          $scope.travelEdit.$promise)
        .then (data) ->
            $scope.tableParams.reload()

      $scope.remove = (row=$scope.travelEdit) ->
        if row
          Travel.remove({ key: row.id }).$promise.then ->
            if row.id == $scope.travelEdit?._id
              $scope.travelEdit = null
            $scope.tableParams.reload()
  ]
