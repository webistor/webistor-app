# The application object.
module.exports = class Application extends Chaplin.Application
  
  initMediator: ->
    Chaplin.mediator.user = null
    super
