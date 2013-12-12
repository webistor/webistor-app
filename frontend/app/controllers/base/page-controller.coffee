SiteView = require 'views/site-view'
Controller = require './controller'
NavigationController = require 'controllers/navigation-controller'

module.exports = class PageController extends Controller

  beforeAction: ->
    @compose 'site', SiteView
    @compose 'menu', NavigationController
