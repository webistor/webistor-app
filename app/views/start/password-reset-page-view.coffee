PageView = require 'views/base/page-view'
mediator = require 'mediator'
utils = require 'lib/utils'

module.exports = class PasswordResetPageView extends PageView
  autoRender: false
  className: 'password-reset-page'
  template: require './templates/password-reset'
  
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
