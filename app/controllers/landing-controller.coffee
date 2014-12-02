PageController = require 'controllers/base/page-controller'
ErrorRegulator = require 'regulators/error-regulator'
MinimalView = require 'views/minimal-view'
PasswordResetCompletionView = require 'views/landing/password-reset-completion-view'
PasswordResetRequestedView = require 'views/landing/password-reset-requested-view'
PasswordResetView = require 'views/landing/password-reset-view'
LandingPageView = require 'views/landing/landing-page-view'
RegisterView = require 'views/landing/register-view'
InviteView = require 'views/landing/invite-view'
PasswordReset = require 'models/password-reset'
LoginView = require 'views/landing/login-view'
Invitation = require 'models/invitation'
User = require 'models/user'
mediator = require 'mediator'

module.exports = class LandingController extends PageController

  beforeAction: ->
    super
    @reuse 'minimal-view', MinimalView
    @reuse 'error-regulator', ErrorRegulator
    @reuse 'landing-page', LandingPageView
    mediator.execute 'adjustTitle', 'Webistor, Easy Bookmarking'

  index: ->
    @redirectLoggedIn()
  
  invite: ->
    @index()
    popup = new InviteView
    popup.model = new Invitation
    @reuse('landing-page').openPopup popup
  
  login: ->
    @index()
    popup = new LoginView
    @reuse('landing-page').openPopup popup

  register: (params) ->
    @index()
    popup = new RegisterView
    popup.model = new User
    popup.model.path = 'users'
    
    # Get the matching email address before rendering if an invitation token is presented.
    if params.token
      @invitation = new Invitation
      @invitation.path = "invitations/#{params.token}"
      @invitation.fetch().then((=>
        popup.model.set email:(@invitation.get 'email'), invitation:(@invitation.get 'token')
        @reuse('landing-page').openPopup popup
      ), (=>
        @redirectTo 'not-found#show', null, replace: true
      ))

    # Without an invitation token, just do the rendering.
    else
      # TEMP: Redirect away from this page as long as the API remains closed to autonomous registration.
      @redirectTo 'not-found#show', null, replace: true
      # @view.render()
  
  passwordReset: (params) ->
    @index()
    
    lp = @reuse('landing-page')
    popup = new PasswordResetView
    popup.model = new PasswordReset
    
    # When this request is done, you should see instructions.
    @listenTo popup.model, 'sync', =>
      popup = new PasswordResetRequestedView
      lp.openPopup popup
    
    # Auto-submit if the email is provided in the parameters.
    if params.email
      popup.model
        .set(email: decodeURIComponent params.email)
        .save()
        # If an error occurs, display the submit form.
        .error => @reuse('landing-page').openPopup popup
    else
      @reuse('landing-page').openPopup popup
  
  passwordResetCompletion: (params) ->
    popup = new PasswordResetCompletionView
    popup.model = new PasswordReset
    popup.model.set {id: params.userId, token: params.token}
    @reuse('landing-page').openPopup popup
    
    # When this reset succeeds, you should be logged in now.
    @listenTo popup.model, 'sync', @redirectLoggedIn

  redirectLoggedIn: ->
    @subscribeEvent 'session:login', => @redirectTo 'app#list', null, replace: true
    @publishEvent '!session:determineLogin'
