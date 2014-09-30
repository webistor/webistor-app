mediator = require 'mediator'

module.exports = class Controller extends Chaplin.Controller

  collect: -> mediator.execute 'collection:fetch', arguments...
