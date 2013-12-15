Model = require './base/model'

###*
 * UserSession model
 *
 * @type {Model}
###

module.exports = class UserSession extends Model
  urlPath: '../account/user_session'
  keys: ['id', 'success', 'target_url', 'email', 'password']
  isNewVal: false
  
  # We don't need any primary keys or what have you.
  isNew: -> @isNewVal
  
  save: ->
    @isNewVal = true # Always use POST.
    super
  
  destroy: ->
    @isNewVal = false # Always try the DELETE.
    super