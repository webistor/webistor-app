ModuleView = require './base/module-view'

module.exports = class ColorPickerView extends ModuleView
  
  template: require './templates/color-picker'
  
  className: 'module color-picker over'
  container: 'body'
  
  color: null
  arrowPosition: null
  css: {}
  
  events:
    'submit form': 'applyColor'
    'click input[name=remove]': 'removeColor'
  
  initialize: (o) ->
    @color = o.color or @color
    @arrowPosition = o.arrow or @arrowPosition
    @css = o.css or @css
    super
  
  getTemplateData: ->
    return color:@color
  
  render: ->
    super
    @$el.find('.box').addClass "arrow-#{@arrowPosition}" if @arrowPosition?
    @$el.css @css
    
    @farbtastic = $.farbtastic (@$el.find '.color-spectrum'), (color) =>
      @$el.find('input[name=color]').val color
      @onChange color
    
    @farbtastic.setColor @color if @color?
  
  onChange: (color) ->
    if color is @color then return @showRemoveButton()
    @showApplyButton()
    @trigger 'changeColor', color
  
  showRemoveButton: ->
    @$el.find('input[name=apply]').addClass('hidden')
    @$el.find('input[name=remove]').removeClass('hidden')
  
  showApplyButton: ->
    @$el.find('input[name=apply]').removeClass('hidden')
    @$el.find('input[name=remove]').addClass('hidden')
  
  applyColor: (e) ->
    e?.preventDefault()
    @color = @farbtastic.color
    @onChange()
    @trigger 'applyColor', @color
  
  removeColor: (e) ->
    e?.preventDefault()
    @color = null
    @farbtastic.setColor '#000000'
    @trigger 'removeColor'
