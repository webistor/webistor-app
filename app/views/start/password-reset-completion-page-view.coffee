PageView = require 'views/base/page-view'

module.exports = class PasswordResetCompletionPageView extends PageView
  autoRender: true
  className: 'password-reset-page'
  template: require './templates/password-reset-completion'
  
  events:
    'submit .password-reset-completion-form': 'onSubmit'
  
  onSubmit: (e) ->
    e?.preventDefault()
    
    # Check if password is empty.
    if !@$('#l_password1').val()
      @publishEvent '!error:error', new Error('Password is emtpy.')
      return
    
    # Check the passwords match.
    if @$('#l_password1').val() != @$('#l_password2').val()
      return @publishEvent '!error:error',
        name: 'ValidationError'
        message: "Passwords don't match."
    
    # Set the request on the model.
    @model.set password: @$('#l_password1').val()
    @model.save()
