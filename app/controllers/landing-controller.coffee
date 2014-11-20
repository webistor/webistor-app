PageController = require 'controllers/base/page-controller'
ErrorRegulator = require 'regulators/error-regulator'
MinimalView = require 'views/minimal-view'
LandingPageView = require 'views/landing/landing-page-view'
mediator = require 'mediator'

module.exports = class LandingController extends PageController

  beforeAction: ->
    super
    @reuse 'error-regulator', ErrorRegulator
    @reuse 'minimal-view', MinimalView
    mediator.execute 'adjustTitle', 'Webistor, Easy Bookmarking'

  index: ->
    @redirectLoggedIn()
    @view = new LandingPageView unless @view instanceof LandingPageView
  
  invite: ->
    @index()
    @view.openInvite()
  
  login: ->
    @index()
    @view.openLogin()

  redirectLoggedIn: ->
    @subscribeEvent 'session:login', => @redirectTo 'app#list', null, replace: true
    @publishEvent '!session:determineLogin'
