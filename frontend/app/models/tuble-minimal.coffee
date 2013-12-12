VariationModel = require './base/variation-model'
Tuble = require './tuble'

###*
 * Hob model
 *
 * @type {VariationModel}
###

module.exports = class TubleMinimal extends VariationModel
  @::variationOf(Tuble)
  keys: ['id', 'author_id', 'dt_created', 'title', 'description', 'is_place']
  urlPath: 'tubles/minimal'
