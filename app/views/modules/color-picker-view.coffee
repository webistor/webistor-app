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
    'click .slide-control :first:not(.disabled)': 'showPalette'
    'click .slide-control :last:not(.disabled)': 'showSpectrum'
    'click .color-palette li': 'clickPalette'

  initialize: (o) ->
    @color = @activeColor = o.color or @color
    @arrowPosition = o.arrow or @arrowPosition
    @css = o.css or @css
    window.test = this
    super

  getTemplateData: ->
    return color:@color

  render: ->
    super
    @$('.box').addClass "arrow-#{@arrowPosition}" if @arrowPosition?
    @$el.css @css
    @farbtastic = $.farbtastic (@$el.find '.color-spectrum'), (color) => @onChange color
    @farbtastic.setColor @color if @color?
    @showPalette()

  showPalette: (e) ->
    e?.preventDefault()
    @$('.slide-control :first').addClass 'disabled'
    @$('.slide-control :last').removeClass 'disabled'
    @$('.color-spectrum').hide()
    @$('.color-palette li.active').removeClass 'active'
    @$(".color-palette li[data-color=#{@activeColor}]").addClass 'active'
    @$('.color-palette').show()

  showSpectrum: (e) ->
    e?.preventDefault()
    @$('.slide-control :first').removeClass 'disabled'
    @$('.slide-control :last').addClass 'disabled'
    @$('.color-palette').hide()
    @$('.color-spectrum').show()

  clickPalette: (e) ->
    @$('.color-palette li.active').removeClass 'active'
    $(e.target).addClass 'active'
    @onChange $(e.target).data 'color'

  onChange: (color) ->
    if color is @color then return @showRemoveButton()
    @$('input[name=color]').val color
    @$('.color-preview').css 'color', color
    @farbtastic.setColor color
    @activeColor = color
    @showApplyButton()
    @trigger 'changeColor', color

  showRemoveButton: ->
    @$('input[name=apply]').addClass('hidden')
    @$('input[name=remove]').removeClass('hidden')

  showApplyButton: ->
    @$('input[name=apply]').removeClass('hidden')
    @$('input[name=remove]').addClass('hidden')

  applyColor: (e) ->
    e?.preventDefault()
    @color = @farbtastic.color
    @trigger 'applyColor', @color

  removeColor: (e) ->
    e?.preventDefault()
    @color = null
    @farbtastic.setColor '#000000'
    @trigger 'removeColor'
