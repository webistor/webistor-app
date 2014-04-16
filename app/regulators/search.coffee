Regulator = require 'regulators/base/regulator'

module.exports = class Search extends Regulator
  name: 'search'

  listen:
    '!#search mediator': 'doSearch'
    '!#extend mediator': 'addSearch'

  parsed: null

  doSearch: (query, replace=false) ->
    @parsed = @parseSearchQuery query
    url = (if @parsed.empty then '/' else "/search/#{encodeURIComponent @parsed.processed}")
    Backbone.history.navigate url, {replace}
    @publishEvent '#search', @parsed

  addSearch: (query, replace=false) ->
    return @doSearch query, replace unless @parsed?
    toAdd = @parseSearchQuery query
    tags = @parsed.tags.concat toAdd.tags
    users = @parsed.users.concat toAdd.users
    groups = @parsed.groups.concat toAdd.groups
    indexes = @parsed.indexes.concat toAdd.indexes
    search = "#{@parsed.search} #{toAdd.search}"
    @doSearch @generateSearchQuery groups, users, tags, indexes, search

  parseSearchQuery: (query) ->

    # Initiate variables.
    tags = []
    users = []
    groups = []
    indexes = []
    search = ''

    # Parse the search query.
    for value in ($.trim query).split ' '
      value = $.trim value
      if value.length > 1 then switch value.charAt 0
        when '#' then tags.push value.slice 1
        when '@' then users.push value.slice 1
        when '$' then groups.push value.slice 1
        when ':' then indexes.push value.slice 1
        else search = $.trim search + " #{value}"
      else search = $.trim search + " #{value}"

    # Generate a clean query.
    processed = @generateSearchQuery groups, users, tags, indexes, search
    empty = processed is ''

    # Return the results.
    {query, tags, users, groups, search, indexes, processed, empty}

  generateSearchQuery: (groups, users, tags, indexes, search) ->
    processed = ''
    processed = $.trim processed + ' ' + ("$#{group}" for group in groups).join ' '
    processed = $.trim processed + ' ' + ("@#{user}" for user in users).join ' '
    processed = $.trim processed + ' ' + ("##{tag}" for tag in tags).join ' '
    processed = $.trim processed + ' ' + (":#{index}" for index in indexes).join ' '
    processed = $.trim processed + ' ' + search
