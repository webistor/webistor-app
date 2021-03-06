View = require 'views/base/view'

module.exports = class LoginView extends View
  autorender: false
  template: require './templates/login'

  id: 'login'
  region: 'popup'

  events:
    'submit .login-form': 'doLogin'
  
  render: ->
    super
    setTimeout (=> @$('#username')[0].focus()), 50
  
  doLogin: (e) ->
    e?.preventDefault()

    # This is a workaround for some password managers. Trigger a just-in-time change manually.
    @$('#password, #username').trigger 'change'

    # Do a login.
    @publishEvent '!session:login',
      login: @$('#username').val()
      password: @$('#password').val()
      persistent: @$('#remember-me').is(':checked')
