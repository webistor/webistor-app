PageController = require 'controllers/base/page-controller'
HomePageView = require 'views/home/home-page-view'

module.exports = class HomeController extends PageController

  show: ->
    @view = new HomePageView
