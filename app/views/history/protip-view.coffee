View = require 'views/base/view'
support = require 'support'

module.exports = class ProtipView extends View

  autoRender: false
  className: 'pro-tip notification'
  template: require './templates/protip'

  events:
    'click .dismiss': 'hideProTip'

  initialize: ->
    super
    @render() if @isEnabled()

  showProTip: (force) ->
    @$el.show() if force or @isEnabled()

  hideProTip: ->
    localStorage['app.preferences.hide_pro_tip.bookmarklet'] = new Date().getTime();
    @$el.hide()

  isEnabled: ->
    support.localStorage and not localStorage['app.preferences.hide_pro_tip.bookmarklet']?
