utils = require 'lib/utils'
View = require 'views/base/view'
Tag = require 'models/tag'
ColorPickerView = require 'views/modules/color-picker-view'


module.exports = class TagView extends View
  className: 'tag-row'
  autoRender: true
  template: require './templates/tag'

  listen:
    'change model': 'render'

  events:
    'click .picker-trigger': 'clickPicker'

  getTemplateData: ->
    data = super
    collection = @model.collection
    total = collection.reduce ((a, b) => a + parseInt (b.get 'num'), 10), 0
    scale = (data.num / total) * 1000
    score1 = scale / (3 + 0.03 * scale)
    score2 = data.num / (3 + 0.03 * data.num)
    score = (score1 + score2) / ((100 / 3) * 2)
    data.ball_size = (3*score+0.75).toPrecision 2
    data

  clickPicker: (e) ->
    e?.preventDefault()
    @toggleColorPicker()

  setColor: (color) ->
    @color = color
    @$('.picker-trigger').css 'color', color

  revertColor: ->
    @color = @model.get 'color'
    @$('.picker-trigger').css 'color', @color or ''

  save: ->
    @model.set 'color', @color
    @hideColorPicker()
    @model.save().then =>
      @render()
      @model.collection.sort()

  toggleColorPicker: ->
    if @subview('color-picker') then @hideColorPicker() else @showColorPicker()

  showColorPicker: ->
    return false if @model.isNew()
    picker = @subview 'color-picker', new ColorPickerView
      color: @model.get 'color'
      arrow: 'right'
      css:
        top: @$el.offset().top
        right: 270

    picker.on 'changeColor', (color) => @setColor color
    picker.on 'applyColor', (color) => @setColor color; @save()
    picker.on 'removeColor', => @setColor null; @save()
    picker.on 'dispose', => @revertColor()

  hideColorPicker: ->
    @removeSubview 'color-picker'
