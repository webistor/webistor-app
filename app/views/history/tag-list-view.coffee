CollectionView = require 'views/base/collection-view'
TagView = require './tag-view'
SyncCollection = require 'models/base/sync-collection'
Tag = require 'models/tag'

module.exports = class TagListView extends CollectionView
  className: 'tag-list'
  template: require './templates/tag-list'
  autoRender: true
  itemView: TagView
  
  initialize: ->
    @collection = new SyncCollection null, model:Tag
    @collection.fetch()
    super
  
  search: (query) ->
    @collection.urlParams.search = query
    @collection.fetch()
