CollectionPanelView = require './base/collection-panel-view'
NavigationItemView = require './navigation-item-view'

module.exports = class MenuView extends CollectionPanelView
  
  className: 'menu'
  template: require './templates/menu'
  
  itemView: NavigationItemView
  listSelector: '.hob-nav'
  
  listen:
    'panel:open:menu mediator': 'show'
  
  showPermanent: ->
    @hide()
    @region = 'permanentPanel'
    @unsubscribeEvent 'panel:open:menu', @show
    @unsubscribeEvent 'panel:close', @hide
    @show()
