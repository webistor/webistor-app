utils = require 'lib/utils'

View = require 'views/base/view'
Entry = require 'models/entry'

module.exports = class EntryView extends View

  # Properties.
  className: 'entry'
  autoRender: true
  editing: false
  focus: 'title'
  dirty: null
  oldTitle: null

  # 2-Way data bindings.
  bindings:
    '#l_title': 'title'
    '#l_url': 'url'
    '#l_tags': observe: 'tags', onGet: 'getTemplateTags', updateModel: false
    '#l_notes': 'description'

  # UI events.
  events:
    'click': 'clickEntry'
    'dblclick': 'enableEdit'
    'click .tag': 'clickTag'
    'click .js-edit': 'enableEdit'
    'click .js-close': 'disableEdit'
    'click .js-discard': 'revertEdit'
    'click .js-delete': 'delete'
    'submit form': 'save'
    'change #l_tags': -> @updateTags()
    'keydown #l_tags': (e) -> @updateTags() if e.which is 188

  # Internal events.
  listen:
    'change model': 'setDirty'
    'sync model': 'setClean'

  initialize: (o) ->
    super
    @editing = o.editing or @editing
    @focus = o.focus or @focus
    @oldTitle = o.oldTitle or @oldTitle
    tags = @collect 'tag-collection'
    @listenTo tags, 'change', (tag) => @render() if tag.id in @model.get 'tags'

  getTemplateFunction: ->
    return require './templates/edit-entry' if @editing
    return require './templates/entry'

  getTemplateData: ->
    data = super
    tags = @collect 'tag-collection'
    data.oldTitle = @oldTitle unless @oldTitle is data.title
    data.tags = _.map data.tags, (tag) ->
      tag = tags.get(tag)
      r = tag.serialize()
      r.color = tag.getColor()
      return r

    data.dirty = @isDirty()
    return data

  getTemplateTags: (val) ->
    tags = @collect 'tag-collection'
    _.map(val, (id) -> tags.get(id).get 'title').join ', '

  render: ->
    super
    return unless @editing
    @stickit()
    if @isDirty() then @setDirty() else @setClean()
    setTimeout (=> @$("#l_#{@focus}").focus()), 10

  toggleEdit: (e) ->
    @[if @editing then 'disableEdit' else 'enableEdit'] e

  enableEdit: (e) ->
    e?.preventDefault()
    return if @editing
    @trigger 'edit:on'
    @editing = true
    @render()
    @updateTags()

  disableEdit: (e) ->
    e?.preventDefault()
    return unless @editing
    @trigger 'edit:off'
    @updateTags false
    @editing = false
    @render()

  revertEdit: (e) ->
    e?.preventDefault()
    if window.confirm 'Are you sure you want to discard changes?'
      @disableEdit()
      @model.fetch().then @render.bind this

  clickEntry: (e) ->
    $('.entry').removeClass('active')
    $(e.target).addClass('active')

  clickTag: (e, data) ->
    e?.preventDefault()
    e?.stopImmediatePropagation()
    title = $(e.target).text()
    @publishEvent '!search:extend', (if title.indexOf(' ') is -1 then "#" else "") + title

  delete: (e) ->
    e?.preventDefault()
    if confirm 'Destroy this historical piece of data?'
      @model.destroy().then => @collect('tag-collection').fetch()

  ###*
   * Parse the raw tags from the input field into an array of tag names.
   *
   * @return {Array}
  ###
  parseTags: ->
    tagNames = @$('#l_tags').val().split(',')
    tagNames = _.filter tagNames, trim = (name) -> $.trim name
    tagNames = _.map tagNames, trim
    return tagNames

  ###*
   * Parse raw tags and create Tag models in the global tag-collection.
   *
   * @param {Boolean} add Set to false to prevent adding new tags to the collection.
   *
   * @return {Array} An array of the Tag models created by this entry.
  ###
  updateTags: (add = true) ->
    tagNames = @parseTags()
    tags = @collect 'tag-collection'
    tags.remove tags.filter (tag) -> tag.isNew() and (tag.get 'title') in tagNames
    added = []
    added.push tags.add {title} for title in tagNames when not tags.findWhere {title} if add
    tags.sort()
    return added

  ###*
   * Patch the global tag collection, set references to the tags in our model and save the model.
   *
   * @return {promise/A} A jQuery 1.8 promise.
  ###
  save: (e) ->
    e?.preventDefault()
    tags = @collect('tag-collection')
    @updateTags()
    tags.patch().then(=>
      ownTags = _.map @parseTags(), (title) -> return tags.findWhere {title}
      @model.set 'tags', _.map ownTags, (tag) -> tag.id
      @model.save()
    )
    .then =>
      @disableEdit()
      tags.fetch().then -> tags.sort()

  setDirty: ->
    @$el.addClass 'dirty'
    @dirty = true

  setClean: ->
    @$el.removeClass 'dirty'
    @dirty = false

  isDirty: ->
    @dirty is true

  ###*
   * Disable edit mode before disposing to ensure tags are cleaned up.
  ###
  dispose: ->
    @disableEdit()
    super
