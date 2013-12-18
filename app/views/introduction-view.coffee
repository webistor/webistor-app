View = require './base/view'

# Site view is a top-level view which is bound to body.
module.exports = class SiteView extends View
  container: 'body'
  id: 'introduction-container'
  regions:
    main: '.content-wrapper'
  template: require './templates/introduction'
  