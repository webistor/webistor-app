# Environment
production = true

# App configuration.
module.exports =
  production: production
  api:
    urlRoot: if production then 'http://api.webistor.net/rest/webistor/' else 'http://localhost/mokuji/rest/webhistory/'
