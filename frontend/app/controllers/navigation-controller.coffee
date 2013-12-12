Controller = require 'controllers/base/controller'
NavigationView = require 'views/navigation/navigation-view'
NavigationItem = require 'models/navigation-item'
Collection = require 'models/base/collection'

module.exports = class NavigationController extends Controller
  
  initialize: ->
    @show()
  
  show: ->
    @items = new Collection null,
      model: NavigationItem
      urlPath: 'navigation'
    @view = new NavigationView {collection: @items}
    @items.set [
      {id:1, title:'test1'}
      {id:2, title:'test2'}
      {id:3, title:'test3'}
      {id:4, title:'test4'}
    ]
