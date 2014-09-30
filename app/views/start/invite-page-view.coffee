PageView = require 'views/base/page-view'
Invitation = require 'models/invitation'

module.exports = class InvitePageView extends PageView

  className: 'invite-page'
  template: require './templates/invite'

  bindings:
    '.email': 'email'

  events:
    'submit .invite': 'invite'

  regions:
    error: '.error-message'

  render: ->
    super
    @stickit()

  invite: (e) ->
    e.preventDefault()
    @model.path = 'invitations/request'
    @model.save().then ((result) => @inviteSucces result)

  inviteSucces: (result) ->
    @$('.error-message').html('<div>Your request is being processed!</div>')
    @$('.email, .request').hide()
