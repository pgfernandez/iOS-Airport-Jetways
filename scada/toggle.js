function(){

var app = angular.module('app', []);

app.directive('toggleButton', function(){
	return{
		restrict: 'E',
		templateUrl: 'toggle.html',
		scope: {
			id: '@'
		}
	};


});

})();