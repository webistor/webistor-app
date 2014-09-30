module.exports = (match) ->
  match '', 'app#list'
  match 'add', 'app#add'
  match 'search/:query', 'app#list' #TODO Reroute to #q/:query
  match 'login', 'start#login'
  match 'password-reset', 'start#passwordReset'
  match 'password-reset/:email', 'start#passwordReset'
  match 'password-reset/:userId/:token', 'start#passwordResetCompletion'
  match 'invite', 'start#invite'
  match 'register/:token', 'start#register'
  match '404', 'not-found#show'
