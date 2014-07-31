View = require 'views/base/view'

module.exports = class ErrorView extends View
  errorTemplate: require './templates/error'
  autoRender: true
  autoAttach: false
  containerMethod: 'html'
  region: 'error'
  id: 'error'

  events:
    'click': 'hide'

  hideTimeout: null

  initialize: ->
    super
    @errors = []

  showError: (error) ->
    @$el.show()
    if error.message not in @errors
      @$el.append @errorTemplate error
      @errors.push error.message
    @hideAfter 10000

  hideAfter: (ms) ->
    clearTimeout @hideTimeout if @hideTimeout?
    @hideTimeout = setTimeout (=>@hide()), ms

  hide: (e) ->
    e?.preventDefault()
    clearTimeout @hideTimeout if @hideTimeout?
    @hideTimeout = null
    @$el.hide()
    @$el.empty()
    @errors = []
