Collection = require './collection'

module.exports = class SyncCollection extends Collection
  
  _.extend @::, Chaplin.SyncMachine
  
  initialize: ->
    @on 'request', @beginSync
    @on 'sync', @finishSync
    @on 'error', @unsync
    super
