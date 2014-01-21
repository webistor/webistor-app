module.exports = (match) ->
  match '', 'app#history'
  match 'add', 'app#add'
  match 'search/:query', 'app#search'
  match 'login', 'start#login'
  match 'invite', 'start#invite'
  match 'register/:user_id/:claim_key', 'start#register'
