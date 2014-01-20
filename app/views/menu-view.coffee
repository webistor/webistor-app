View = require './base/view'
Me = require 'models/me'

module.exports = class MenuView extends View
  
  region: 'nav'
  className: 'menu'
  template: require './templates/menu'
  
  listen:
    'session:login mediator': 'login'
    'session:logout mediator': 'logout'
  
  initialize: ->
    @model = new Me
    @model.fetch().then => @render()
    super
  
  login: ->
    @model.fetch().then => @render()
  
  logout: ->
    @model = new Me
    @render()
