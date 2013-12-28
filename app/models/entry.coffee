Model = require './base/model'
VariationModel = require './base/variation-model'

###*
 * Entry model
 *
 * @type {VariationModel}
###

module.exports = class Entry extends Model
  urlPath: 'webhistory/entries'
  keys: ['id', 'title', 'url', 'dt_created', 'user_id', 'group_id', 'quotes', 'notes', 'location', 'context', 'song', 'tags']