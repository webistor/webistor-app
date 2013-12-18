PageView = require 'views/base/page-view'
UserInvite = require 'models/user-invite'

module.exports = class IntroductionPageView extends PageView
  autoRender: true
  className: 'introduction-page'
  template: require './templates/introduction'
  
  bindings:
    '.email': 'email'
  
  events:
    'submit .invite': 'invite'
  
  initialize: ->
    @model = new UserInvite
    super
    $('html').addClass 'introduction'
  
  render: ->
    super
    @stickit()
    setTimeout (=> @$el.find('.email')[0].focus()), 0
  
  invite: (e) ->
    e.preventDefault()
    
    @model.save().then ((result) => @$el.find('.error-message').text('Your request is being processed!'); @$el.find('.email, .request').hide(); Chaplin.helpers.redirectTo 'introduction#thankyou'),
      ((xhr, state, message)=> @$el.find('.error-message').text(message))