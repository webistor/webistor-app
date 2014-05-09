utils = require 'lib/utils'
mediator = require 'mediator'

module.exports = class Regulator

  _.extend @prototype, Backbone.Events
  _.extend @prototype, Chaplin.EventBroker

  disposed: false
  disposing: false
  name: false
  listen: {}

  constructor: ->
    mediator.regulators?[@name] = this if @name
    @delegateListeners()
    @initialize arguments...

  initialize: -> this

  redirectTo: (args..., options) ->

    if options.silent
      return @publishEvent 'router:changeURL', if args.length is 1 then args[0] else utils.reverse args...

    utils.redirectTo arguments...

  delegateListeners: ->
    for version in utils.getAllPropertyVersions this, 'listen'
      for own eventString, callbacks of version
        callbacks = switch typeof callbacks
          when "function" then [callbacks]
          when "string" then (@[callback] for callback in callbacks.split ' ' when _.isFunction @[callback])
          when "object" then (callback for own key, callback of callbacks when _.isFunction @[callback])
        [eventNames..., target] = eventString.split ' '
        @delegateListener (eventNames.join ' '), target, callback for callback in callbacks

  delegateListener: (eventName, target, callback) ->
    @subscribeEvent eventName, callback if target is 'mediator'
    @listenTo @[target], eventName, callback if @[target]?.on

  publishEvent: (name, args...) ->
    Chaplin.EventBroker.publishEvent.apply this, [(@_eventName name), args...]

  subscribeEvent: (name, callback) ->
    Chaplin.EventBroker.subscribeEvent.call this, (@_eventName name), callback

  _eventName: (eventName) ->
    return eventName if (eventName.indexOf '#') is -1
    throw new Error "The 'name'-property must be defined on a Regulator when using '#'." unless @name
    eventName.replace '#', if @name then "#{@name}:" else ''

  dispose: ->
    return if @disposed or @disposing
    @disposing = true
    @unsubscribeAllEvents()
    @stopListening()
    for own prop, obj of this when obj and typeof obj.dispose is 'function'
      obj.dispose()
      delete this[prop]
    delete mediator.regulators[@name] if @name
    @disposed = true
    @disposing = false
    Object.freeze? this
