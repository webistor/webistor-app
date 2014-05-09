Model = require './base/model'

module.exports = class UserSession extends Model
  
  urlPath: 'session/getUser'
  
  # We don't need any primary keys or what have you.
  isNewVal: false
  isNew: -> @isNewVal
  
  save: ->
    @isNewVal = true # Always use POST.
    super
  
  destroy: ->
    @isNewVal = false # Always try the DELETE.
    super
