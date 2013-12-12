CollectionView = require 'views/base/collection-view'
panel = require './panel-mixin'

module.exports = class CollectionPanelView extends CollectionView
  _.extend @::, panel

