View = require 'views/base/view'

module.exports = class ProtipView extends View

  autoRender: false
  className: 'pro-tip'
  template: require './templates/protip'

  events:
    'click .dismiss': 'hideProTip'

  initialize: ->
    super
    @render() if @isEnabled()

  # TODO: Move to Chaplin.supports in a nice way.
  supportsLocalStorage: ->
    try
      return 'localStorage' of window and window.localStorage?
    catch err
      return false;

  showProTip: (force) ->
    @$el.show() if force or @isEnabled()

  hideProTip: ->
    localStorage['app.preferences.hide_pro_tip.bookmarklet'] = new Date().getTime();
    @$el.hide()

  isEnabled: ->
    @supportsLocalStorage() and not localStorage['app.preferences.hide_pro_tip.bookmarklet']?
