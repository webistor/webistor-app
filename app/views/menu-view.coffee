View = require './base/view'
Me = require 'models/me'
utils = require 'lib/utils'
mediator = require 'mediator'

module.exports = class MenuView extends View

  region: 'nav'
  className: 'inner-center'
  template: require './templates/menu'

  listen:
    'session:loginStatus mediator': 'render'

  events:
    'click .js-logout': 'doLogout'

  getTemplateData: ->
    data = mediator.user?.serialize() or {}
    return data

  doLogout: (e) ->
    @publishEvent '!session:logout'
