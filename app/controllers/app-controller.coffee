PageController = require 'controllers/base/page-controller'
HistoryPageView = require 'views/history/history-page-view'
RequireLogin = require 'lib/require-login'
AppView = require 'views/app-view'
MenuView = require 'views/menu-view'
SearchRegulator = require 'regulators/search'
EntryCollection = require 'models/entry-collection'
TagCollection = require 'models/tag-collection'
EntryListView = require 'views/history/entry-list-view'
TagListView = require 'views/history/tag-list-view'
utils = require 'lib/utils'

module.exports = class AppController extends PageController
  
  beforeAction: ->
    super
    @reuse 'search-regulator', SearchRegulator
    @reuse 'login', RequireLogin
    @reuse 'app', AppView
    @reuse 'menu', MenuView
    @reuse 'tags', ->
      @item = new TagCollection
      @item.fetch()

  list: (params) ->
    
    @reuse 'entries', ->
      @item = new EntryCollection
      @item.subscribeEvent 'search:search', @item.search
    
    @reuse 'tags-view', TagListView, collection: (@reuse 'tags')
    
    @view = new EntryListView collection: (@reuse 'entries')
    @publishEvent '!search:search', (if params.query then decodeURIComponent params.query else ''), true
  
  history: (params, route) ->
    @view = new HistoryPageView
  
  search: (params, route) ->
    query = decodeURIComponent params.query
    document.title = '/q/'+query#TODO: Reset document title after search field is cleared again.
    @view = new HistoryPageView search: query
    @publishEvent 'q', query
  
  add: (params, route) ->
    Entry = require 'models/entry'
    MessageView = require 'views/message-view'
    EntryView = require 'views/history/entry-view'
    
    @entry = new Entry utils.queryParams.parse route.query
    @view = new EntryView {model: @entry, editing:true, focus: 'tags', region: 'main'}
    
    @view.once 'editOff', =>
      @entry.dispose()
      @view = new MessageView {region: 'main', message: 'Added a new entry. :)'}
