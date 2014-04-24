Regulator = require 'regulators/base/regulator'
mediator = require 'mediator'

module.exports = class CollectionRegulator extends Regulator
  name: 'collection'

  collections: null
  reuse: Chaplin.Controller::reuse

  initialize: ->
    @collections = {}
    mediator.setHandler (@_eventName '#collect'), @collect, this
    mediator.setHandler (@_eventName '#fetch'), @fetch, this

  collect: (name) ->
    return @collectAll name if name instanceof Array
    throw new Error "Collection #{name} not found." unless name of @collections
    return @collections[name]

  collectAll: (names) ->
    return (@collect name for name in names)

  fetch: (name) ->
    return @fetchAll name if name instanceof Array
    Collection = require "models/#{name}"
    @listenTo (@collections[name] = item = new Collection), 'dispose', => @remove name
    return @reuse name, ->
      @item = item
      @item.fetch()

  fetchAll: (names) ->
    return (@fetch name for name in names)

  remove: (name) ->
    delete @collections[name]

  dispose: ->
    return if @disposing
    @disposing = true
    col.dispose() for name, col of @collections
    super
