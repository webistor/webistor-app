PageView = require 'views/base/page-view'
mediator = require 'mediator'
utils = require 'lib/utils'

module.exports = class LoginPageView extends PageView
  autoRender: true
  className: 'login-page'
  template: require './templates/login'

  regions:
    error: '.error-message'

  events:
    'submit .login-form': 'doLogin'

  getTemplateData: ->
    data = super
    data.nocookies = not Cookies.enabled
    return data

  doLogin: (e) ->
    e?.preventDefault()

    # This is a workaround for some password managers. Trigger a just-in-time change manually.
    @$('#l_password, #l_email').trigger 'change'

    # Do a login.
    @publishEvent '!session:login',
      login: @$('#l_email').val()
      password: @$('#l_password').val()
      persistent: @$('#l_persistent').is(':checked')
