VariationModel = require './base/variation-model'

###*
 * Hob model
 *
 * @type {VariationModel}
###

module.exports = class Hob extends VariationModel
  urlPath: 'hobs'
  keys: ['id', 'title']
