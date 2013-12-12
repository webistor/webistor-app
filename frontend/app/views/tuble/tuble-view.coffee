PageView = require 'views/base/page-view'
utils = require 'lib/utils'

module.exports = class TubleView extends PageView
  className: 'tuble'
  template: require './templates/tuble'
  
  events:
    'click .tabs a': 'clickTab'
  
  regions:
    openTabs: ".tab-contents"
  
  initialize: (options) ->
    @_openTabs = new utils.List
    @initialTabs = options.tabs
    @model.set reviews:[{id:1}, {id:2}]
  
  defaultTabs: ->
    #TODO: Make a real device check.
    if "media" is "screen" then ["information", "reviews"] else "information"
  
  render: (options) ->
    super
    @openTabs @initialTabs or @defaultTabs()
  
  clickTab: (e) ->
    e.preventDefault()
    e.stopPropagation()
    $el = $ e.target
    Backbone.history.navigate $el.attr 'href'
    @openTabs $el.data 'tabs'
  
  openTabs: (names) ->
    names = names.split ',' if typeof names is 'string'
    @closeTabs()
    @openTab name for name in names
    names = names.join ','
    @$('.tabs a').removeClass('active').filter("[data-tabs=\"#{names}\"]").addClass 'active'
    
  closeTabs: ->
    tab.hide() for tab in @_openTabs
    @_openTabs.empty()
    
  openTab: (name) ->
    tab = @subview "#{name}-tab"
    unless tab?
      TabView = require "./#{name}-tab-view"
      tab = @subview "#{name}-tab", new TabView {@model}
      @listenTo tab, 'dispose', => @_openTabs.clear tab
    tab.show()
    @_openTabs.push tab
  
  closeTab: (name) ->
    tab = @subview "#{name}-tab"
    tab.hide()
    @_openTabs.clear tab
