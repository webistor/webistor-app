Collection = require './base/collection'
Tag = require './tag'

module.exports = class TagCollection extends Collection
  
  model: Tag
    
  comparator: (a, b) ->
    return -1 if (a.get 'color') and not (b.get 'color')
    return  1 if (b.get 'color') and not (a.get 'color')
    return -1 if (a.get 'num') > (b.get 'num')
    return  1 if (b.get 'num') > (a.get 'num')
    return  0
