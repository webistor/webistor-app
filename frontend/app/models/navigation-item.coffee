VariationModel = require './base/variation-model'
Hob = require './hob'

###*
 * Navigation model
 *
 * @type {VariationModel}
###

module.exports = class NavigationItem extends VariationModel
  @::variationOf Hob
  urlPath: 'hobs/minimal'
  keys: ['id', 'title']
