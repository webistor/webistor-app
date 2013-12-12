View = require 'views/base/view'

MenuView = require './menu-view'

module.exports = class NavigationView extends View
  
  autoRender: true
  className: 'navigation'
  tagName: 'nav'
  region: 'nav'
  template: require './templates/navigation'
  panel: null
  
  panels:
    'menu': '.menu-btn'
    'profile': '.profile-btn'
  
  events:
    'click .js-panel-btn': 'panelClick'
  
  regions:
    activePanel: '#navigation-active-panel'
    permanentPanel: '#navigation-permanent-panel'
  
  listen:
    'panel:open mediator': 'panelOpen'
    'panel:close mediator': 'panelClose'
    'navigation:change mediator': -> @publishEvent 'panel:close'
  
  panelOpen: (panel) ->
    @panel = panel
    @$((@findPanelButton panel)+' > a').addClass 'active'
    
  panelClose: ->
    @panel = null
    @$('.js-panel-btn > a').removeClass 'active'
  
  render: ->
    super
    menuView = new MenuView
    @subview 'menu', menuView
    # (If desktop then menuView.showPermanent())
    menuView.showPermanent()
    
  findButtonPanel: (el) ->
    $el = $ el
    return panel for own panel, selector of @panels when $el.is selector
    return null
  
  findPanelButton: (panel) ->
    return @panels[panel] or null
  
  panelClick: (e) ->
    e.preventDefault()
    panel = @findButtonPanel e.currentTarget
    close =  @panel is panel
    @publishEvent 'panel:close'
    return if close
    @publishEvent "panel:open:#{panel}"
    @publishEvent "panel:open", panel
