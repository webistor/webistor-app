Model = require './base/model'

module.exports = class Entry extends Model
  constructor: ->
    super
    @on 'sync', => @publishEvent 'entry:sync', @
