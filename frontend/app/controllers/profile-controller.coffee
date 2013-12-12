PageController = require 'controllers/base/page-controller'
ProfileView = require 'views/profile/profile-view'
UserFull = require 'models/user-full'

module.exports = class ProfileController extends PageController

  show: (params) ->
    @model = new UserFull
    @model.set 'id', params.id
    @view = new ProfileView {@model, tabs: params.tabs}
    @model.fetch().then @view.render unless @model.hasAllAttributes()
