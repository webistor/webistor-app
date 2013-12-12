VariationModel = require './base/variation-model'
User = require './user'

###*
 * (Full) User model
 *
 * @type {VariationModel}
###

module.exports = class UserFull extends User
  @::variationOf(User)
  keys: [
    'id'
  ]
