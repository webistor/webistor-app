Model = require './base/model'

module.exports = class Tag extends Model
  getColor: -> "#" + @get 'color'
