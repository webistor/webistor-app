Model = require './base/model'
VariationModel = require './base/variation-model'

###*
 * Tag model
 *
 * @type {VariationModel}
###

module.exports = class Tag extends Model
  urlPath: 'webhistory/tags'
  keys: ['id', 'title']
