mediator = require 'mediator'
ErrorRegulator = require 'regulators/error-regulator'
PageController = require 'controllers/base/page-controller'
User = require 'models/user'
Invitation = require 'models/invitation'
PasswordReset = require 'models/password-reset'
StartView = require 'views/minimal-view'
LoginPageView = require 'views/start/login-page-view'
InvitePageView = require 'views/start/invite-page-view'
RegisterPageView = require 'views/start/register-page-view'
PasswordResetPageView = require 'views/start/password-reset-page-view'
PasswordResetRequestedPageView = require 'views/start/password-reset-requested-page-view'
PasswordResetCompletionPageView = require 'views/start/password-reset-completion-page-view'

module.exports = class StartController extends PageController

  beforeAction: ->
    super
    @reuse 'error-regulator', ErrorRegulator
    @reuse 'start-view', StartView
  
  redirectLoggedIn: ->
    @subscribeEvent 'session:login', => @redirectTo 'app#list', null, replace: true
    @publishEvent '!session:determineLogin'
  
  invite: ->
    @model = new Invitation
    @view = new InvitePageView  {@model}

  login: ->
    @redirectLoggedIn()
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
  
  passwordReset: (params) ->
    @redirectLoggedIn()
    
    @model = new PasswordReset
    @view = new PasswordResetPageView {@model, autoRender: !params.email}
    
    # When this request is done, you should see instructions.
    @listenTo @model, 'sync', @passwordResetRequested
    
    # Auto-submit if the email is provided in the parameters.
    if params.email
      @model
        .set(email: decodeURIComponent params.email)
        .save()
        # If an error occurs, display the submit form.
        .error => @view.render()
    
  passwordResetRequested: ->
    @view?.dispose()
    @view = new PasswordResetRequestedPageView
    
  passwordResetCompletion: (params) ->
    @model = new PasswordReset
    @model.set {id: params.userId, token: params.token}
    @view = new PasswordResetCompletionPageView {@model}
    
    # When this reset succeeds, you should be logged in now.
    @listenTo @model, 'sync', @redirectLoggedIn
