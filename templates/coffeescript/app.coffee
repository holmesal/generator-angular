'use strict'

angular
  .module('<%= scriptAppName %>', [<%= angularModules %>])<% if (ngRoute) { %>
  .config ($routeProvider) ->
    $routeProvider
    .when '/',
      templateUrl: 'views/main.html'
      controller: 'MainCtrl'
    .otherwise
      redirectTo: '/'
<% } %>

  .run ($rootScope, $location) ->

    # Set the firebase URL
    $rootScope.firebaseURL = 'https://publicdata-bitcoin.firebaseio.com'

    # Log any route change errors
    $rootScope.$on '$routeChangeError', (event, current, previous, rejection) ->
      console.error 'failed to change route'
      console.error rejection
