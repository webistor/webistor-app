PageView = require 'views/base/page-view'
UserSession = require 'models/user-session'

module.exports = class LoginPage extends PageView
  autoRender: true
  className: 'login-page'
  template: require './templates/login'
  
  bindings:
    '#l_email': 'email'
    '#l_password': 'password'
  
  events:
    'submit .login-form': 'login'
  
  initialize: ->
    @model = new UserSession
    super
    
  render: ->
    super
    @stickit()
  
  login: (e) ->
    e.preventDefault()
    @model.save().then -> Chaplin.helpers.redirectTo "history#show"