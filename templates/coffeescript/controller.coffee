'use strict'

angular.module('<%= scriptAppName %>')
  .controller '<%= classedName %>Ctrl', ($scope, $rootScope, $firebase) ->

  	# Last reference
  	lastRef = new Firebase "#{$rootScope.firebaseURL}/last"
  	$scope.last = $firebase lastRef