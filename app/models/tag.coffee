Model = require './base/model'

###*
 * Tag model
 *
 * @type {Model}
###

module.exports = class Tag extends Model
  urlPath: 'webhistory/tags'
  idAttribute: 'tag_id'
