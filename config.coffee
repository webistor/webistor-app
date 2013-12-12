exports.config =
  
  files:
    
    javascripts:
      joinTo:
        'javascripts/app.js': /^app/
        'javascripts/vendor.js': /^(?!app)/

    stylesheets:
      joinTo:
        'stylesheets/app.css': /^app/
        'stylesheets/vendor.css': /^(?!app)/

    templates:
      joinTo: 'javascripts/app.js'
  
  conventions:
    assets: /(assets|font)/
