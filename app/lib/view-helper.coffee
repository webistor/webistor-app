# Application-specific view helpers
# http://handlebarsjs.com/#helpers
# --------------------------------

# Map helpers
# -----------

# Make 'with' behave a little more mustachey.
Handlebars.registerHelper 'with', (context, options) ->
  if not context or Handlebars.Utils.isEmpty context
    options.inverse(this)
  else
    options.fn(context)

# Inverse for 'with'.
Handlebars.registerHelper 'without', (context, options) ->
  inverse = options.inverse
  options.inverse = options.fn
  options.fn = inverse
  Handlebars.helpers.with.call(this, context, options)

# Get Chaplin-declared named routes. {{url "likes#show" "105"}}
Handlebars.registerHelper 'url', (routeName, params..., options) ->
  Chaplin.utils.reverse routeName, params

# Pass a string to turn it into a class name (lowercase + dashify)
Handlebars.registerHelper 'classify', (string) ->
  string.toLowerCase()

Handlebars.registerHelper 'date', (input) ->
  date = if input instanceof Date then input else new Date input
  return "#{date.toLocaleDateString()} - #{date.getHours()}:#{date.getMinutes()}"

Handlebars.registerHelper 'expandLineBreaks', (text) ->
  return new Handlebars.SafeString(text.replace(/\n/g, '<br>'))
