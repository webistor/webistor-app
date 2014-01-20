View = require './base/view'
Me = require 'models/me'
utils = require 'lib/utils'

module.exports = class MenuView extends View
  
  region: 'nav'
  className: 'menu'
  template: require './templates/menu'
  
  listen:
    'session:login mediator': 'login'
    'session:logout mediator': 'logout'
    'search mediator': 'updateSearch'
  
  events:
    'submit #search-form': 'submitSearch'
  
  initialize: ->
    @model = new Me
    @model.fetch().then => @render()
    super
    @handleKeyboardShortcuts()
  
  getTemplateData: ->
    data = super
    data.search = @search
    data
  
  login: ->
    @model.fetch().then => @render()
  
  logout: ->
    @model = new Me
    @render()
  
  focusSearch: (e) ->
    e?.preventDefault()
    @$el.find('input[name=search]').focus()
  
  submitSearch: (e) ->
    e.preventDefault()
    query = $.trim $(e.target).find('input[name=search]').val()
    return utils.redirectTo url: "" if query is '' or not query
    query = encodeURIComponent query
    utils.redirectTo url: "search/#{query}"
  
  updateSearch: (query) ->
    @search = query
    @$el.find('input[name=search]').val query
  
  # Shortcut code overview: http://www.catswhocode.com/blog/using-keyboard-shortcuts-in-javascript
  handleKeyboardShortcuts: ->
    $bar = @$el.find('input[name=search]')
    $(document).keydown (e) =>
      @focusSearch(e) if e.which is 191 and $(document).has(':focus').length is 0
      $bar.blur() if ($bar.is ':focus') and e.which is 27
