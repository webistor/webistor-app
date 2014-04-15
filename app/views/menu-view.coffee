View = require './base/view'
Me = require 'models/me'
utils = require 'lib/utils'
mediator = require 'mediator'

module.exports = class MenuView extends View

  region: 'nav'
  className: 'menu'
  template: require './templates/menu'

  listen:
    'session:loginStatus mediator': 'render'
    'search:search mediator': 'updateSearch'

  events:
    'submit #search-form': 'submitSearch'
    'click .js-logout': 'doLogout'

  initialize: ->
    super
    @handleKeyboardShortcuts()

  getTemplateData: ->
    mediator.user?.serialize() or {}

  doLogout: (e) ->
    @publishEvent '!session:logout'

  focusSearch: (e) ->
    e?.preventDefault()
    @$('input[name=search]').focus()

  submitSearch: (e) ->
    e.preventDefault()
    query = $.trim $(e.target).find('input[name=search]').val()
    @publishEvent '!search:search', query

  updateSearch: (data) ->
    @$('input[name=search]').val data.processed

  # Shortcut code overview: http://www.catswhocode.com/blog/using-keyboard-shortcuts-in-javascript
  handleKeyboardShortcuts: ->
    $bar = @$('input[name=search]')
    $(document).keydown (e) =>
      @focusSearch(e) if e.which is 191 and $(document).has(':focus').length is 0
      $bar.blur() if ($bar.is ':focus') and e.which is 27
