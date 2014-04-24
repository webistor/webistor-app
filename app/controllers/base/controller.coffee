mediator = require 'mediator'

module.exports = class Controller extends Chaplin.Controller

  collect: ->
    $.when.apply $, mediator.execute 'collection:fetch', arguments...
