Model = require './base/model'

module.exports = class UserInvite extends Model
  
  urlPath: 'session/invite'
  
  # We don't need any primary keys or what have you.
  isNewVal: false
  isNew: -> @isNewVal
  
  save: ->
    @isNewVal = true # Always use POST.
    super
  
  destroy: ->
    @isNewVal = false # Always try the DELETE.
    super
