mediator = require 'mediator'
Controller = require 'controllers/base/controller'

module.exports = class RequireLogin extends Controller
  
  initialize: ->
    super
    @subscribeEvent 'session:logout', @logout
    @publishEvent '!session:determineLogin'
    
  logout: ->
    @redirectTo 'start#invite'
