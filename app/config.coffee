# Environment
production = true

# App configuration.
module.exports =
  production: production
  api:
    urlRoot: if production then '/api/rest/' else 'http://localhost/mokuji/rest/'
