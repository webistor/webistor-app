utils = require 'lib/utils'

View = require 'views/base/view'
Tag = require 'models/tag'

module.exports = class TagView extends View
  className: 'tag-row'
  autoRender: true
  
  events:
    'click .tag': 'clickTag'
  
  getTemplateFunction: ->
    return require './templates/tag'

  render: ->
    super

  clickTag: (e, data) ->
    
    if e
      e.preventDefault()

    $('#search-form').find('input').val( $(e.target).text() ).end().trigger('submit');