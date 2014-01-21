PageView = require 'views/base/page-view'
UserSession = require 'models/user-session'
mediator = require 'mediator'
utils = require 'lib/utils'

module.exports = class LoginPageView extends PageView
  autoRender: true
  className: 'login-page'
  template: require './templates/login'
  
  events:
    'submit .login-form': 'doLogin'
  
  listen:
    'session:login mediator': 'onLogin'
    'session:loginFailure mediator': 'onLoginFailure'
  
  initialize: ->
    @publishEvent '!session:determineLogin'
  
  doLogin: (e) ->
    e?.preventDefault()
    
    # This is a workaround for some password managers. Trigger a just-in-time change manually.
    @$el.find('#l_password, #l_email').trigger 'change'

    # Do a persistent login.
    @publishEvent '!session:login',
      persistent: 1
      email: @$el.find('#l_email').val()
      password: @$el.find('#l_password').val()
  
  onLogin: ->
    utils.redirectTo 'app#history'
  
  onLoginFailure: (message) ->
    @$el.find('.error-message').html('<div>'+message+'</div>')
