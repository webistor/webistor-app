config = require 'config'
utils = require 'lib/utils'
Model = require './model'

module.exports = class Collection extends Chaplin.Collection

  model: Model
  urlPath: -> (_.result @model::, 'urlPath') or ''
  urlParams: {}
  
  initialize: (models, options) ->
    @urlPath = options.urlPath if options?.urlPath?
    super
  
  urlRoot: ->
    urlPath = _.result @, 'urlPath'
    return config.api.urlRoot + urlPath if urlPath
    return config.api.urlRoot
  
  url: ->
    base = @urlRoot()
    sep = if base.indexOf('?') >= 0 then '&' else '?'
    base + sep + utils.queryParams.stringify @urlParams
  
  getRaw: ->
    return _.map @models, (m) -> m.attributes
