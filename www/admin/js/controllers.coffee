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
    $scope.doc = {}
    $scope.attachments = []

    (reloadDoc = ->
      $scope.auth.db.get($routeParams.key).then (doc) ->
        $scope.doc = doc
        $scope.attachments = ({
          name: filename
          href: "/image/travel/#{$scope.doc.link}/#{filename}"
          thumb: "/image/travel/#{$scope.doc.link}/thumb/#{filename}"
          type: data.content_type
          size: data.length
        } for own filename, data of doc._attachments))()

    $scope.update = ->
      $scope.auth.db.put($scope.doc).then (_doc) ->
        $scope.doc._rev = _doc.rev
        alert 'Document updated'

    $scope.upload = (files) ->
      unless files and files.length
        return

      { _id, _rev } = $scope.doc

      uploads = for file in files
        $scope.auth.db.putAttachment(_id, file.name, _rev, file, file.type)

      $scope.uploading = true
      $q.all(uploads).then(reloadDoc)
        .finally -> $scope.uploading = false
]
.controller 'CreateTravelController', ['$scope', '$location',
  ($scope, $location) ->
    $scope.doc = {
      type: 'article'
      link: ''
      title: 'Новый маршрут'
      author: {}
    }
    $scope.create = ->
      $scope.auth.db.post($scope.doc).then (_doc) ->
        $location.path "/travel/#{_doc.id}"
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
    $scope.doc = {}
    $scope.attachments = []

    (reloadDoc = ->
      $scope.auth.db.get($routeParams.key).then (doc) ->
        $scope.doc = doc
        $scope.attachments = ({
          name: filename
          href: "/image/guide/#{$scope.doc.link}/#{filename}"
          thumb: "/image/guide/#{$scope.doc.link}/thumb/#{filename}"
          type: data.content_type
          size: data.length
        } for own filename, data of doc._attachments))()

    $scope.update = ->
      $scope.auth.db.put($scope.doc).then (_doc) ->
        $scope.doc._rev = _doc.rev

    $scope.upload = (files) ->
      unless files and files.length
        return

      { _id, _rev } = $scope.doc

      uploads = for file in files
        $scope.auth.db.putAttachment(_id, file.name, _rev, file, file.type)

      $scope.uploading = true
      $q.all(uploads).then(reloadDoc)
        .finally -> $scope.uploading = false
]
.controller 'CreateGuideController', ['$scope', '$location',
  ($scope, $location) ->
    $scope.doc = {
      type: 'guide'
      link: ''
      name: ''
    }
    $scope.create = ->
      $scope.auth.db.post($scope.doc).then (_doc) ->
        $location.path "/guide/#{_doc.id}"
]
