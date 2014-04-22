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
    'change #l_tags': -> @updateTags()
    'keydown #l_tags': (e) -> @updateTags() if e.which is 188

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
    @updateTags()

  disableEdit: (e) ->
    e?.preventDefault()
    return unless @editing
    @trigger 'edit:off'
    @updateTags false
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
   * @return {Array} An array of the Tag models created (or used) by this entry.
  ###
  updateTags: (add = true) ->
    tagNames = @parseTags()
    tags = @collect 'tag-collection'
    tags.remove tags.filter (tag) -> tag.isNew() and (tag.get 'title') in tagNames
    ownTags = []
    ownTags.push (tags.findWhere {title}) or (tags.add {title}) for title in tagNames if add
    tags.sort()
    return ownTags

  ###*
   * Patch the global tag collection, set references to the tags in our model and save the model.
   *
   * @return {promise/A} A jQuery 1.8 promise.
  ###
  save: (e) ->
    e?.preventDefault()

    tags = @collect('tag-collection')
    ownTags = @updateTags()

    (if ownTags.length > 0 then tags.patch().then(=>
      tagIds = _.map ownTags, (t) -> t.id
      @model.set 'tags', tagIds
      @model.save()
    )

    else @model.save())

    .then => @disableEdit()

  ###*
   * Disable edit mode before disposing to ensure tags are cleaned up.
  ###
  dispose: ->
    @disableEdit()
    super
