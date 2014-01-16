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
    'submit #search-form': 'submitSearch'
    'click .js-add-entry:not(.toggled)': 'createNewEntry'
    'click .js-add-entry.toggled': 'cancelNewEntry'
  
  render: ->
    super
    @subview 'entry-list', new EntryListView {container: this.el}
    @subview 'tag-list', new TagListView {container: '#right'}
    @handleKeyboardShortcuts()
  
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
  
  focusSearch: (e) ->
    e?.preventDefault()
    @$el.find('input[name=search]').focus()

  submitSearch: (e) ->
    e.preventDefault()
    query = $(e.target).find('input[name=search]').val()
    @subview('entry-list').search query

  # Keyboard shortcuts handler.
  # Shortcut code overview: http://www.catswhocode.com/blog/using-keyboard-shortcuts-in-javascript
  handleKeyboardShortcuts: ->
    
    $bar = @$el.find('input[name=search]')

    $(document).keydown (e) =>
      
      # Focus the search bar when slash is pressed outside of a focussed element.
      @focusSearch(e) if e.which is 191 and $(document).has(':focus').length is 0
      
      # Blur the search bar when the escape key is pressed in it.
      $bar.blur() if ($bar.is ':focus') and e.which is 27  
