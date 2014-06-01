PageController = require 'controllers/base/page-controller'
Invitation = require 'models/invitation'
StartView = require 'views/start-view'
LoginPageView = require 'views/start/login-page-view'
InvitePageView = require 'views/start/invite-page-view'
RegisterPageView = require 'views/start/register-page-view'

module.exports = class StartController extends PageController
  
  beforeAction: ->
    super
    @reuse 'start', StartView
  
  invite: ->
    @view = new InvitePageView
  
  login: ->
    @view = new LoginPageView
  
  register: (params) ->
    claim = new Invitation
    claim.set 'token', params.token
    claim.fetch()
    @view = new RegisterPageView claim
