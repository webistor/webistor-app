VariationModel = require './base/variation-model'

###*
 * Hob model
 *
 * @type {VariationModel}
###

module.exports = class Tuble extends VariationModel
  urlPath: 'tuble'
  keys: [
    'id', 'author_id', 'dt_created', 'title', 'description', 'is_place', 'hobs', 'author',
    'location', 'main_image', 'criteria'
  ]
