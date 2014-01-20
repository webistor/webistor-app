utils = require 'lib/utils'

RequireLogin = require 'lib/require-login'
AppView = require 'views/app-view'
PageController = require 'controllers/base/page-controller'
HistoryPageView = require 'views/history/history-page-view'
NavigationController = require 'controllers/navigation-controller'

module.exports = class AppController extends PageController
  
  beforeAction: (params, route) ->
    super
    @compose 'login', RequireLogin
    @compose 'app', AppView
    @compose 'menu', NavigationController
   
  history: (params, route) ->
    @view?.dispose()
    @view = new HistoryPageView
  
  add: (params, route) ->
    Entry = require 'models/entry'
    MessageView = require 'views/message-view'
    EntryView = require 'views/history/entry-view'
    
    @view?.dispose()
    entry = new Entry Chaplin.utils.queryParams.parse route.query
    @view = new EntryView {model: entry, editing:true, region: 'main'}
    
    @view.once 'editOff', =>
      entry.dispose()
      @view = new MessageView {region: 'main', message: 'Added a new entry. :)'}
