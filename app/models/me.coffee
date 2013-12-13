Model = require './base/model'

###*
 * Me model
 *
 * @type {Model}
###

module.exports = class Me extends Model
  urlPath: '../account/me'
  keys: ['id', 'email', 'username', 'level', 'login', 'activity']