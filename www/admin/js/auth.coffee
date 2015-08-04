'use strict'

angular.module('AdminApp')
.factory 'Auth', ['$rootScope', 'pouchDB', 'Conf',
  ($rootScope, pouchDB, Conf) ->
    class Auth
      userCtx: null
      db: null

      current: ->
        if @db == null
          db = pouchDB(Conf.database, { skipSetup: true })
          db.getSession().then ({ userCtx }) =>
            userCtx.ok = userCtx.name != null
            @_create(userCtx, db) if userCtx.ok
        else
          @db.getSession().then ({ userCtx }) =>
            userCtx.ok = userCtx.name != null
            @_destroy() unless userCtx.ok

      login: ({ user, pass }) ->
        db = pouchDB(Conf.database, { skipSetup: true })
        db.login(user, pass).then (userCtx) => @_create(userCtx, db)

      logout: ->
        @db.logout().then => @_destroy()

      _create: (@userCtx, @db) ->
        console.log 'session start', @userCtx
        $rootScope.$apply()

      _destroy: ->
        @userCtx = @db = null
        console.log 'session end'
        $rootScope.$apply()
]
