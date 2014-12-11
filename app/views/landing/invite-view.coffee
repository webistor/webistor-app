View = require 'views/base/view'

module.exports = class InviteView extends View
  template: require './templates/invite'

  id: 'invite'
  region: 'popup'

  events:
    'submit .invite-form': 'invite'

  bindings:
    '.email': 'email'

  render: ->
    super
    @stickit()
    setTimeout (=> @$('input.email')[0].focus()), 50
  
  invite: (e) ->
    e.preventDefault()
    @model.path = 'invitations/request'
    @model.save().then ((result) => @inviteSucces result)

  inviteSucces: (result) ->
    @$('.invite-wrapper').html('<div>Your request is being processed!</div>')
