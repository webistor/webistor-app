PageController = require 'controllers/base/page-controller'
TubleView = require 'views/tuble/tuble-view'
TubleFull = require 'models/tuble-full'

module.exports = class TubleController extends PageController

  show: (params) ->
    @model = new TubleFull
    @model.set 'id', params.id
    @view = new TubleView {@model, tabs: params.tabs}
    @model.fetch().then @view.render unless @model.hasAllAttributes()
