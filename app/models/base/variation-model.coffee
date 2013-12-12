Model = require './model'
utils = require 'lib/utils'

module.exports = class VariationModel extends Model
  
  ###*
   * Defines which keys should be synchronised with other variations.
   * 
   * Can be overridden by extending classes or by passing it to the constructor in the options.
   *
   * @type {Array}
  ###
  keys: [@::idAttribute]
  
  ###*
   * Sets up events to detect when instances need to be synchronised.
   * @inheritDoc
  ###
  constructor: (attr, options) ->
    
    # By default, we're a variation of ourselves.
    @_variationOf = @constructor unless @_variationOf?
    
    # Add keys via the options?
    @keys = options.keys if options?.keys?
    
    # When the primary key changes, stuff has to happen.
    @on "change:#{@idAttribute}", =>
      @_variationOf::removeVariation @
      @_variationOf::addVariation @
    
    # The first .set must not synchronise.
    (options = options or {}).noSync = true
    
    # Do the normal things.
    super(attr, options)
  
  ###*
   * Turn this into a variation of the given class.
   * 
   * To be called directly on the prototype of a VariationModel class.
   *
   * @param {class} model A VariationModel class.
  ###
  variationOf: (model) ->
    @_variationOf = model
    model::_variations = {} unless model::hasOwnProperty('_variations')
  
  ###*
   * Register a new instance of a model as being a variation.
   * 
   * To be called directly on the prototype of the original.
   *
   * @param {VariationModel} model The instance to register.
  ###
  addVariation: (model) ->
    
    # Reference ID.
    id = model.id
    
    # Do nothing if the model is already present.
    return if _.has @_variations[id]? or [], model
    
    # Extend an already existing data record?
    if @_variations[id]?
      attrs = {}
      for variation in @_variations[id]
        variation.set _.pick model.attributes, variation.keys, noSync:true
        attrs = _.extend attrs, variation.attributes
      model.set (_.pick attrs, model.keys), noSync:true
    
    # Create a new data record?
    else @_variations[id] = new utils.List
    
    
    # Push the new model into the list of models for this data record.
    @_variations[id].push model
  
  ###*
   * Removes the given model from the variations.
   * 
   * If the model is undergoing a change, this method will look at the previous ID
   * attribute to find the data record.
   *
   * @param {VariationModel} model The variation to remove.
  ###
  removeVariation: (model) ->
    id = if model.hasChanged(model.idAttribute) then model.previous(model.idAttribute) else model.id
    @_variations[id]?.clear(model)
    delete @_variations[id] if @_variations[id]?.isEmpty()
  
  ###*
   * Set a hash of attributes on all variations of the given model.
   * 
   * To be called directly on the prototype of the original.
   *
   * @param {VariationModel} model The model to find variations (including itself) of.
   * @param {Object} attrs The hash of attributes.
   * @param {Object} options A hash of options to pass to individual get calls.
   * 
   * @return {VariationModel} The given instance.
  ###
  setAll: (model, attrs, options) ->
    id = model.id
    (options = options or {}).noSync = true
    variation.set _.pick(attrs, variation.keys), options for variation in @_variations[id] or [model]
    return model
  
  ###*
   * Forwards to setAll if not suppressed by the noSync option.
   * 
   * @inheritDoc
  ###
  set: (key, val, options) ->
    
    # Do nothing if there's no key.
    return @ unless key?
    
    # Normalize attributes.
    if typeof key is 'object'
      attrs = key
      options = val
      
    # Single attribute?
    else (attrs = {})[key] = val
    
    # Do the normal thing if noSync.
    return super if options?.noSync? is true or not @_variationOf?
    
    # Set on all variations.
    return @_variationOf::setAll @, attrs, options
  
  ###*
   * Gets rid of variation tracking when the model is disposed of.
   *
   * @inheritDoc
  ###
  dispose: ->
    @_variationOf::removeVariation(@)
    super
  
  ###*
   * Returns true if this variation has access to all the attributes it needs.
   *
   * @return {Boolean}
  ###
  hasAllAttributes: ->
    _.all @keys, (key) => _.has @attributes, key
