utils = require 'lib/utils'

View = require 'views/base/view'
Entry = require 'models/entry'

#TODO: Rewrite this to use create and dispose rather than all sorts of buggy magic.
module.exports = class EntryView extends View
  className: 'entry'
  autoRender: true
  editing: false
  
  bindings:
    '#l_title': 'title'
    '#l_url': 'url'
    '#l_tags': 'rawTags' #TODO: custom getters or some custom binding
    '#l_notes': 'notes'

  events:
    'click .tag': 'clickTag'
    'click .js-edit': 'toggleEdit'
    'click .js-cancel': 'cancel'
    'click .js-delete': 'delete'
    'submit .edit-entry-form': 'save'
  
  getTemplateFunction: ->
    return require './templates/edit-entry' if @editing
    return require './templates/entry'
  
  render: ->
    @editing = !@model.id || @editing
    super
    @stickit() if @editing
    @$el.hide() unless @model.id
  
  toggleEdit: (e) ->
    e?.preventDefault?()
    @editing = !@editing
    @render()
  
  clickTag: (e, data) ->
    e?.preventDefault()
    $('#search-form').find('input').val( $(e.target).text() ).end().trigger('submit');
  
  cancel: (e) ->
    e?.preventDefault?()
    @model.fetch().then => @toggleEdit()
  
  delete: ->
    if confirm 'Destroy this historical piece of data?' then @model.destroy()
  
  save: (e) ->
    e.preventDefault()
    
    if @listView
      
      # Fresh model for this add-view.
      entry = @model
      @model = new Entry
      @toggleEdit()
      
      # Save and send the model to the collection.
      entry.save().then =>
        @listView.collection.add entry, at:0
        @listView.renderItem entry
      
    else
      @model.save().then => @toggleEdit()
      
