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
  
  openPopup: (view) ->
    @subview 'popup', view
    @subview('popup').render()
    @$('#overlay').addClass 'open'

  closePopup: (e) ->
    return unless e?.target == @$('#overlay')[0]
    e?.preventDefault()
    Chaplin.utils.redirectTo 'landing#index'
    @$('#overlay')
    .removeClass('open')
    .delay 1000, =>
      @removeSubview 'popup'
