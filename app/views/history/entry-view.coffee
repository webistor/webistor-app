utils = require 'lib/utils'

View = require 'views/base/view'
Entry = require 'models/entry'

#TODO: Rewrite this to use create and dispose rather than all sorts of buggy magic.
module.exports = class EntryView extends View
  className: 'entry'
  autoRender: true
  editing: false
  focus: 'title'
  
  bindings:
    '#l_title': 'title'
    '#l_url': 'url'
    '#l_tags': 'rawTags' #TODO: custom getters or some custom binding
    '#l_notes': 'notes'

  events:
    'dblclick': 'enableEdit'
    'click .tag': 'clickTag'
    'click .js-edit': 'enableEdit'
    'click .js-cancel': 'cancel'
    'click .js-delete': 'delete'
    'submit .edit-entry-form': 'save'
  
  initialize: (o) ->
    super
    @editing = o.editing or @editing
    @focus = o.focus or @focus
  
  getTemplateFunction: ->
    return require './templates/edit-entry' if @editing
    return require './templates/entry'
  
  render: ->
    super
    return unless @editing
    @stickit()
    setTimeout (=> @$("#l_#{@focus}").focus()), 10
    
  toggleEdit: (e) ->
    @[if @editing then 'disableEdit' else 'enableEdit'] e
  
  enableEdit: (e) ->
    return if @editing
    e?.preventDefault()
    @editing = true
    @render()
    this.trigger 'editOn'
  
  disableEdit: (e) ->
    return unless @editing
    e?.preventDefault()
    @editing = false
    @render()
    this.trigger 'editOff'
  
  clickTag: (e, data) ->
    e?.preventDefault()
    $('#search-form').find('input').val( $(e.target).text() ).end().trigger('submit')
  
  cancel: (e) ->
    e?.preventDefault?()
    @disableEdit()
  
  delete: ->
    if confirm 'Destroy this historical piece of data?' then @model.destroy()
  
  save: (e) ->
    e?.preventDefault()
    @model.save().then => @disableEdit()
