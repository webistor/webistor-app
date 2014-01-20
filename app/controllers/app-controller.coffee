utils = require 'lib/utils'

PageController = require 'controllers/base/page-controller'
HistoryPageView = require 'views/history/history-page-view'

module.exports = class AppController extends PageController
  
  history: (params, route) ->
    @view = new HistoryPageView
  
  search: (params, route) ->
    query = decodeURIComponent params.query
    @view = new HistoryPageView search: query
    @publishEvent 'search', query
  
  add: (params, route) ->
    Entry = require 'models/entry'
    MessageView = require 'views/message-view'
    EntryView = require 'views/history/entry-view'
    
    @view?.dispose()
    entry = new Entry Chaplin.utils.queryParams.parse route.query
    @view = new EntryView {model: entry, editing:true, region: 'main'}
    
    @view.once 'editOff', =>
      entry.dispose()
      @view = new MessageView {region: 'main', message: 'Added a new entry. :)'}
