CollectionView = require 'views/base/collection-view'
EntryView = require './entry-view'
SyncCollection = require 'models/base/sync-collection'
Entry = require 'models/entry'

module.exports = class EntryListView extends CollectionView
  className: 'entry-list'
  template: require './templates/entry-list'
  autoRender: true
  itemView: EntryView
  
  initialize: ->
    @collection = new SyncCollection null, model:Entry
    @collection.fetch()
    super
  
  search: (query) ->
    @collection.urlParams.search = query
    @collection.fetch()
