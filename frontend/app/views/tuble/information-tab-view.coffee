TabView = require './base/tab-view'
Review = require 'models/review'
ReviewView = require './review-view'

module.exports = class InformationTabView extends TabView
  template: require './templates/information-tab'
