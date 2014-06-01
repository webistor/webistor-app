View = require './base/view'

# Site view is a top-level view which is bound to body.
module.exports = class StartView extends View
  container: 'body'
  id: 'start-container'
  regions:
    main: '.content-wrapper'
  template: require './templates/start'
  
  initialize: ->
    super
    $('html').addClass 'start'
