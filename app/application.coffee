CollectionRegulator = require 'regulators/collection-regulator'
ErrorRegulator = require 'regulators/error-regulator'
mediator = require 'mediator'

# The application object.
module.exports = class Application extends Chaplin.Application

  initialize: (options = {}) ->
    throw new Error 'Application#initialize: App was already started' if @started
    @initRouter options.routes, options
    @initDispatcher options
    @initLayout options
    @initComposer options
    @initMediator()
    @initRegulators()
    @start()

  initMediator: ->
    mediator.user = null
    mediator.regulators = {}
    super

  initRegulators: ->
    @collectionRegulator = new CollectionRegulator
    @errorRegulator = new ErrorRegulator
