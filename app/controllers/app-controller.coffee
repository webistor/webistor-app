utils = require 'lib/utils'

RequireLogin = require 'lib/require-login'
AppView = require 'views/app-view'
PageController = require 'controllers/base/page-controller'
HistoryPageView = require 'views/history/history-page-view'
NavigationController = require 'controllers/navigation-controller'

module.exports = class AppController extends PageController
  
  beforeAction: (params, route) ->
    
    # Is the old add URL used ( ?method=add&url=y&title=x ) ?
    old_add_url_used = Chaplin.utils.queryParams.parse(route['query']).method == 'add'

    super

    @compose 'login', RequireLogin
    @compose 'app', AppView
    @compose 'menu', NavigationController
   
  history: (params, route) ->

    @view = @view || new HistoryPageView

    # If the user wants to add a new entry -> show form.
    if route.path == 'add' || old_add_url_used
      @view.toggleAdd(null, Chaplin.utils.queryParams.parse(route['query']))
