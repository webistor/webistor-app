Controller = require 'controllers/base/controller'
ErrorRegulator = require 'regulators/error-regulator'
MinimalView = require 'views/minimal-view'
LandingPageView = require 'views/landing/landing-page-view'
mediator = require 'mediator'

module.exports = class LandingController extends Controller

  beforeAction: ->
    super
    @reuse 'error-regulator', ErrorRegulator
    @reuse 'minimal-view', MinimalView
    mediator.execute 'adjustTitle', 'Webistor, Easy Bookmarking'

  index: ->
    @view = @reuse 'landing-page-view', LandingPageView


  redirectLoggedIn: ->
    @subscribeEvent 'session:login', => @redirectTo 'app#list', null, replace: true
    @publishEvent '!session:determineLogin'
