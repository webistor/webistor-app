PageView = require 'views/base/page-view'
Entry = require 'models/entry'
EntryView = require './entry-view'
EntryListView = require './entry-list-view'
TagListView = require './tag-list-view'
TagCollection = require 'models/tag-collection'

module.exports = class HistoryPageView extends PageView
  autoRender: true
  className: 'history-page'
  template: require './templates/history'
  newEntry: null
  
  events:
    'click .js-add-entry:not(.toggled)': 'createNewEntry'
    'click .js-add-entry.toggled': 'cancelNewEntry'
    'click .pro-tip .dismiss': 'hideProTip'
  
  render: ->
    
    # Do standard rendering.
    super
    
    # Create sub-collections.
    tags = new TagCollection
    
    # Create the sub-view for the list of entries, passing it the collection.
    entriesView = @subview 'entry-list', new EntryListView
      container: this.el
      collection: entries
    
    # Create the sub-view for the list of tags, passing it the collection.
    tagsView = @subview 'tag-list', new TagListView
      container: '#right'
      collection: tags
    
    # Get the tags view to listen to changes in the tags on the entry models.
    # When anything concerning the tags changes, refresh the whole collection.
    entries.once 'sync', ->
      tagsView.listenTo entries, 'change:tags add remove', ->
        @resetCollection()
    
    # Get the entry view to listen to the color property on tag models.
    entriesView.listenTo tags, 'change:color', (tag) ->
      
      # Find all entries that contain the changed tag.
      affectedEntries = entries.filter (entry) ->
        _(entry.get 'tags').any (one) -> one.id is tag.get 'tag_id'
      
      # Update the entry's tag-data and re-render.
      _(affectedEntries).each (entry) ->
        tags = _.clone entry.get 'tags'
        one.color = tag.get 'color' for one in tags when one.id is tag.get 'tag_id'
        entry.set 'tags', tags, silent:true
        entriesView.renderItem entry

    @showProTip()
  
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
      @toggleAddButton off
      @subview('entry-list').collection.unshift @newEntry
      newEntryView.dispose()
      @newEntry = null
  
  cancelNewEntry: ->
    @newEntry?.dispose()
    @newEntry = null
    @toggleAddButton off
    this
  
  toggleAddButton: (state) ->
    $btn = @$el.find '.js-add-entry'
    $txt = $btn.find 'span'
    $ico = $btn.find 'i'
    $btn[(if state is on then 'add' else 'remove') + 'Class'] 'toggled'
    $txt.text $txt.data (if state is on then 'toggle' else 'default') + '-text'
    $ico[(if state is on then 'add' else 'remove') + 'Class'] 'fa-toggle-up'
    $ico[(if state is on then 'remove' else 'add') + 'Class'] 'fa-link'
    this

  supportsLocalStorage: ->
    # try{
    #   return 'localStorage' in window && window['localStorage'] !== null;
    # }catch(e){
    #   return false;
    # }
    return true;

  # SHOW PRO TIP IF NEVER HIDDEN
  showProTip: (force) ->
    return false if !@supportsLocalStorage()
    if( ! localStorage['app.preferences.hide_pro_tip.bookmarklet'] )
      @$el.find('.pro-tip').show()

  hideProTip: ->
    localStorage['app.preferences.hide_pro_tip.bookmarklet'] = new Date().getTime();
    @$el.find('.pro-tip').hide()
