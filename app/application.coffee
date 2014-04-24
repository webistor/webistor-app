CollectionRegulator = require 'regulators/collection-regulator'
mediator = require 'mediator'

# The application object.
module.exports = class Application extends Chaplin.Application

  initialize: ->
    @initCollectionRegulator()
    super

  initMediator: ->
    mediator.user = null
    mediator.regulators = {}
    super

  initCollectionRegulator: ->
    @collectionRegulator = new CollectionRegulator
