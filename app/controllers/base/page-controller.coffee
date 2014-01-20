Controller = require './controller'
SessionController = require 'controllers/session-controller'
RequireLogin = require 'lib/require-login'
AppView = require 'views/app-view'
MenuView = require 'views/menu-view'

module.exports = class PageController extends Controller
    
  beforeAction: ->
    super
    @compose 'session', SessionController
    @compose 'login', RequireLogin
    @compose 'app', AppView
    @compose 'menu', MenuView
