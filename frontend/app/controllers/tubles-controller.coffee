PageController = require 'controllers/base/page-controller'
TublesView = require 'views/tuble/tubles-view'
TubleMinimal = require 'models/tuble-minimal'
Collection = require 'models/base/collection'

module.exports = class TublesController extends PageController

  show: (params) ->
    @tubles = new Collection null, {model: TubleMinimal}
    @view = new TublesView {collection: @tubles, region: 'main'}
    @tubles.fetch()
