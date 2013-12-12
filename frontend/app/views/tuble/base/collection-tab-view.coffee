CollectionView = require 'views/base/collection-view'
tab = require './tab-mixin'

module.exports = class CollectionTabView extends CollectionView
  _.extend @::, tab
