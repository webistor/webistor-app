utils = require 'lib/utils'

View = require 'views/base/view'
Tag = require 'models/tag'

module.exports = class TagView extends View
  className: 'tag-row'
  autoRender: true
  
  events:
    'click .tag': 'clickTag'
    'click .num': 'clickNum'
    'submit .color-picker': 'submitColor'
    'click .remove-color': 'removeColor'
  
  getTemplateFunction: ->
    return require './templates/tag'

  clickTag: (e) ->
    e?.preventDefault()
    $('#search-form').find('input').val( $(e.target).text() ).end().trigger('submit');
  
  clickNum: (e) ->
    e?.preventDefault()
    @showColorPicker()
  
  submitColor: (e) ->
    e?.preventDefault()
    color = @$el.find('.color-picker input').val()
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
  
  showColorPicker: ->
    @$el.find('.color-picker').show()
  
  hideColorPicker: ->
    @$el.find('.color-picker').hide()
    
