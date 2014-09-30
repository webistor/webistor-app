Collection = require './base/collection'
Entry = require './entry'

module.exports = class EntryCollection extends Collection
  path: 'entries'
  model: Entry

  search: (data) ->
    query = {}
    query.options = limit:100
    query.query = data.query if data?.query
    @fetch data:query
