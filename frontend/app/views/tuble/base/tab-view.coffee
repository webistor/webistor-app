View = require 'views/base/view'
tab = require './tab-mixin'

module.exports = class TabView extends View
  _.extend @::, tab
