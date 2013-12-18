module.exports = (match) ->
  match '', 'app#history'
  match 'invite', 'start#invite'
  # match 'entries/:id', 'history#show'
  # match 'user/:username', 'archive#show'
  # match 'user/:username/:query', 'archive#show'
  # match 'tag/:tag', 'archive#show'
  match 'login', 'start#login'
  match 'logout', 'session#logout'
