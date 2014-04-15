mediator = require 'mediator'

# The application object.
module.exports = class Application extends Chaplin.Application
  
  initMediator: ->
    mediator.user = null
    mediator.regulators = {}
    super
