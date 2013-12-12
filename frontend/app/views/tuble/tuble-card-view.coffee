View = require 'views/base/view'

module.exports = class TubleView extends View
  autoRender: true
  template: require './templates/tuble-card'
