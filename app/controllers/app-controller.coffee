PageController = require 'controllers/base/page-controller'
AppView = require 'views/app-view'
MenuView = require 'views/menu-view'
SearchRegulator = require 'regulators/search-regulator'
EntryCollection = require 'models/entry-collection'
EntryListView = require 'views/history/entry-list-view'
TagListView = require 'views/history/tag-list-view'
ProtipView = require 'views/history/protip-view'
utils = require 'lib/utils'
ErrorRegulator = require 'regulators/error-regulator'

module.exports = class AppController extends PageController

  beforeAction: ->
    super
    D = $.Deferred()
    P = D.promise()
    @reuse 'error-regulator', ErrorRegulator
    @subscribeEvent 'session:logout', =>
      D.reject "Not logged in"
      @redirectTo 'start#invite', null, replace: true
    @subscribeEvent 'session:login', => D.resolve()
    @publishEvent '!session:determineLogin'
    D.resolve() if @reuse('session').loginStatus is true
    return P.then =>
      @reuse 'search-regulator', SearchRegulator
      @reuse 'app', AppView
      @reuse 'menu', MenuView
      @collect 'tag-collection'

  list: (params) ->

    @reuse 'entries', ->
      @item = new EntryCollection
      @item.subscribeEvent 'search:search', @item.search.bind @item

    @reuse 'tags-view', TagListView, collection: (@reuse 'tag-collection')
    @protip = new ProtipView region: 'main'
    @view = new EntryListView collection: (@reuse 'entries'), region: 'main'

    @publishEvent '!search:search', (if params.query then decodeURIComponent params.query else ''), true

  add: (params, route) ->
    Entry = require 'models/entry'
    MessageView = require 'views/message-view'
    EntryView = require 'views/history/entry-view'
    data = utils.queryParams.parse route.query

    @collection = new EntryCollection
    @collection.fetch(data:{query:"@me", options:uri:data.url}).then =>
      if @entry = @collection.at 0
        oldTitle = @entry.get 'title'
        @entry.set 'title', data.title
      else @entry = new Entry data, path: 'entries'
      @view = new EntryView {model: @entry, editing: true, focus: 'tags', region: 'main', oldTitle}
      @view.once 'editOff', =>
        @entry.dispose()
        @view = new MessageView {region: 'main', message: 'Added a new entry. :)'}
