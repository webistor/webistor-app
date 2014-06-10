Collection = require './base/collection'
Tag = require './tag'

module.exports = class TagCollection extends Collection
  
  model: Tag
    
  comparator: (a, b) ->
    return -1 if (a.get 'color') and not (b.get 'color')
    return  1 if (b.get 'color') and not (a.get 'color')
    return -1 if parseInt(a.get 'num') > parseInt(b.get 'num')
    return  1 if parseInt(b.get 'num') > parseInt(a.get 'num')
    return  0
