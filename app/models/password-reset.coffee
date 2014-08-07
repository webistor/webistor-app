Model = require './base/model'

module.exports = class PasswordReset extends Model
  path: ''
  url: ->
    base = super
    return base + "users/#{@attributes.id}/password-reset" if @get 'id'
    return base + 'password-reset'