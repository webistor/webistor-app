Collection = require './base/collection'
Entry = require './entry'

module.exports = class EntryCollection extends Collection
  
  model: Entry
  
  search: (data) ->
    @urlParams = if data.empty then {} else {query: data.query}
    @fetch()
