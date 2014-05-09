# Application-specific utilities
# ------------------------------

# Delegate to Chaplin’s utils module.
utils = Chaplin.utils.beget Chaplin.utils
config = require 'config'

# Extend the utilities.
_(utils).extend

  # A list class for more versatile array management.
  List: class List extends Array
    constructor: (items=[]) -> @push(item) for item in items
    remove:      (key)      -> @splice key, 1
    clear:       (item)     -> @remove key while (key = @indexOf(item)) >= 0
    empty:                  -> @splice 0, @length
    isEmpty:                -> @length < 1
  
  req: (method, path, data) ->
    $.ajax 
      method: method
      url: "http://#{config.api.domain}:#{config.api.port}/#{path}"
      data: JSON.stringify data unless method is 'GET'
      contentType: 'application/json; charset=UTF-8' unless method is 'GET'
      processData: if method is 'GET' then true else false
      xhrFields: withCredentials: true
  
# Prevent creating new properties and stuff.
Object.seal? utils

module.exports = utils
