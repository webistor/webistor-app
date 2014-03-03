PageController = require 'controllers/base/page-controller'
MinimalView = require 'views/minimal-view'
NotFoundPageView = require 'views/not-found/not-found-page-view'

module.exports = class NotFoundController extends PageController
  
  show: ->
    @view = new NotFoundPageView

  beforeAction: ->
    super
    @reuse 'minimal', MinimalView