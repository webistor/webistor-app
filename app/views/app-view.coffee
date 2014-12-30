View = require './base/view'

# Site view is a top-level view which is bound to body.
module.exports = class AppView extends View
  template: require './templates/app'
  container: 'body'
  id: 'app-container'
  regions:
    nav: '#nav'
    main: '#left-wrapper'
    side: '#right-wrapper'
    error: '#error-container'
    popup: "#popup"

  events:
    'click #overlay': 'closePopup'

  initialize: ->
    super
    $('html').removeClass 'start'

  openPopup: (view) ->
    @subview 'popup', view
    @subview('popup').render()
    @$('#overlay').addClass 'open'
    $('body').addClass 'no-scroll'

  closePopup: (e) ->
    return unless e?.target == @$('#overlay')[0]
    e?.preventDefault()
    Chaplin.utils.redirectTo 'app#list'
    $('body').removeClass 'no-scroll'
    @$('#overlay')
    .removeClass('open')
    .delay 1000, =>
      @removeSubview 'popup'
