PageView = require 'views/base/page-view'

module.exports = class LandingPageView extends PageView

  template: require './templates/landing-page'

  id: 'landing-page'

  regions:
    error: '#error-container'
    popup: "#popup"

  events:
    'click .login': 'openPopup'
    'click #overlay': 'closePopup'

  openPopup: (e) ->
    e?.preventDefault()
    @$('#overlay').addClass 'open'

  closePopup: (e) ->
    e?.preventDefault()
    @$('#overlay').removeClass 'open'
