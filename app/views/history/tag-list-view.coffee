CollectionView = require 'views/base/collection-view'
TagView = require './tag-view'
TagCollection = require 'models/tag-collection'

module.exports = class TagListView extends CollectionView
  className: 'tag-list'
  autoRender: true
  itemView: TagView
  region: 'side'
  listSelector: '.list'
  template: require './templates/tag-list'
  limit: 50

  events:
    'click .extra': 'showMore'

  initialize: (o) ->
    @originalCollection = o.collection
    @collection = @createCollection @limit
    super

  showMore: (e) ->
    e?.preventDefault()
    @limit += @limit
    @collection = @createCollection @limit
    @render()

  createCollection: (limit) ->
    new TagCollection @originalCollection.slice 0, limit

  getTemplateData: ->
    data = super
    data.extraAmount = Math.max 0, @originalCollection.length - @limit
    return data
