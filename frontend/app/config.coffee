# Environment
production = false

# App configuration.
module.exports =
  production: production
  api:
    urlRoot: if production then 'http://api.tuble.nl/rest/tuble/' else 'http://localhost/TubleAPI/rest/tuble/'
