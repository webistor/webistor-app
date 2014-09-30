View = require './base/view'

# Site view is a top-level view which is bound to body.
module.exports = class StartView extends View
  template: require './templates/start'
  container: 'body'
  id: 'start-container'
  regions:
    main: '.content-wrapper'
    error: '#error-container'

  initialize: ->
    super
    $('html').addClass 'start'
