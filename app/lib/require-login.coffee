mediator = require 'mediator'
Controller = require 'controllers/base/controller'

module.exports = class RequireLogin extends Controller
  
  initialize: ->
    mediator.subscribe 'session:logout', @onLogout
  
  dispose: ->
    mediator.unsubscribe 'session:logout', @onLogout
    
  onLogout: ->
    Chaplin.helpers.redirectTo 'start#login'