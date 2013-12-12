CollectionTabView = require './base/collection-tab-view'
Review = require 'models/review'
ReviewView = require './review-view'

module.exports = class ReviewsTabView extends CollectionTabView
  
  itemView: ReviewView
  
  constructor: (options) ->
    options.collection = options.model.subset 'reviews', model:Review
    super
