View = require 'views/base/view'

module.exports = class RegisterView extends View
  autorender: false
  template: require './templates/register'
  
  id: 'register'
  region: 'popup'
  
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

    # Log in now (old message: "Great, you are in! <a href="landing#login">Log in</a> to view your brand new space.")
    @model.save().then ((result) => @doLogin result)

  doLogin: (e) ->
    @publishEvent '!session:login',
      login: @$('#l_username').val()
      password: @$('#l_password1').val()
