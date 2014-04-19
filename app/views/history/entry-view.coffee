utils = require 'lib/utils'

View = require 'views/base/view'
Entry = require 'models/entry'

module.exports = class EntryView extends View
  className: 'entry'
  autoRender: true
  editing: false
  focus: 'title'

  bindings:
    '#l_title': 'title'
    '#l_url': 'url'
    '#l_tags': 'rawTags'
    '#l_notes': 'notes'

  events:
    'click': 'clickEntry'
    'dblclick': 'enableEdit'
    'click .tag': 'clickTag'
    'click .js-edit': 'enableEdit'
    'click .js-cancel': 'disableEdit'
    'click .js-delete': 'delete'
    'submit form': 'save'

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
    e?.preventDefault()
    return if @editing
    @trigger 'edit:on'
    @editing = true
    @render()

  disableEdit: (e) ->
    e?.preventDefault()
    return unless @editing
    @trigger 'edit:off'
    @editing = false
    @render()

  clickEntry: (e) ->
    $('.entry').removeClass('active')
    $(e.target).addClass('active')

  clickTag: (e, data) ->
    e?.preventDefault()
    @publishEvent '!search:extend', "##{$(e.target).text()}"

  delete: (e) ->
    e?.preventDefault()
    if confirm 'Destroy this historical piece of data?' then @model.destroy()

  save: (e) ->
    e?.preventDefault()
    @model.save().then => @disableEdit()
