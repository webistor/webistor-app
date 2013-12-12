View = require './base/view'

# Site view is a top-level view which is bound to body.
module.exports = class SiteView extends View
  container: 'body'
  id: 'site-container'
  regions:
    nav: '#nav'
    main: '#left'
    side: '#right'
  template: require './templates/site'
  