View = require './base/view'

# Site view is a top-level view which is bound to body.
module.exports = class SiteView extends View
  container: 'body'
  id: 'site-container'
  regions:
    nav: '#navigation-container'
    main: '#page-container'
  template: require './templates/site'
  
  events:
    'click #page-container': 'closePanel'
  
  initialize: ->
    $([window, document]).on 'scroll', => @scrollDocument arguments...
    super
  
  scrollDocument: (event) ->
    return unless event.target is document
    @closePanel()
  
  closePanel: ->
    @publishEvent 'panel:close'
