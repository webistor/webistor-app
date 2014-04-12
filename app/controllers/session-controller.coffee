Controller = require 'controllers/base/controller'
mediator = require 'mediator'
Me = require 'models/me'
utils = require 'lib/utils'

module.exports = class SessionController extends Controller
  
  loginStatus: null
  @me: null
  
  initialize: ->
    super
    @me = mediator.user = new Me
    @subscribeEvent '!session:login', @login
    @subscribeEvent '!session:determineLogin', @determineLoginStatus
    @subscribeEvent '!session:logout', @logout
  
  login: (data) ->
    @publishEvent 'session:loginAttempt'
    @me.set data
    @me.save()
    .then(=> @handleLogin())
    .fail((xhr,b,message) => @handleLoginFailure xhr.responseJSON?.error or message)
  
  determineLoginStatus: ->
    unless @isLoginStatusDetermined()
      utils.req('GET', 'session/loginCheck')
      .then((data) => if data.value is true then @handleLogin() else @handleLogout())
      .fail(=> @handleLogout())
  
  logout: ->
    @me.destroy().always => @handleLogout()
  
  handleLogin: ->
    @publishEvent 'session:login'
    @publishEvent 'session:loginStatus', true
    @loginStatus = true
  
  handleLogout: ->
    @me = mediator.user = new Me
    @publishEvent 'session:logout'
    @publishEvent 'session:loginStatus', false
    @loginStatus = false
  
  handleLoginFailure: (message) ->
    @publishEvent 'session:loginFailure', message
    @publishEvent 'session:loginStatus', false
    @loginStatus = false
  
  isLoginStatusDetermined: ->
    @loginStatus isnt null
