'use strict'

angular.module('AdminApp')
  .factory 'User', ['$resource', ($resource) ->
    $resource '/api/user/:name', {}, {
      current:
        method: 'GET'
        url: '/api/user/current'
      signIn:
        method: 'POST'
        url: '/api/user/signin'
      signOut:
        method: 'POST'
        url: '/api/user/signout'
        params: { name: '@user.name' }
    }
  ]
  .service 'Session', ['User', (User) ->
    currentUser: User.current()
    login: (authData) ->
      @currentUser = User.signIn(authData)
      @currentUser.$promise
    logout: ->
      @currentUser.$signOut().then =>
        @currentUser = User.current()
        @currentUser.$promise
  ]
