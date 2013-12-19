PageView = require 'views/base/page-view'
Entry = require 'models/entry'
EntryView = require './entry-view'
EntryListView = require './entry-list-view'

module.exports = class HistoryPageView extends PageView
  autoRender: true
  className: 'history-page'
  template: require './templates/history'
  
  events:
    'submit #search-form': 'doSearch'
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

    @subview('add-entry').$el.toggle()#TODO Append class to .edit-entry-form wrapper div.
    @subview('add-entry').$el.find('input:eq(0)').focus()

    # Toggle button text
    
    btn = $(e.target).closest('a')
    txt = btn.find('span');
    ico = btn.find('i');

    if( $(@subview('add-entry').$el).is(':visible') )
      txt.text(txt.data('toggle-text'));
      ico.removeClass('fa-link').addClass('fa-toggle-up');
      btn.addClass('toggled')
    
    else
      txt.text(txt.data('default-text'));
      ico.removeClass('fa-toggle-up').addClass('fa-link');
      btn.removeClass('toggled')
  
  doSearch: (e) ->
    e.preventDefault()
    @subview('entry-list').search($(e.target).find('input[name=search]').val())
