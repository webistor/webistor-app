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
    schema = if config.api.https then 'https' else 'http'
    $.ajax
      method: method
      url: "#{schema}://#{config.api.domain}:#{config.api.port}/#{path}"
      data: JSON.stringify data unless method is 'GET'
      contentType: 'application/json; charset=UTF-8' unless method is 'GET'
      processData: if method is 'GET' then true else false
      xhrFields: withCredentials: true

  serverErrorToMessage: (code) ->
    codes =
      400: "The server did not like the kind of request you're making."
      401: "The server wants some kind of authentication first."
      402: "The server wants payment."
      403: "The server forbids this request from being processed."
      404: "The resource wasn't found on the server."
      405: "The server-resource does not allow for this action to be applied to it."
      406: "The request was sent in an invalid format."
      407: "The server wants you to authenticate with the proxy it's using."
      408: "Request timed out. The server got tired of waiting."
      409: "The request you're making caused some conflict on the server."
      410: "The resource is no longer available."
      411: "The server wants to know the exact size of this request beforehand."
      412: "The server can't fulfill one of the conditions set in your request."
      413: "Something you're sending to the server is too big."
      414: "The URL is too long."
      415: "The server can't process this type of file."
      416: "The resource can't send the requested slice of the resource."
      417: "The server does not meet expectations."
      418: "The server is but a mere teapot. Don't expect it to make coffee."
      500: "Something on the server went terribly wrong."
      501: "The function is not implemented on the server."
      502: "The server was acting as a gateway or proxy and received an invalid response from the upstream server."
      503: "The server is temporarily unavailable. It may be down for maintenance or taking a break."
      504: "The server was acting as a gateway or proxy and did not receive a timely response from the upstream server."
      505: "The server does not support the HTTP protocol version used in your request."

    return codes[code] or "Unknown error"

# Prevent creating new properties and stuff.
Object.seal? utils

module.exports = utils
