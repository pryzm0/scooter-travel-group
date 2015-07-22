'use strict'

MenuItem = (name, href) ->
  href: href
  name: name

angular.module('AdminApp')
  .constant 'Menu', {
    anonymous: [
      MenuItem 'Login', '#'
    ]
    admin: [
      MenuItem 'Routes', '/routes'
      MenuItem 'Guides', '/guides'
      MenuItem 'Logout', '/logout'
    ]
  }
