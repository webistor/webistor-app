PageView = require 'views/base/page-view'
Entry = require 'models/entry'
EntryView = require './entry-view'
EntryListView = require './entry-list-view'
TagListView = require './tag-list-view'

module.exports = class HistoryPageView extends PageView
  autoRender: true
  className: 'history-page'
  template: require './templates/history'
  newEntry: null
  
  events:
    'click .js-add-entry:not(.toggled)': 'createNewEntry'
    'click .js-add-entry.toggled': 'cancelNewEntry'
  
  initialize: (o) ->
    @search = o?.search or undefined
  
  render: ->
    super
    @subview 'entry-list', new EntryListView {container: this.el, search: @search}
    @subview 'tag-list', new TagListView {container: '#right'}
    @search = undefined
  
  createNewEntry: (e, newEntryData = null) ->
    e?.preventDefault()
    @newEntry?.dispose()
    @newEntry = new Entry newEntryData
    @toggleAddButton on
    newEntryView = new EntryView {
      container: @subview('entry-list').el
      containerMethod: 'prepend'
      model: @newEntry
      editing: true
    }
    @newEntry.once 'sync', =>
      @subview('entry-list').collection.unshift @newEntry
      newEntryView.dispose()
      @newEntry = null
  
  cancelNewEntry: ->
    @newEntry?.dispose()
    @newEntry = null
    @toggleAddButton off
    @
  
  toggleAddButton: (state) ->
    $btn = @$el.find '.js-add-entry'
    $txt = $btn.find 'span'
    $ico = $btn.find 'i'
    $btn[(if state is on then 'add' else 'remove') + 'Class'] 'toggled'
    $txt.text $txt.data (if state is on then 'toggle' else 'default') + '-text'
    $ico[(if state is on then 'add' else 'remove') + 'Class'] 'fa-toggle-up'
    $ico[(if state is on then 'remove' else 'add') + 'Class'] 'fa-link'
    @
