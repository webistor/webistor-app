PageView = require 'views/base/page-view'
UserSession = require 'models/user-session'
mediator = require 'mediator'

module.exports = class LoginPageView extends PageView
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
    setTimeout (=> @$el.find('#l_email')[0].focus()), 0
  
  login: (e) ->
    e.preventDefault()
    
    # This is a workaround for some password managers. Trigger a just-in-time change manually.
    @$el.find('#l_password, #l_email').trigger 'change'
    
    @model.save().then ->
      mediator.publish 'session:login'
      Chaplin.helpers.redirectTo 'app#history'