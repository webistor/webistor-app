View = require './view'

module.exports = class CollectionView extends Chaplin.CollectionView
  getTemplateFunction: View::getTemplateFunction
  collect: View::collect
