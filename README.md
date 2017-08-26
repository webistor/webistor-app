# Webistor App - Version 0.3.0 Beta

Webistor is an app that makes it possible to store your links into a database, so that you can find links when you need them. This way extends your memory in an easy way.

## How to use?

1. Go to webistor.net
2. Create an account

## Are you a developer?

This is an open source HTML5 application, built with [Brunch](http://brunch.io) and [Chaplin](http://chaplinjs.org). Be welcome to update Webistor as you wish. Fork it!

## Technical dept

- It should be possible to launch Webistor immediately, for example using Docker or Nix

## Installing

### Prerequisites

* Install Node
  [From website](http://nodejs.org/)
* Install Node Package Manager
  `sudo chown -R $USER /usr/local`
  `curl https://www.npmjs.com/install.sh | sh`

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
* [Cookies](https://github.com/ScottHamper/Cookies): Cookies.
