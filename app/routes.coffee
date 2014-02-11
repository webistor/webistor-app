module.exports = (match) ->
  match '', 'app#list'
  match 'add', 'app#add'
  match 'search/:query', 'app#list'
  match 'login', 'start#login'
  match 'invite', 'start#invite'
  match 'register/:user_id/:claim_key', 'start#register'
