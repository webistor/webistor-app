module.exports =
  
  autoRender: true
  autoAttach: false
  tagName: 'div'
  region: 'activePanel'
  containerMethod: 'html'
  
  listen:
    'panel:close mediator': 'hide'
  
  show: ->
    @attach()
  
  hide: ->
    @$el.detach()
