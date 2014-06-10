Controller = require './controller'
SessionController = require 'controllers/session-controller'

module.exports = class PageController extends Controller
    
  beforeAction: ->
    super
    @reuse 'session', SessionController
