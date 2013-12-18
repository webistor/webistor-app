Controller = require 'controllers/base/controller'
IntroductionView = require 'views/introduction-view'
IntroductionPageView = require 'views/introduction/introduction-page-view'

module.exports = class IntroductionController extends Controller
  
  beforeAction: ->
    @compose 'site', IntroductionView
  
  invite: ->
    @view = new IntroductionPageView