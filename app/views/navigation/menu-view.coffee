PanelView = require './base/panel-view'
Me = require 'models/me'

module.exports = class MenuView extends PanelView
  
  className: 'menu'
  template: require './templates/menu'
  
  listSelector: '.hob-nav'
  
  listen:
    'panel:open:menu mediator': 'show'
  
  showPermanent: ->
    @hide()
    @region = 'permanentPanel'
    @unsubscribeEvent 'panel:open:menu', @show
    @unsubscribeEvent 'panel:close', @hide
    @show()
  
  initialize: ->
    @model = new Me
    @model.fetch().then => @render()
    super
  
  render: ->
    super
    console.log 'Menu render'