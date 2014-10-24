utils = require 'lib/utils'
View = require 'views/base/view'
Tag = require 'models/tag'
ColorPickerView = require 'views/modules/color-picker-view'


module.exports = class TagView extends View
  tagName: 'li'
  className: 'cat tag'
  autoRender: true
  template: require './templates/tag'

  listen:
    'change model': 'render'

  events:
    'click .picker-trigger': 'clickPicker'
    'click .tag': 'clickTag'

  getTemplateData: ->
    data = super
    collection = @model.collection
    total = collection.reduce ((a, b) => a + parseInt (b.get 'num'), 10), 0
    scale = (data.num / total) * 1000
    score1 = scale / (3 + 0.03 * scale)
    score2 = data.num / (3 + 0.03 * data.num)
    score = (score1 + score2) / ((100 / 3) * 2)
    data.ball_size = (3*score+0.75).toPrecision 2
    data.color = @model.getColor()
    data

  clickPicker: (e) ->
    e?.preventDefault()
    @toggleColorPicker()

  clickTag: (e, data) ->
    e?.preventDefault()
    e?.stopImmediatePropagation()
    title = @model.get('title')
    @publishEvent '!search:extend', (if title.indexOf(' ') is -1 then "#" else "") + title

  setColor: (color) ->
    @color = color
    @$('.picker-trigger').css 'color', color

  revertColor: ->
    @color = @model.getColor()
    @$('.picker-trigger').css 'color', @color or ''

  save: ->
    @model.set 'color', if @color? then @color.slice 1 else null
    @hideColorPicker()
    @model.save().then =>
      @render()
      @model.collection.sort()

  toggleColorPicker: ->
    if @subview('color-picker') then @hideColorPicker() else @showColorPicker()

  showColorPicker: ->
    return false if @model.isNew()
    picker = @subview 'color-picker', new ColorPickerView
      color: @model.getColor()
      arrow: 'right'
      css:
        top: @$el.position().top
        right: 280

    picker.on 'changeColor', (color) => @setColor color
    picker.on 'applyColor', (color) => @setColor color; @save()
    picker.on 'removeColor', => @setColor null; @save()
    picker.on 'dispose', => @revertColor()

  hideColorPicker: ->
    @removeSubview 'color-picker'
