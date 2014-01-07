PageView = require 'views/base/page-view'
Entry = require 'models/entry'
EntryView = require './entry-view'
EntryListView = require './entry-list-view'
TagListView = require './tag-list-view'

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
    tagList = new TagListView {container: '#right'};#TODO
    
    @subview 'add-entry', addEntry
    @subview 'entry-list', entryList
    @subview 'tag-list', tagList

  edit: (id) ->
    entry = new Entry
    @subview('add-entry').model = entry
    entry.set 'id', id
    entry.fetch().then @subview('add-entry').render
    @subview('add-entry').$el.show()
  
  toggleAdd: (e, data) ->
    
    if e
      e.preventDefault()

    @subview('add-entry').$el.toggle()#TODO Append class to .edit-entry-form wrapper div.
    @subview('add-entry').$el.find('input:eq(0)').focus()

    # Toggle button text
    
    btn = $('.js-add-entry')
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

    # Fill form with data from query string.
    if(typeof data == 'object')

      @subview('add-entry').$el.find('#l_title').val(data.title);
      @subview('add-entry').model.set 'title', data.title;
      @subview('add-entry').$el.find('#l_url').val(data.url);
      @subview('add-entry').model.set 'url', data.url;

  doSearch: (e) ->
    e.preventDefault()
    @subview('entry-list').search($(e.target).find('input[name=search]').val())
