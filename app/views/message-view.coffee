View = require './base/view'

module.exports = class MessageView extends View
  
  id: 'message'
  className: 'message'
  tagName: 'p'
  autoRender: true
  
  message: 'Success!'
  
  initialize: (o) ->
    @message = o?.message || @message
  
  render: ->
    @$el.text @message
