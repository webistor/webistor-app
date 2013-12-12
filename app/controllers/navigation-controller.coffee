Controller = require 'controllers/base/controller'
NavigationView = require 'views/navigation/navigation-view'

module.exports = class NavigationController extends Controller
  
  initialize: ->
    @show()
  
  show: ->
    @view = new NavigationView
