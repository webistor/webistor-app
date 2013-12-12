module.exports =
  
  autoRender: true
  autoAttach: false
  tagName: 'div'
  region: 'openTabs'
  
  show: ->
    @attach()
  
  hide: ->
    @$el.detach()
