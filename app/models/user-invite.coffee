Model = require './base/model'

###*
 * UserInvite model
 *
 * @type {Model}
###

module.exports = class UserInvite extends Model
  urlPath: '../account/user_invite'
  keys: ['id', 'success', 'target_url', 'email']
  isNewVal: false
  
  # We don't need any primary keys or what have you.
  isNew: -> @isNewVal
  
  save: ->
    @isNewVal = true # Always use POST.
    super
  
  destroy: ->
    @isNewVal = false # Always try the DELETE.
    super