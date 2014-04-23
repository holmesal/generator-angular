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

		# If a route resolve is rejected, it'll throw a route change error
		# This means a user tried to access a route without being logged in
		# Or there was an error communicating with firebase
		$rootScope.$on '$routeChangeError', () ->
			console.log 'failed to change route - redirecting to landing'
			$location.path '/'
