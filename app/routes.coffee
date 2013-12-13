module.exports = (match) ->
  match '', 'history#show'
  match 'entries/:id', 'history#show'
  match 'login', 'session#login'
  match 'logout', 'session#logout'