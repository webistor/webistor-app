PageController = require 'controllers/base/page-controller'
StartView = require 'views/start-view'
LoginPageView = require 'views/start/login-page-view'
InvitePageView = require 'views/start/invite-page-view'

module.exports = class StartController extends PageController
  
  beforeAction: ->
    super
    @compose 'start', StartView
  
  invite: ->
    @view = new InvitePageView
  
  login: ->
    @view = new LoginPageView