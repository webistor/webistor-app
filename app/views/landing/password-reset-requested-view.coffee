View = require 'views/base/view'
mediator = require 'mediator'
utils = require 'lib/utils'

module.exports = class PasswordResetRequestedView extends View
  template: require './templates/password-reset-requested'
  
  region: 'popup'
  id: 'password-reset'
