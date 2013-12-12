VariationModel = require './base/variation-model'
Tuble = require './tuble'

###*
 * Hob model
 *
 * @type {VariationModel}
###

module.exports = class TubleFull extends Tuble
  @::variationOf(Tuble)
  keys: [
    'id', 'author_id', 'dt_created', 'title', 'description', 'is_place', 'hobs', 'author',
    'location', 'main_image', 'tags', 'images', 'criteria', 'places_trail', 'reviews',
    'changes'
  ]
