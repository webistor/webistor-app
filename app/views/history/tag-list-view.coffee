CollectionView = require 'views/base/collection-view'
TagView = require './tag-view'
Collection = require 'models/base/collection'

module.exports = class TagListView extends CollectionView
  className: 'tag-list'
  autoRender: true
  itemView: TagView
  
  initialize: ->
    super
    @collection.fetch()
  
  resetCollection: ->
    @collection.fetch reset:true
