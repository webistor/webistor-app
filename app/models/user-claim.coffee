Model = require './base/model'

###*
 * UserClaim model
 *
 * @type {Model}
###

module.exports = class UserClaim extends Model
  urlPath: 'account/user_claim'
  keys: ['user_id', 'claim_key', 'username', 'password1', 'password2']