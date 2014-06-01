module.exports = (match) ->
  match '', 'app#list'
  match 'add', 'app#add'
  match 'search/:query', 'app#list' #TODO Reroute to #q/:query
  match 'login', 'start#login'
  match 'invite', 'start#invite'
  match 'register/:token', 'start#register'
  match '404', 'not-found#show'
