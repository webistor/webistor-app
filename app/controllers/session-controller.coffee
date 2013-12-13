PageController = require 'controllers/base/page-controller'
UserSession = require 'models/user-session'
LoginPageView = require 'views/session/login-page-view'

module.exports = class HistoryController extends PageController
  
  login: (params) ->
    
    if(params?.username)
      userSession = new UserSession params
      userSession.save().then -> Chaplin.helpers.redirectTo 'history#show'
    else
      @view = new LoginPageView
  
  logout: ->
    userSession = new UserSession
    userSession.destroy().then -> Chaplin.helpers.redirectTo 'history#show'