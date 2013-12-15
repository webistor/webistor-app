View = require 'views/base/view'
Entry = require 'models/entry'

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
    if e && e.preventDefault then e.preventDefault()
    @editing = !@editing
    @render()
  
  cancel: (e) ->
    if e && e.preventDefault then e.preventDefault()
    self = this
    @model.fetch().then -> self.toggleEdit()
  
  delete: ->
    if confirm 'Really?' then @model.destroy()
  
  save: (e) ->
    e.preventDefault()
    
    self = this
    if @listView
      
      # Fresh model for this add-view.
      entry = @model
      @model = new Entry
      @toggleEdit()
      
      # Save and send the model to the collection.
      entry.save().then ->
        self.listView.collection.add entry, at:0
        self.listView.renderItem entry
      
    else
      @model.save().then -> self.toggleEdit()
      