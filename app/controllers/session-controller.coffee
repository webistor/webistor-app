Controller = require 'controllers/base/controller'
mediator = require 'mediator'
Me = require 'models/me'
UserSession = require 'models/user-session'

_user = new Me

module.exports = class SessionController extends Controller
  
  initialize: ->
    super
    if _user.isNew() then _user.fetch().then (-> mediator.publish 'session:login'), (-> mediator.publish 'session:logout')
  
  logout: ->
    userSession = new UserSession
    userSession.destroy()
      .then ->
        _user = new Me
        mediator.publish 'session:logout'
      .always ->
        Chaplin.helpers.redirectTo 'start#login'