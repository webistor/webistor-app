Controller = require 'controllers/base/controller'
mediator = require 'mediator'
Me = require 'models/me'
UserSession = require 'models/user-session'

module.exports = class SessionController extends Controller
  
  loginStatus: null
  
  initialize: ->
    super
    mediator.user = new Me
    
    @subscribeEvent '!session:login', @login
    @subscribeEvent '!session:determineLogin', @determineLoginStatus
    @subscribeEvent '!session:logout', @logout
  
  show: ->
    #show login view
  
  login: (data) ->
    @publishEvent 'session:loginAttempt'
    @userSession = new UserSession data
    @userSession.save().then (=> @determineLoginStatus()), ((a,b,message) => @handleLoginFailure(message))
  
  determineLoginStatus: ->
    mediator.user.fetch().then (=> @handleLogin()), (=> @handleLogout()) if not @isLoginStatusDetermined()
  
  logout: ->
    (@userSession or new UserSession).destroy().always => @handleLogout()
  
  handleLogin: ->
    @publishEvent 'session:login'
    @publishEvent 'session:loginStatus', true
    @loginStatus = true
  
  handleLogout: ->
    mediator.user = new Me
    @publishEvent 'session:logout'
    @publishEvent 'session:loginStatus', false
    @loginStatus = false
  
  handleLoginFailure: (message) ->
    @publishEvent 'session:loginFailure', message
    @publishEvent 'session:loginStatus', false
    @loginStatus = false
  
  isLoginStatusDetermined: ->
    @loginStatus is not null
