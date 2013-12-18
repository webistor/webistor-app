PageController = require 'controllers/base/page-controller'
UserClaim = require 'models/user-claim'
StartView = require 'views/start-view'
LoginPageView = require 'views/start/login-page-view'
InvitePageView = require 'views/start/invite-page-view'
RegisterPageView = require 'views/start/register-page-view'

module.exports = class StartController extends PageController
  
  beforeAction: ->
    super
    @compose 'start', StartView
  
  invite: ->
    @view = new InvitePageView
  
  login: ->
    @view = new LoginPageView
  
  register: (params) ->
    claim = new UserClaim
    claim.urlParams = {user_id:params.user_id, claim_key:params.claim_key}
    @view = new RegisterPageView claim