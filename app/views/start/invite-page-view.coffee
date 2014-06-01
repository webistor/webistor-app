PageView = require 'views/base/page-view'
Invitation = require 'models/invitation'

module.exports = class InvitePageView extends PageView
  autoRender: true
  className: 'invite-page'
  template: require './templates/invite'
  
  bindings:
    '.email': 'email'
  
  events:
    'submit .invite': 'invite'
  
  initialize: ->
    @model = new Invitation
    super
  
  render: ->
    super
    @stickit()
  
  invite: (e) ->
    e.preventDefault()
    @model.path = 'invitations/register'
    @model.save().then ((result) => @inviteSucces result), (=> @inviteError arguments...)
  
  inviteSucces: (result) ->
    console.log('inviteSuccess');
    @$('.error-message').html('<div>Your request is being processed!</div>')
    @$('.email, .request').hide()
    # Chaplin.utils.redirectTo 'introduction#thankyou')
  
  inviteError: (xhr, state, message) ->
    @$('.error-message').html('<div>'+message+'</div>')
