module.exports = support = Chaplin.support

support.localStorage = do ->
  try
    return 'localStorage' of window and window.localStorage?
  catch err
    return false
