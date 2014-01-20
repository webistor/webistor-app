config = require 'config'
utils = require 'lib/utils'

###*
 * Base Model
 *
 * @type {class}
###
module.exports = class Model extends Chaplin.Model
  
  sync: (method, model, options) ->
    options = $.extend(true, {xhrFields:{withCredentials:true}}, options)
    return super(method, model, options)
  
  urlParams: {}
  
  ###*
   * Returns the root URL for this model.
   * 
   * Extending models may create their own implementation of this method, or replace it
   * with a string containing a static urlRoot.
   * 
   * @throws {Error} If no urlPath is defined in the model nor its collection.
   *
   * @return {String} The urlRoot.
  ###
  urlRoot: ->
    urlPath = _.result @, 'urlPath'
    return config.api.urlRoot + urlPath if urlPath
    return @collection.urlRoot() if @collection?
    return config.api.urlRoot
  
  ###*
   * Custom URL implementation to cater to the needs of non-standard APIs.
   *
   * @return {String} The URL at which this models data resides in the API.
  ###
  url: ->
    base = @urlRoot()
    key = if @id? then encodeURIComponent(@id) else ''
    base + "/#{key}" +
    if _.isEmpty @urlParams then '' else (
      (if base.indexOf('?') >= 0 then '&' else '?') + utils.queryParams.stringify @urlParams
    )
  
  ###*
   * Create a sub-set.
   * 
   * Return a new Collection which uses, and synchronises with the attribute of the given
   * name in this model.
   *
   * @param {String} attributeName The name of the attribute from this model to use.
   * @param {Object} options Options to pass to the Collection constructor.
   * @param {Collection} collectionType An optional constructor function to use instead of Collection.
   *
   * @return {Collection}
  ###
  subset: (attributeName, options={}, collectionType) ->
    Collection = collectionType or require './collection'
    options.model = Model unless options.model?
    collection = new Collection @get attributeName, options
    @listenTo collection, 'change', => @set attributeName, collection.getRaw()
    onChange = => collection.reset @get attributeName
    @on "change:#{attributeName}", onChange
    @listenTo collection, 'dispose', =>
      @stopListening collection
      @off "change:#{attributeName}", onChange
    return collection
