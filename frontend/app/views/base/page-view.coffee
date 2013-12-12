View = require './view'

module.exports = class PageView extends View
  
  autoRender: true
  region: 'main'
  
  getNavigationData: ->
    {}

  render: ->
    super
    @publishEvent 'navigation:change', @getNavigationData()
