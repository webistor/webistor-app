Collection = require './base/collection'
Entry = require './entry'

module.exports = class EntryCollection extends Collection
  path: 'entries'
  model: Entry

  search: (data) ->
    @fetch if data?.query then {data:query:data.query} else {}
