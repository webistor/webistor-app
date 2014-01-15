Model = require './base/model'

###*
 * Entry model
 * 
 * @type {Model}
###

module.exports = class Entry extends Model
  urlPath: 'webhistory/entries'
  
  constructor: ->
    super
    @on 'sync', => @publishEvent 'entry:sync', @
