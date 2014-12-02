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
      order:
        before: [
          'app/views/styles/fonts.styl'
          'app/views/styles/reset.styl'
          'app/views/styles/global.styl'
        ]

    templates:
      joinTo: 'javascripts/app.js'

  conventions:
    assets: /(assets|font)\//
