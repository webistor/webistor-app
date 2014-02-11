Application = require 'application'
routes = require 'routes'
config = require 'config'

module.exports = global = {}

# Initialize the application on DOM ready event.
$ ->
  global.app = new Application {
    title: $('title').text(),
    root: $('base').attr('href') or '/'
    controllerSuffix: '-controller',
    routes
  }
