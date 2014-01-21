utils = require 'lib/utils'
View = require 'views/base/view'
Tag = require 'models/tag'

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
  
  submitColor: (e) ->
    e?.preventDefault()
    @hideColorPicker()
    @model.set 'color', @$el.find('.color-picker input[name=color]').val()
    @save()
  
  removeColor: (e) ->
    e?.preventDefault()
    @hideColorPicker()
    @model.set 'color', null
    @save()
  
  save: ->
    @model.save().then =>
      @render()
      @model.collection.sort()
  
  toggleColorPicker: ->
    unless @subview('color-picker') then @showColorPicker() else @hideColorPicker()
  
  showColorPicker: ->
    @subview 'color-picker', new ColorPickerView
  
  hideColorPicker: ->
    
