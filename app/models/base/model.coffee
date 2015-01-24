config = require 'config'
utils = require 'lib/utils'

module.exports = class Model extends Chaplin.Model

  # Use the mongoDB ID attribute naming convention.
  idAttribute: '_id'

  # No path by default.
  path: null

  # Prevent the disposal loop of infinite deathness.
  disposing: false

  # Allow initialize to define the path.
  initialize: (properties, options = {}) ->
    @path = options.path or @path
    super

  ###*
   * Custom URL generating
  ###
  url: ->
    return "#{@collection.url()}/#{@id}" if @collection
    throw new Error "Individual models must define their own paths." unless @path?
    schema = if config.api.https then 'https' else 'http'
    return "#{schema}://#{config.api.domain}:#{config.api.port}/#{@path}"

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

  ###*
   * Synchronise with the server.
   *
   * This enhances backbone.sync a bit:
   * - Adds default withCredentials option.
   * - Hooks into error handler for server errors.
   *
   * @inheritDoc
  ###
  sync: (method, model, options) ->
    options = $.extend true, xhrFields:withCredentials:true, options
    super
    .fail (xhr) =>
      if xhr.responseJSON?.name? and xhr.responseJSON?.message?
        error = xhr.responseJSON
        error.originalName = error.name
        error.name = "SyncError"
      else
        error = {
          name: "UnknownSyncError"
          message: utils.serverErrorToMessage(xhr.status)
          responseText: xhr.responseText
        }

      error.message = "#{xhr.statusText} (#{xhr.status}): #{error.message}"
      @trigger 'apiError', error
      @publishEvent '!error:error', error

  ###*
   * Create a sub-model.
   *
   * Return a new Model which uses, and synchronises with the attribute of the given name
   * in this model.
   *
   * @param {String} attributeName The name of the attribute from this model to use.
   * @param {Object} options Options to pass to the Model constructor.
   * @param {Collection} modelType An optional constructor function to use instead of Model.
   *
   * @return {Collection}
  ###
  sub: (attributeName, options={}, modelType) ->
    Class = modelType or Model
    model = new Class @get attributeName, options
    @listenTo model, 'change', => @set attributeName, model.getAttributes()
    model.listenTo this, "change:#{attributeName}", => model.set @get attributeName

  ###*
   * Clean up.
   *
   * This extends the default Chaplin implementation by preventing the infinite disposal loop.
  ###
  dispose: ->
    return if @disposing
    @disposing = true
    super
    @disposing = false
