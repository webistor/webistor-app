PageView = require 'views/base/page-view'
UserInvite = require 'models/user-invite'

module.exports = class InvitePageView extends PageView
  autoRender: true
  className: 'invite-page'
  template: require './templates/invite'
  
  bindings:
    '.email': 'email'
  
  events:
    'submit .invite': 'invite'
  
  initialize: ->
    @model = new UserInvite
    super
  
  render: ->
    super
    @stickit()
    # setTimeout (=> @$('.email')[0].focus()), 0
  
  invite: (e) ->
    e.preventDefault()
    @model.save().then ((result) => @inviteSucces(result)), ((xhr, state, message)=> @inviteError(xhr, state, message))
  
  inviteSucces: (result) ->
    @$('.error-message').html('<div>Your request is being processed!</div>')
    @$('.email, .request').hide()
    # Chaplin.utils.redirectTo 'introduction#thankyou')
  
  inviteError: (xhr, state, message) ->
    @$('.error-message').html('<div>'+message+'</div>')
