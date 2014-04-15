PageController = require 'controllers/base/page-controller'
HistoryPageView = require 'views/history/history-page-view'
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
    @subscribeEvent 'session:logout', => @redirectTo 'start#invite', null, replace: true
    @publishEvent '!session:determineLogin'
    @reuse 'search-regulator', SearchRegulator
    @reuse 'app', AppView
    @reuse 'menu', MenuView
    @reuse 'tags', ->
      @item = new TagCollection
      @item.fetch()

  list: (params) ->

    @reuse 'entries', ->
      @item = new EntryCollection
      @item.subscribeEvent 'search:search', @item.search.bind @item

    @reuse 'tags-view', TagListView, collection: (@reuse 'tags')

    @view = new EntryListView collection: (@reuse 'entries')

    #TODO: Change document title accordingly.
    @publishEvent '!search:search', (if params.query then decodeURIComponent params.query else ''), true

  add: (params, route) ->
    Entry = require 'models/entry'
    MessageView = require 'views/message-view'
    EntryView = require 'views/history/entry-view'

    @entry = new Entry utils.queryParams.parse route.query
    @view = new EntryView {model: @entry, editing:true, focus: 'tags', region: 'main'}

    @view.once 'editOff', =>
      @entry.dispose()
      @view = new MessageView {region: 'main', message: 'Added a new entry. :)'}
