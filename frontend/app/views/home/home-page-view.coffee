PageView = require 'views/base/page-view'

module.exports = class HomePageView extends PageView
  autoRender: true
  className: 'home-page'
  template: require './templates/home'
