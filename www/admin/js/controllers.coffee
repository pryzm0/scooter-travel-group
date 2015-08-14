'use strict'

TABLECONF =
  noPager: true
  page: 1
  count: 10

angular.module('AdminApp')
.controller 'MainController', ['$scope', '$route', 'Auth',
  ($scope, $route, Auth) ->
    $scope.auth = new Auth()
    $scope.auth.current()
]
.controller 'LoginController', ['$scope',
  ($scope) ->
    $scope.formData = {}
    $scope.formError = false
    $scope.login = ->
      $scope.auth.login($scope.formData)
        .then null, -> $scope.formError = true
]
.controller 'ListTravelController', ['$scope', 'ngTableParams',
  ($scope, ngTableParams) ->
    $scope.tableParams = new ngTableParams(TABLECONF, {
      total: 0
      counts: []
      getData: ($defer, params) ->
        $scope.auth.db.query('article/listRows').then (result) ->
          params.total(result.total_rows)
          $defer.resolve(result.rows)
        return
    })

    $scope.remove = (key) ->
      $scope.auth.db.get(key)
        .then (doc) -> $scope.auth.db.remove(doc)
        .then -> $scope.tableParams.reload()
]
.controller 'EditTravelController', ['$scope', '$q', '$routeParams', 'Conf',
  ($scope, $q, $routeParams, Conf) ->
    reloadDoc = ->
      $scope.auth.db.get($routeParams.key).then (doc) ->
        $scope.travel = doc

    $scope.travel = {}
    reloadDoc()

    $scope.update = ->
      $scope.auth.db.put($scope.travel).then (doc) ->
        $scope.travel._rev = doc.rev

    $scope.attachmentUrl = (filename) ->
      "/image/travel/#{$scope.travel.link}/#{filename}"

    $scope.upload = (files) ->
      unless files and files.length
        return

      { _id, _rev } = $scope.travel

      uploads = for file in files
        $scope.auth.db.putAttachment(_id, file.name, _rev, file, file.type)

      $scope.uploading = true
      $q.all(uploads)
        .then -> reloadDoc()
        .finally -> $scope.uploading = false

    $scope.listImages = ->
      unless $scope.travel._attachments
        return []
      Object.keys($scope.travel._attachments).map (filename) ->
        $scope.attachmentUrl(filename)
]
.controller 'CreateTravelController', ['$scope', '$location',
  ($scope, $location) ->
    $scope.travel = {
      type: 'article'
      link: ''
      title: 'Новый маршрут'
      author: {}
    }
    $scope.create = ->
      $scope.auth.db.post($scope.travel).then (doc) ->
        $location.path "/travel/#{doc.id}"
]
.controller 'ListGuideController', ['$scope', 'ngTableParams',
  ($scope, ngTableParams) ->
    $scope.tableParams = new ngTableParams(TABLECONF, {
      total: 0
      counts: []
      getData: ($defer, params) ->
        $scope.auth.db.query('guide/listRows').then (result) ->
          params.total(result.total_rows)
          $defer.resolve(result.rows)
        return
    })

    $scope.remove = (key) ->
      $scope.auth.db.get(key)
        .then (doc) -> $scope.auth.db.remove(doc)
        .then -> $scope.tableParams.reload()
]
.controller 'EditGuideController', ['$scope', '$q', '$routeParams', 'Conf',
  ($scope, $q, $routeParams, Conf) ->
    reloadDoc = ->
      $scope.auth.db.get($routeParams.key).then (doc) ->
        $scope.guide = doc

    $scope.guide = {}
    reloadDoc()

    $scope.update = ->
      $scope.auth.db.put($scope.guide).then (doc) ->
        $scope.guide._rev = doc.rev

    $scope.attachmentUrl = (filename) ->
      "/image/guide/#{$scope.guide.link}/#{filename}"

    $scope.upload = (files) ->
      unless files and files.length
        return

      { _id, _rev } = $scope.guide

      uploads = for file in files
        $scope.auth.db.putAttachment(_id, file.name, _rev, file, file.type)
          .then null, (err) -> console.error 'upload failed', err

      $scope.uploading = true
      $q.all(uploads)
        .then -> reloadDoc()
        .finally -> $scope.uploading = false

    $scope.listImages = ->
      unless $scope.guide._attachments
        return []
      Object.keys($scope.guide._attachments).map (filename) ->
        $scope.attachmentUrl(filename)
]
.controller 'CreateGuideController', ['$scope', '$location',
  ($scope, $location) ->
    $scope.guide = {
      type: 'guide'
      link: ''
      name: ''
    }
    $scope.create = ->
      $scope.auth.db.post($scope.guide).then (doc) ->
        $location.path "/guide/#{doc.id}"
]
