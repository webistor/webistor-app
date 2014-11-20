PageController = require 'controllers/base/page-controller'
ErrorRegulator = require 'regulators/error-regulator'
MinimalView = require 'views/minimal-view'
LandingPageView = require 'views/landing/landing-page-view'
InviteView = require 'views/landing/invite-view'
LoginView = require 'views/landing/login-view'
Invitation = require 'models/invitation'
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

  redirectLoggedIn: ->
    @subscribeEvent 'session:login', => @redirectTo 'app#list', null, replace: true
    @publishEvent '!session:determineLogin'
