RequireLogin = require 'lib/require-login'
AppView = require 'views/app-view'
PageController = require 'controllers/base/page-controller'
HistoryPageView = require 'views/history/history-page-view'
NavigationController = require 'controllers/navigation-controller'

module.exports = class AppController extends PageController
  
  beforeAction: ->
    super
    @compose 'login', RequireLogin
    @compose 'app', AppView
    @compose 'menu', NavigationController
    
  history: ->
    @view = @view || new HistoryPageView