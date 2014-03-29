View = require './base/view'

# Site view is a top-level view which is bound to body.
module.exports = class AppView extends View
  container: 'body'
  id: 'app-container'
  regions:
    nav: '#nav'
    main: '#left'
    side: '#tag-explorer'
  template: require './templates/app'
  
  initialize: ->
    super
    $('html').removeClass 'start'
