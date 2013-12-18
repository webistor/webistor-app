PageController = require 'controllers/base/page-controller'
UserSession = require 'models/user-session'
LoginPageView = require 'views/session/login-page-view'
mediator = require 'mediator'

module.exports = class HistoryController extends PageController
  
  login: ->
    @view = new LoginPageView
    
  logout: ->
    userSession = new UserSession
    userSession.destroy().then ->
      console.log 'publish logout plox'
      Chaplin.helpers.redirectTo 'history#show'
      mediator.publish 'session:logout'