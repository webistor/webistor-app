# Webistor App - Version 0.0.1 Alpha

This is an HTML5 application, built with [Brunch](http://brunch.io) and [Chaplin](http://chaplinjs.org).

## Installing

### Prerequisites

* Install Node
  [From website](http://nodejs.org/)
* Install Node Package Manager
  `sudo chown -R $USER /usr/local`
  `curl http://npmjs.org/install.sh | sh`

### Installation

* Clone repository
  `git clone git@github.com:webistor/webistor-app.git`
* Install dependencies
  `cd webistor-app`
  `npm install && bower install`
* Compile CoffeeScript
  `brunch build` or `brunch build --production`

## Development

### Prerequisites

* Install [git flow](https://github.com/nvie/gitflow)
  `sudo apt-get install git-flow`
  Or try: [Install guide](https://github.com/nvie/gitflow/wiki/Installation)
* Initialize git flow
  `cd webistor-api`
  [`git flow init`](https://github.com/nvie/gitflow/wiki/Command-Line-Arguments#git-flow-init--fd)

### Coding

* Create your feature branch
  [`git flow feature start <name>`](https://github.com/nvie/gitflow/wiki/Command-Line-Arguments#git-flow-feature-start--f-name-base)
* Automatically compile changes
  `brunch watch`
* **Don't commit your local environment settings**:
  [How to ignore files](https://help.github.com/articles/ignoring-files)

### Testing

You can run the application without backend by issueing `brunch watch --server`. You will
be able to test the output at `localhost:3333`.

### Documentation

* [Brunch](https://github.com/brunch/brunch/tree/stable/docs): Build tool
* [CoffeeScript](http://coffeescript.org/): Source code language.
* [Stylus](http://learnboost.github.io/stylus/): CSS Replacement.
* [Underscore](http://underscorejs.org/): Utility library used.
* [Chaplin](http://docs.chaplinjs.org/): Framework used.
* [Backbone](http://backbonejs.org/): Framework used by Chaplin.
* [HandleBars](http://handlebarsjs.com/): Template rendering engine used.
