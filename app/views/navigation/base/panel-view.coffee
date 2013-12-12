View = require 'views/base/view'
panel = require './panel-mixin'

module.exports = class PanelView extends View
  _.extend @::, panel
