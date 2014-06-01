Model = require './base/model'

module.exports = class Invitation extends Model
  path: 'invitations'
  idAttribute: 'token'
