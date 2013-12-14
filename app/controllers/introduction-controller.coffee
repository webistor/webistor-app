PageController = require 'controllers/base/page-controller'
HistoryPageView = require 'views/introduction/introduction-page-view'

module.exports = class IntroductionController extends PageController

  show: (params) ->
    @view = @view || new IntroductionPageView
    # @view.edit params.id if params.id
