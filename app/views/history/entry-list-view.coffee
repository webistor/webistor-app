CollectionView = require 'views/base/collection-view'
EntryView = require './entry-view'
Collection = require 'models/base/collection'
Entry = require 'models/entry'

module.exports = class EntryListView extends CollectionView
  className: 'entry-list'
  template: require './templates/entry-list'
  autoRender: true
  itemView: EntryView
  region: 'main'
