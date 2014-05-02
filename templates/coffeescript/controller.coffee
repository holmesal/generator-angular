'use strict'
<% if (ngRoute) { %>
angular.module('<%= scriptAppName %>')
.controller '<%= classedName %>Ctrl', ($scope, $rootScope, $firebase) ->

	# Last reference
	bitcoinRef = new Firebase $rootScope.firebaseURL
	$scope.bitcoin = $firebase bitcoinRef
<% } else { %>
angular.module('<%= scriptAppName %>').classy.controller 
	
	name: 'MainCtrl'

	inject: ['$scope', '$rootScope', '$firebase']

	init: ->

		# Bitcoin price "last" reference is on the $rootScope
		bitcoinRef = new Firebase @$rootScope.firebaseURL

		# Shorthand for @$scope.bitcoin is @$.bitcoin
		@$.bitcoin = @$firebase bitcoinRef
<% } %>