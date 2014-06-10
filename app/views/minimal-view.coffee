View = require './base/view'

# Minimal view is a top-level view which is bound to body.
module.exports = class MinimalView extends View
  container: 'body'
  id: 'container'
  regions:
    main: '.content-wrapper'
  template: require './templates/minimal'
