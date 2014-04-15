Collection = require './base/collection'
Entry = require './entry'

module.exports = class EntryCollection extends Collection
  path: 'entries'
  model: Entry
  
  search: (data) ->
    @urlParams = if data.empty then {} else {query: data.query}
    @fetch()
