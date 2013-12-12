PageController = require 'controllers/base/page-controller'
HistoryPageView = require 'views/history/history-page-view'

module.exports = class HistoryController extends PageController

  show: (params) ->
    @view = @view || new HistoryPageView
    @view.edit params.id if params.id
