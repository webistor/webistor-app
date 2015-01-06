View = require 'views/base/view'
Me = require 'models/me'
mediator = require 'mediator'

module.exports = class FeedbackView extends View
  template: require './templates/feedback'

  id: 'feedback'
  region: 'popup'

  events:
    'submit .feedback-form': 'doSendFeedback'
  
  getTemplateData: ->
    data = mediator.user?.serialize() or {}
    return data

  bindings:
    '#l_subject': 'subject'
    '#l_message': 'message'

  render: ->
    super
    @stickit()
    user = mediator.user?.serialize() or {}
    email = user.email
    setTimeout (=> @$('p.email-address').html(email)), 50
    setTimeout (=> @$('#l_subject')[0].focus()), 50
  
  doSendFeedback: (e) ->
    e.preventDefault()
    @model.set email: @$('#l_email').val()
    @model.path = 'feedback/contribution'
    @model.save().then ((result) => @feedbackSuccess result)

  feedbackSuccess: (result) ->
    $('#feedback').html('<div>Thank you for your feedback!</div>')
    setTimeout (=> $('.overlay.open').fadeOut() ), 2500
