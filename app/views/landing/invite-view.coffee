View = require 'views/base/view'

module.exports = class InviteView extends View
  template: require './templates/invite'

  id: 'invite'
  region: 'popup'
