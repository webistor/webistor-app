PageView = require 'views/base/page-view'
mediator = require 'mediator'

module.exports = class NotFoundPageView extends PageView
  autoRender: true
  className: 'not-found-page'
  template: require './templates/not-found'
