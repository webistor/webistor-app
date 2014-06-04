PageView = require 'views/base/page-view'
Invitation = require 'models/invitation'

module.exports = class InvitePageView extends PageView

  className: 'invite-page'
  template: require './templates/invite'

  bindings:
    '.email': 'email'

  events:
    'submit .invite': 'invite'

  render: ->
    super
    @stickit()

  invite: (e) ->
    e.preventDefault()
    @model.path = 'invitations/request'
    @model.save().then ((result) => @inviteSucces result), (=> @inviteError arguments...)

  inviteSucces: (result) ->
    @$('.error-message').html('<div>Your request is being processed!</div>')
    @$('.email, .request').hide()

  inviteError: (xhr, state, message) ->
    @$('.error-message').html('<div>'+message+'</div>')
