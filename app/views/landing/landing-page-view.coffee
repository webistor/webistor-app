PageView = require 'views/base/page-view'
LoginView = require './login-view'
InviteView = require './invite-view'

module.exports = class LandingPageView extends PageView

  template: require './templates/landing-page'

  id: 'landing-page'

  regions:
    error: '#error-container'
    popup: "#popup"

  events:
    'click #overlay': 'closePopup'
  
  openLogin: (e) ->
    @subview 'popup', new LoginView
    @subview('popup').render()
    @openPopup e
  
  openInvite: (e) ->
    @subview 'popup', new InviteView
    @subview('popup').render()
    @openPopup e
  
  openPopup: (e) ->
    e?.preventDefault()
    @$('#overlay').addClass 'open'

  closePopup: (e) ->
    return unless e?.target == @$('#overlay')[0]
    e?.preventDefault()
    Chaplin.utils.redirectTo 'landing#index'
    @$('#overlay')
    .removeClass('open')
    .delay 1000, =>
      @removeSubview 'popup'
