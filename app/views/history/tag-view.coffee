utils = require 'lib/utils'

View = require 'views/base/view'
Tag = require 'models/tag'

module.exports = class TagView extends View
  className: 'tag-row'
  autoRender: true
  template: require './templates/tag'
  
  events:
    'click .tag': 'clickTag'
    'click .picker-trigger': 'clickPicker'
    'submit .color-picker': 'submitColor'
    'click .remove-color': 'removeColor'
  
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
  
  clickTag: (e) ->
    e?.preventDefault()
    $('#search-form').find('input').val( $(e.target).text() ).end().trigger('submit');
  
  clickPicker: (e) ->
    e?.preventDefault()
    @toggleColorPicker()
  
  submitColor: (e) ->
    e?.preventDefault()
    color = @$el.find('.color-picker input[name=color]').val()
    @hideColorPicker()
    @model.set 'color', color
    @model.save().then =>
      @render()
      @model.collection.sort()
  
  removeColor: (e) ->
    e?.preventDefault()
    @hideColorPicker()
    @model.set 'color', null
    @model.save().then =>
      @render()
      @model.collection.sort()
  
  toggleColorPicker: ->
    $el = @$el.find('.color-picker')
    if $el.is(':hidden') then @showColorPicker() else @hideColorPicker()
  
  showColorPicker: ->
    @$el.find('.color-picker').show()
  
  hideColorPicker: ->
    @$el.find('.color-picker').hide()
    
