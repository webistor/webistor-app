PageView = require 'views/base/page-view'
mediator = require 'mediator'
utils = require 'lib/utils'

module.exports = class PasswordResetRequestedPageView extends PageView
  autoRender: true
  className: 'password-reset-page'
  template: require './templates/password-reset-requested'
