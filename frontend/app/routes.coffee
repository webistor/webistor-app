module.exports = (match) ->
  match '', 'home#show'
  match 'profiles/me', 'profile#show'
  match 'tubles', 'tubles#show'
  match 'tubles/:id', 'tuble#show'
  match 'tubles/:id/:tabs', 'tuble#show'
  match 'hobs/:hob_id/tubles', 'tubles#show'
  