Model = require './base/model'

module.exports = class Tag extends Model

  ###*
   * Get the colour of the tag with leading `#`.
   *
   * @method getColor
   *
   * @return {String|null} Null when colour was not set.
  ###
  getColor: ->
    color = @get 'color'
    return if color then "##{color}" else null
