PageView = require 'views/base/page-view'
utils = require 'lib/utils'

module.exports = class UserView extends PageView
  className: 'user'
  template: require './templates/user'
