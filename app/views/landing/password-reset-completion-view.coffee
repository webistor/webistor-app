View = require 'views/base/view'

module.exports = class PasswordResetCompletionView extends View
  autoRender: false
  template: require './templates/password-reset-completion'
  
  region: 'popup'
  id: 'password-reset'

  events:
    'submit .password-reset-completion-form': 'onSubmit'

  onSubmit: (e) ->
    e?.preventDefault()

    # Check if password is empty.
    if !@$('#l_password1').val()
      return @publishEvent '!error:error',
        name: 'ValidationError'
        message: "Password is empty."

    # Check the passwords match.
    if @$('#l_password1').val() != @$('#l_password2').val()
      return @publishEvent '!error:error',
        name: 'ValidationError'
        message: "Passwords don't match."

    # Set the request on the model.
    @model.set password: @$('#l_password1').val()
    @model.set persistent: @$('#l_persistent').is(':checked')
    @model.save()
