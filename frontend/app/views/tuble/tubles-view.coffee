CollectionView = require 'views/base/collection-view'
TubleCardView = require './tuble-card-view'

module.exports = class TublesView extends CollectionView
  autoRender: true
  className: 'tubles'
  itemView: TubleCardView
