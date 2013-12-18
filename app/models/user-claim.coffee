Model = require './base/model'

###*
 * UserClaim model
 *
 * @type {Model}
###

module.exports = class UserClaim extends Model
  urlPath: 'account/user_claim'
  keys: ['userid', 'claimkey', 'password1', 'password2']