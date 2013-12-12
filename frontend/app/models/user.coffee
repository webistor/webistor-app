VariationModel = require './base/variation-model'

###*
 * User model
 *
 * @type {VariationModel}
###

module.exports = class User extends VariationModel
  urlPath: 'user'
  keys: [
    'id'
  ]
