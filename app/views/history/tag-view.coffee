utils = require 'lib/utils'
View = require 'views/base/view'
Tag = require 'models/tag'
ColorPickerView = require 'views/modules/color-picker-view'


module.exports = class TagView extends View
  className: 'tag-row'
  autoRender: true
  template: require './templates/tag'
  
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
    data.ball_size = (4*score).toPrecision 2
    data.ball_margin = (score/2).toPrecision 2
    data
  
  clickPicker: (e) ->
    e?.preventDefault()
    @toggleColorPicker()
  
  setColor: (color) ->
    @color = color
    @$('.picker-trigger').css 'color', color
  
  revertColor: ->
    @color = @model.get 'color'
    @$('.picker-trigger').css 'color', (@model.get 'color') or ''
  
  save: ->
    @hideColorPicker()
    @model.set 'color', @color
    @model.save().then =>
      @render()
      @model.collection.sort()
  
  toggleColorPicker: ->
    if not @subview('color-picker') or @subview('color-picker').disposed
      @showColorPicker()
    else
      @hideColorPicker()
      @revertColor()
  
  showColorPicker: ->
    picker = @subview 'color-picker', new ColorPickerView
      color: @model.get 'color'
      arrow: 'right'
      css:
        top: @$el.offset().top
        right: 270
    
    picker.on 'changeColor', (color) => @setColor color
    picker.on 'applyColor', (color) => @setColor color; @save()
    picker.on 'removeColor', => @setColor null; @save()
    
  hideColorPicker: ->
    @subview('color-picker')?.dispose()
