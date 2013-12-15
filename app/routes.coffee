module.exports = (match) ->
  match '', 'history#show'
  match 'entries/:id', 'history#show'
  match 'user/:username', 'archive#show'
  match 'user/:username/:query', 'archive#show'
  match 'tag/:tag', 'archive#show'
