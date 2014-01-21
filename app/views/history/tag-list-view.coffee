CollectionView = require 'views/base/collection-view'
TagView = require './tag-view'
Collection = require 'models/base/collection'
Tag = require 'models/tag'

module.exports = class TagListView extends CollectionView
  className: 'tag-list'
  autoRender: true
  itemView: TagView
  
  comparator = (a, b) ->
    return -1 if (a.get 'color') and not (b.get 'color')
    return  1 if (b.get 'color') and not (a.get 'color')
    return -1 if (a.get 'num') > (b.get 'num')
    return  1 if (b.get 'num') > (a.get 'num')
    return  0
  
  initialize: ->
    @collection = new Collection null, model:Tag
    @collection.comparator = comparator
    @subscribeEvent 'entry:sync', => @collection.fetch reset:true
    @collection.fetch()
    super
