'use strict'

<% if (classy) { %>
angular.module('<%= scriptAppName %>').classy.controller 

	name: '<%= classedName %>Ctrl'

	inject: ['$scope', '$rootScope', '$firebase'<% if (injectString.classy) { %><%= injectString.classy %><% } %>]

	init: ->

		# Bitcoin price "last" reference is on the $rootScope
		bitcoinRef = new Firebase @$rootScope.firebaseURL

		# Shorthand for @$scope.bitcoin is @$.bitcoin
		@$.bitcoin = @$firebase bitcoinRef

<% } else { %>
angular.module('<%= scriptAppName %>')
.controller '<%= classedName %>Ctrl', ($scope, $rootScope, $firebase<% if (injectString.angular) { %><%= injectString.angular %><% } %>) ->

	# Last reference
	bitcoinRef = new Firebase $rootScope.firebaseURL
	$scope.bitcoin = $firebase bitcoinRef
	
<% } %>