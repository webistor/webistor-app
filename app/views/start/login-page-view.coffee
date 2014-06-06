PageView = require 'views/base/page-view'
mediator = require 'mediator'
utils = require 'lib/utils'

module.exports = class LoginPageView extends PageView
  autoRender: true
  className: 'login-page'
  template: require './templates/login'

  events:
    'submit .login-form': 'doLogin'

  doLogin: (e) ->
    e?.preventDefault()

    # This is a workaround for some password managers. Trigger a just-in-time change manually.
    @$('#l_password, #l_email').trigger 'change'

    # Do a login.
    @publishEvent '!session:login',
      login: @$('#l_email').val()
      password: @$('#l_password').val()
