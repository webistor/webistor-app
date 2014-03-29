module.exports = (match) ->
  match '', 'app#history'
  match 'add', 'app#add'
  match 'q/:query', 'app#search'
  match 'search/:query', 'app#search'#TODO Reroute to #q/:query
  match 'login', 'start#login'
  match 'invite', 'start#invite'
  match 'register/:user_id/:claim_key', 'start#register'
  match '404', 'not-found#show'
