# generator-realtime

> Yeoman generator for AngularJS + Firebase, with a couple of extras.

## What's in the box?

### angular-fire
[angular-fire](https://www.firebase.com/quickstart/angularjs.html) is included by default. A main firebase URL is set on $rootScope, and the $firebase service is injected into controllers.

### firesolver
A service called `firesolver` is included, which is a route resolver that plays nicely with $firebase and $firebaseSimpleAuth.

``` TODO - document this!```

### Classy controllers
[Classy](http://davej.github.io/angular-classy/) is used for controllers, which look like this in generator-realtime:
```coffeescript
'use strict'

angular.module('gentestApp').classy
.controller 
  
  name: 'MainCtrl'

  inject: ['$scope', '$rootScope', '$firebase']

  init: ->

    # Bitcoin price "last" reference is on the $rootScope
    bitcoinRef = new Firebase @$rootScope.firebaseURL

    # Shorthand for @$scope.bitcoin is @$.bitcoin
    @$.bitcoin = @$firebase bitcoinRef
```

### Better default colors
[Colors.css](https://github.com/mrmrs/colors) contains some nice-looking versions of default web colors. Just use `color: $red` instead of `color: red`

### Easy-mode animations
[Animate.sass](https://github.com/tgdev/animate-sass) is the sass version of the popular [Animate.css](http://daneden.github.io/animate.css/), and adds the ability to only import certain animations to cut down on size a bit. If you want to use an animation, make sure to turn it on first, like so:

```scss
$use-fadeInUp: true;

// bower:scss
// ... some bower stuff
// endbower
```

**Make sure to do this before the `bower:scss` section**

See [the animate-sass settings file](https://github.com/tgdev/animate-sass/blob/master/helpers/_settings.scss) for a list of variable names.

# Danger! Danger! High voltage!
Currently, this **only supports coffeescript**. Once the dust settles a little bit, I'll build out the javascript templates as well. Also, animate-sass and colors.scss are **only really applicable if you're using sass**.

And of course, feel free to send a pull request :)

## TODO
* Add firesolver
* Add HTML5 mode by default
* Add .nginx file and symlink www -> dist/ for dokku deployment
* Convert resolve function to long syntax: ['Firesolver', (Firesolver) -> Firesolver.get('something')]

# Generator readme:

## Usage

Install `generator-realtime`:
```
npm install -g generator-realtime
```

Make a new directory, and `cd` into it:
```
mkdir my-new-project && cd $_
```

Run `yo realtime`, optionally passing an app name:
```
yo realtime [app-name]
```

Run `grunt` for building and `grunt serve` for preview


## Generators

Available generators:

* [realtime](#app) (aka [realtime:app](#app))
* [realtime:controller](#controller)
* [realtime:directive](#directive)
* [realtime:filter](#filter)
* [realtime:route](#route)
* [realtime:service](#service)
* [realtime:provider](#service)
* [realtime:factory](#service)
* [realtime:value](#service)
* [realtime:constant](#service)
* [realtime:decorator](#decorator)
* [realtime:view](#view)

**Note: Generators are to be run from the root directory of your app.**

### App
Sets up a new AngularJS app, generating all the boilerplate you need to get started. The app generator also optionally installs Bootstrap and additional AngularJS modules, such as angular-resource (installed by default).

Example:
```bash
yo realtime
```

### Route
Generates a controller and view, and configures a route in `app/scripts/app.js` connecting them.

Example:
```bash
yo realtime:route myroute
```

Produces `app/scripts/controllers/myroute.js`:
```javascript
angular.module('myMod').controller('MyrouteCtrl', function ($scope) {
  // ...
});
```

Produces `app/views/myroute.html`:
```html
<p>This is the myroute view</p>
```

**Explicitly provide route URI**

Example: 
```bash
yo realtime:route myRoute --uri=my/route
```

Produces controller and view as above and adds a route to `app/scripts/app.js`
with URI `my/route`

**Resolve route with data from firebase and inject into controller**

(not currently available for javascript)

Example:
```bash
yo realtime:route myRoute --resolve
```

Produces controller, view, and route as above, and adds a resolve function that attempts
to fetch data from firebase. If that data is found, it is injected into the generated controller.
If not, the route change fails and an error will be thrown on `$rootScope` called `routeChangeError`

**Only allow authenticated users to access route**

Example:
```bash
yo realtime:route myRoute --authenticated
```

Produces controller, view, and route as above, and adds a resolve function that ensures that the current user is authenticated. If the user is not logged in, the route change fails and an error will be thrown 
on `$rootScope` called `routeChangeError`

**All of the things**

Example:
```bash
yo realtime:route myRoute --resolve --authenticated
```


### Controller
Generates a controller in `app/scripts/controllers`.

Remembers if you asked to use Classy when scaffolding the app.

Example:
```bash
yo realtime:controller user
```

Produces `app/scripts/controllers/user.js`:
```javascript
angular.module('myMod').controller('UserCtrl', function ($scope) {
  // ...
});
```
### Directive
Generates a directive in `app/scripts/directives`.

Example:
```bash
yo realtime:directive myDirective
```

Produces `app/scripts/directives/myDirective.js`:
```javascript
angular.module('myMod').directive('myDirective', function () {
  return {
    template: '<div></div>',
    restrict: 'E',
    link: function postLink(scope, element, attrs) {
      element.text('this is the myDirective directive');
    }
  };
});
```

### Filter
Generates a filter in `app/scripts/filters`.

Example:
```bash
yo realtime:filter myFilter
```

Produces `app/scripts/filters/myFilter.js`:
```javascript
angular.module('myMod').filter('myFilter', function () {
  return function (input) {
    return 'myFilter filter:' + input;
  };
});
```

### View
Generates an HTML view file in `app/views`.

Example:
```bash
yo realtime:view user
```

Produces `app/views/user.html`:
```html
<p>This is the user view</p>
```

### Service
Generates an AngularJS service.

Example:
```bash
yo realtime:service myService
```

Produces `app/scripts/services/myService.js`:
```javascript
angular.module('myMod').service('myService', function () {
  // ...
});
```

You can also do `yo realtime:factory`, `yo realtime:provider`, `yo realtime:value`, and `yo realtime:constant` for other types of services.

### Decorator
Generates an AngularJS service decorator.

Example:
```bash
yo realtime:decorator serviceName
```

Produces `app/scripts/decorators/serviceNameDecorator.js`:
```javascript
angular.module('myMod').config(function ($provide) {
    $provide.decorator('serviceName', function ($delegate) {
      // ...
      return $delegate;
    });
  });
```

## Options
In general, these options can be applied to any generator, though they only affect generators that produce scripts.

### CoffeeScript
For generators that output scripts, the `--coffee` option will output CoffeeScript instead of JavaScript.

For example:
```bash
yo realtime:controller user --coffee
```

Produces `app/scripts/controller/user.coffee`:
```coffeescript
angular.module('myMod')
  .controller 'UserCtrl', ($scope) ->
```

A project can mix CoffeScript and JavaScript files.

To output JavaScript files, even if CoffeeScript files exist (the default is to output CoffeeScript files if the generator finds any in the project), use `--coffee=false`.

### Minification Safe

**Removed**

[Related Issue #452](https://github.com/yeoman/generator-realtime/issues/452): This option has been removed from the generator. Initially it was needed as ngMin was not entirely stable. As it has matured, the need to keep separate versions of the script templates has led to extra complexity and maintenance of the generator. By removing these extra burdens, new features and bug fixes should be easier to implement. If you are dependent on this option, please take a look at ngMin and seriously consider implementing it in your own code. It will help reduce the amount of typing you have to do (and look through) as well as make your code cleaner to look at.

By default, generators produce unannotated code. Without annotations, AngularJS's DI system will break when minified. Typically, these annotations that make minification safe are added automatically at build-time, after application files are concatenated, but before they are minified. The annotations are important because minified code will rename variables, making it impossible for AngularJS to infer module names based solely on function parameters.

The recommended build process uses `ngmin`, a tool that automatically adds these annotations. However, if you'd rather not use `ngmin`, you have to add these annotations manually yourself. **One thing to note is that `ngmin` does not produce minsafe code for things that are not main level elements like controller, services, providers, etc.:

```javascript
resolve: {
  User: function(myService) {
    return MyService();
  }
}
```

will need to be manually done like so:
```javascript
resolve: {
  User: ['myService', function(myService) {
    return MyService();
  }]
}
```


### Add to Index
By default, new scripts are added to the index.html file. However, this may not always be suitable. Some use cases:

* Manually added to the file
* Auto-added by a 3rd party plugin
* Using this generator as a subgenerator

To skip adding them to the index, pass in the skip-add argument:
```bash
yo realtime:service serviceName --skip-add
```

## Bower Components

The following packages are always installed by the [app](#app) generator:

* angular
* angular-mocks
* angular-scenario


The following additional modules are available as components on bower, and installable via `bower install`:

* angular-cookies
* angular-loader
* angular-resource
* angular-sanitize

All of these can be updated with `bower update` as new versions of AngularJS are released.

## Configuration
Yeoman generated projects can be further tweaked according to your needs by modifying project files appropriately.

### Output
You can change the `app` directory by adding a `appPath` property to `bower.json`. For instance, if you wanted to easily integrate with Express.js, you could add the following:

```json
{
  "name": "yo-test",
  "version": "0.0.0",
  ...
  "appPath": "public"
}

```
This will cause Yeoman-generated client-side files to be placed in `public`.

## Testing

Running `grunt test` will run the unit tests with karma.

## Contribute

See the [contributing docs](https://github.com/yeoman/yeoman/blob/master/contributing.md)

When submitting an issue, please follow the [guidelines](https://github.com/yeoman/yeoman/blob/master/contributing.md#issue-submission). Especially important is to make sure Yeoman is up-to-date, and providing the command or commands that cause the issue.

When submitting a PR, make sure that the commit messages match the [AngularJS conventions](https://docs.google.com/document/d/1QrDFcIiPjSLDn3EL15IJygNPiHORgU1_OOAqWjiDU5Y/).

When submitting a bugfix, write a test that exposes the bug and fails before applying your fix. Submit the test alongside the fix.

When submitting a new feature, add tests that cover the feature.

## License

[BSD license](http://opensource.org/licenses/bsd-license.php)
