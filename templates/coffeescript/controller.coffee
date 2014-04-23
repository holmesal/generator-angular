'use strict'

angular.module('<%= scriptAppName %>')
.controller '<%= classedName %>Ctrl', ($scope, $rootScope, $firebase) ->

	# Last reference
	bitcoinRef = new Firebase $rootScope.firebaseURL
	$scope.bitcoin = $firebase bitcoinRef