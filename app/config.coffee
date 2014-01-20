# Environment
production = false

# App configuration.
module.exports =
  production: production
  api:
    urlRoot: if production then 'http://www.webistor.net/api/rest/' else 'http://www.webistor.net/api/rest/'
