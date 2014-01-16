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
    'submit #search-form': 'doSearch'
    'click .js-add-entry:not(.toggled)': 'createNewEntry'
    'click .js-add-entry.toggled': 'cancelNewEntry'
  
  render: ->
    super
    @subview 'entry-list', new EntryListView {container: this.el}
    @subview 'tag-list', new TagListView {container: '#right'}
    @handleKeyboardShortcuts()
    window.test = @
  
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
  
  # edit: (id) ->
  #   entry = new Entry
  #   @subview('add-entry').model = entry
  #   entry.set 'id', id
  #   entry.fetch().then @subview('add-entry').render
  #   @subview('add-entry').$el.show()
  
  toggleAdd: (e, data) ->
    e?.preventDefault()
    
    # Fill form with data from query string.
    if(typeof data == 'object')
      @subview('add-entry').$el.find('#l_title').val(data.title);
      @subview('add-entry').model.set 'title', data.title;
      @subview('add-entry').$el.find('#l_url').val(data.url);
      @subview('add-entry').model.set 'url', data.url;
  
  focusSearch: (e) ->

    # Find search bar.
    bar = @$el.find('input[name=search]')

    # If bar isn't already focussed.
    if( ! bar.is(':focus') )
      # Interrupt the (keyboard) action.
      e.preventDefault()
      # Then focus the search bar.
      bar.focus()

  doSearch: (e) ->
    e.preventDefault()
    # Get search query.
    bar = $(e.target).find('input[name=search]')
    # Call search method with the search term(s) as argument.
    @subview('entry-list').search( $(e.target).find('input[name=search]').val() )

  # Keyboard shortcuts handler.
  handleKeyboardShortcuts: ->
    bar = @$el.find('input[name=search]')

    # Shortcut code overview: http://www.catswhocode.com/blog/using-keyboard-shortcuts-in-javascript
    $(document).keydown (e) =>
      
      # Focus the search bar when slash is pressed outside of a focussed element.
      @focusSearch(e) if e.which is 191 and $(document).has(':focus').length is 0

      # Search bar empty & focussed + Escape?
      if( bar.val() == '' and bar.is(':focus') and e.which == 27)
        # Unfocus.
        bar.blur()
