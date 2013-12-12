PageController = require 'controllers/base/page-controller'
UserView = require 'views/user/user-view'
UserFull = require 'models/user-full'

module.exports = class UserController extends PageController

  show: (params) ->
    @model = new UserFull
    @model.set 'id', params.id
    @view = new UserView {@model, tabs: params.tabs}
    @model.fetch().then @view.render unless @model.hasAllAttributes()
