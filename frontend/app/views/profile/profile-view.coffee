PageView = require 'views/base/page-view'
utils = require 'lib/utils'

module.exports = class ProfileView extends PageView
  className: 'profile'
  template: require './templates/profile'
