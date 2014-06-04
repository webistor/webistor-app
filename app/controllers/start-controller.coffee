PageController = require 'controllers/base/page-controller'
Invitation = require 'models/invitation'
User = require 'models/user'
StartView = require 'views/start-view'
LoginPageView = require 'views/start/login-page-view'
InvitePageView = require 'views/start/invite-page-view'
RegisterPageView = require 'views/start/register-page-view'

module.exports = class StartController extends PageController

  beforeAction: ->
    super
    @reuse 'start-view', StartView

  invite: ->
    @model = new Invitation
    @view = new InvitePageView  {@model}

  login: ->
    @view = new LoginPageView

  register: (params) ->
    @model = new User
    @model.path = 'users'
    @view = new RegisterPageView {@model}

    # Get the matching email address before rendering if an invitation token is presented.
    if params.token
      @invitation = new Invitation
      @invitation.path = "invitations/#{params.token}"
      @invitation.fetch().then((=>
        @model.set email:(@invitation.get 'email'), invitation:(@invitation.get 'token')
        @view.render()
      ), (=>
        @redirectTo 'not-found#show', null, replace: true
      ))

    # Without an invitation token, just do the rendering.
    else
      # TEMP: Redirect away from this page as long as the API remains closed to autonomous registration.
      @redirectTo 'not-found#show', null, replace: true
      # @view.render()
