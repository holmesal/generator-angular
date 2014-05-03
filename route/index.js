'use strict';
var path = require('path');
var util = require('util');
var ScriptBase = require('../script-base.js');
var angularUtils = require('../util.js');


var Generator = module.exports = function Generator() {
  ScriptBase.apply(this, arguments);
  this.hookFor('realtime:controller');
  this.hookFor('realtime:view');
};

util.inherits(Generator, ScriptBase);

Generator.prototype.rewriteAppJs = function () {
  var coffee = this.env.options.coffee;

  this.uri = this.name;
  if (this.options.uri) {
    this.uri = this.options.uri;
  }

  var config = {
    file: path.join(
      this.env.options.appPath,
      'scripts/app.' + (coffee ? 'coffee' : 'js')
    ),
    needle: '.otherwise',
    splicable: [
      "  templateUrl: 'views/" + this.name.toLowerCase() + ".html'" + (coffee ? "" : "," ),
      "  controller: '" + this.classedName + "Ctrl'"
    ]
  };

  // Add a resolve function if necessary
  var resolveVariable = 'id';
  var addedResolve = false;

  this.injectString = {classy: '', angular: ''};

  if (this.options.resolve) {
    addedResolve = true;
    // Add the resolve variable to the URI
    this.uri = this.uri + '/:id';
    // Add a stubbed-out resolve function
    config.splicable = config.splicable.concat("  resolve: ");
    config.splicable = config.splicable.concat("    "+this.name+": (firesolver, $route) ->");
    config.splicable = config.splicable.concat('      firesolver.get "'+this.name.toLowerCase()+'/#{$route.current.params.id}"');
    // Inject into the controller
    this.injectString.angular += ', ' + this.name;
    this.injectString.classy += ", '" + this.name+"'";
  }

  if (this.options.authenticated) {
    if (!addedResolve) {
      // Add the resolve property
      config.splicable = config.splicable.concat("  resolve: ");
    }
    // Add an authUser resolver
    config.splicable = config.splicable.concat("    authUser: (firesolver) -> firesolver.auth()");
    // Inject into the controller
    this.injectString.angular += ', authUser';
    this.injectString.classy += ", 'authUser'";
  }

  // Store
  this.env.options.injectString = this.injectString;

  if (coffee) {
    config.splicable.unshift(".when '/" + this.uri + "',");
  }
  else {
    config.splicable.unshift(".when('/" + this.uri + "', {");
    config.splicable.push("})");
  }

  angularUtils.rewriteFile(config);
};
