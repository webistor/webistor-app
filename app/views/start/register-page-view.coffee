PageView = require 'views/base/page-view'

module.exports = class RegisterPageView extends PageView
  autoRender: false
  className: 'register-page'
  template: require './templates/register'

  bindings:
    '#l_email': 'email'
    '#l_username': 'username'
    '#l_password1': 'password'

  events:
    'submit .register-form': 'register'

  getTemplateData: ->
    data = super
    data.emailEditable = not @model.has 'email'
    return data

  render: ->
    super
    @stickit()

  register: (e) ->
    e.preventDefault()
    # This is a workaround for some password managers. Trigger a just-in-time change manually.
    @$('#l_username, #l_password1, #l_password2').trigger 'change'
    unless (@model.get 'password') is @$('#l_password2').val() then return @publishEvent '!error:error', {
      name: 'ValidationError'
      message: "Passwords don't match."
    }
    @model.save().then -> Chaplin.utils.redirectTo 'landing#login'
