Application = require 'application'
routes = require 'routes'
config = require 'config'

# Initialize the application on DOM ready event.
$ ->
  new Application {
    title: $('title').text(),
    root: $('base').attr('href') or '/'
    controllerSuffix: '-controller',
    routes
  }
