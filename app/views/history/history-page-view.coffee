PageView = require 'views/base/page-view'
Entry = require 'models/entry'
EntryView = require './entry-view'
EntryListView = require './entry-list-view'

module.exports = class HistoryPageView extends PageView
  autoRender: true
  className: 'history-page'
  template: require './templates/history'
  
  events:
    'click .js-add-entry': 'toggleAdd'
  
  render: ->
    super
    
    addEntry = new EntryView {container: this.el, model:new Entry, editing:true};
    entryList = new EntryListView {container: this.el};
    addEntry.listView = entryList;
    
    @subview 'add-entry', addEntry
    @subview 'entry-list', entryList
  
  edit: (id) ->
    entry = new Entry
    @subview('add-entry').model = entry
    entry.set 'id', id
    entry.fetch().then @subview('add-entry').render
    @subview('add-entry').$el.show()
  
  toggleAdd: (e) ->
    e.preventDefault()
    @subview('add-entry').$el.toggle()