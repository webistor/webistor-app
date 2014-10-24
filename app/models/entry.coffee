Model = require './base/model'

module.exports = class Entry extends Model
  
  getShortUrl: ->
    
    # Get the url. If it's not set, return.
    return url unless url = @get 'url'
    
    # Match against a URL parse regex (removes subdomains).
    matches = url.match /^https?\:\/\/([^\/\.]+\.)+([^\/\.]+)/i
    
    # If we have a domain+tld pair, return that.
    return matches[1]+matches[2] if matches && matches.length == 3
    
    # The fallback is the URL match, or the original URL.
    return matches?[0] || url
