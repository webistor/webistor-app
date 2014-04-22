Model = require './model'
config = require 'config'

module.exports = class Collection extends Chaplin.Collection

  # Use the project base model per default, not Chaplin.Model
  model: Model

  # Prevent the disposal loop of infinite deathness.
  disposing: false

  ###*
   * Get the URL for this collection by appending its path to the configured API URL.
   *
   * @return {String}
  ###
  url: ->
    throw new Error "Must define a path on collections." unless @path
    "http://#{config.api.domain}:#{config.api.port}/#{@path}"

  ###*
   * Add default withCredentials option to all synchronisations.
  ###
  sync: (method, model, options) ->
    options = $.extend true, xhrFields:withCredentials:true, options
    super

  ###*
   * Patch the collection on the server with the new models in the local collection.
   *
   * @return {promise/A} A jQuery 1.8 promise of the server response.
  ###
  patch: ->
    options = data: JSON.stringify @filter (model) -> model.isNew() or model.hasChanged()
    @sync 'patch', this, options

  ###*
   * Clean up.
   *
   * This extends Chaplins default implementation by also disposing all models in this
   * collection.
  ###
  dispose: ->
    return if @disposing
    @disposing = true
    model.dispose() for model in @models
    super
    @disposing = false
