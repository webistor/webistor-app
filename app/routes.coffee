module.exports = (match) ->

  # Landing.
  match 'landing', 'landing#index'
  match 'invite', 'landing#invite'
  match 'login', 'landing#login'
  match 'register/:token', 'landing#register'
  match 'password-reset', 'landing#passwordReset'
  match 'password-reset/:email', 'landing#passwordReset'
  match 'password-reset/:userId/:token', 'landing#passwordResetCompletion'
  # match ':anything', 'not-found#show'

  # Application.
  match '', 'app#list'
  match 'add', 'app#add'
  match 'search/:query', 'app#list' #TODO Reroute to #q/:query
  match 'feedback', 'app#feedback'
