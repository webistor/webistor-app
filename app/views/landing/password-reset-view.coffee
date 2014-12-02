View = require 'views/base/view'
mediator = require 'mediator'
utils = require 'lib/utils'

module.exports = class PasswordResetView extends View
  autoRender: false
  template: require './templates/password-reset'
  
  region: 'popup'
  id: 'password-reset'
  
  events:
    'submit .password-reset-form': 'onRequest'
  
  getTemplateData: ->
    email: @model.get 'email'
  
  onRequest: (e) ->
    e?.preventDefault()
    
    # This is a workaround for some password managers. Trigger a just-in-time change manually.
    @$('#l_email').trigger 'change'
    
    # Set the request on the model.
    @model.set email: @$('#l_email').val()
    @model.save()
