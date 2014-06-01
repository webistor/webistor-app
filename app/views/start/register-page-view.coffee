PageView = require 'views/base/page-view'
mediator = require 'mediator'

module.exports = class RegisterPageView extends PageView
  autorender: false
  className: 'register-page'
  template: require './templates/register'

  bindings:
    '#l_email': 'email'
    '#l_username': 'username'
    '#l_password1': 'password1'
    '#l_password2': 'password2'

  events:
    'submit .register-form': 'register'

  render: ->
    super
    @stickit()
    setTimeout (=> @$('#l_username')[0].focus()), 0

  register: (e) ->
    e.preventDefault()

    # This is a workaround for some password managers. Trigger a just-in-time change manually.
    @$('#l_username, #l_password1, #l_password2').trigger 'change'

    @model.save().then ((result) => @registerSucces(result)), ((xhr, state, message)=> @registerError(xhr, state, message))

  showErrorMessage: ->
    super
    @$('form').hide()
    @$('.welcome').text('Something went wrong.')
    @$('.message').text(message+' ').append($('<a>', {href:'invite', text:'You can request a new invite.'}))

  registerSucces: (result) ->
    Chaplin.utils.redirectTo 'app#history'

  registerError: (xhr, state, message) ->
    @$('.error-message').text(message)
