View = require 'views/base/view'

module.exports = class ModuleView extends View
  
  autoRender: true
  className: 'module'
  
  initialize: ->
    super
    @subscribeEvent 'module:render', (module) => @dispose() unless module is this
  
  render: ->
    @publishEvent 'module:render', this
    super
