mediator = require 'mediator'
require 'lib/view-helper' # Just load the view helpers, no return value

module.exports = class View extends Chaplin.View
  # Precompiled templates function initializer.
  getTemplateFunction: -> @template

  collect: ->
    mediator.execute 'collection:collect', arguments...
