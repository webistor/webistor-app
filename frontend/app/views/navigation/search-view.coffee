CollectionPanelView = require './base/collection-panel-view'
SyncCollection = require 'models/base/sync-collection'
TubleMinimal = require 'models/tuble-minimal'
SearchResultView = require './search-result-view'

module.exports = class SearchView extends CollectionPanelView
  
  className: 'navigation-search'
  template: require './templates/search'
  
  listSelector: '.search-results'
  itemView: SearchResultView
  
  events:
    'keyup .search-term': _.throttle (->@newSearch()), 1000
    'change .search-term': 'newSearch'
  
  listen:
    'panel:open:search mediator': 'show'
    'synced collection': 'updateResults'
    'syncStateChange collection': 'updateInfo'
  
  initialize: ->
    @collection = new SyncCollection null, model:TubleMinimal
    super
  
  show: ->
    super
    @$('.search-term').focus()
    $('body').addClass 'no-scroll' if @collection.length > 0
  
  hide: ->
    $('body').removeClass 'no-scroll'
    @$('.search-info').hide() if @collection.length + @$('.search-term').val().length is 0
    super
  
  updateInfo: ->
    @$('.search-info').show().text(
      if @collection.isSyncing() and @collection.length is 0
        'Laden...'
      else
        @collection.length + ' Gevonden.'
    );
  
  updateResults: ->
    @$el.toggleClass 'has-results', !!@collection.length
    $('body').toggleClass 'no-scroll', !!@collection.length
  
  newSearch: ->
    search = @$('.search-term').val()
    return @collection if not search or search is @collection.urlParams?.q or @collection.isSyncing()
    @collection.urlParams.q = search if search
    @collection.fetch()
