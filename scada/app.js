(function(){

var app = angular.module('app', []);

//pasarlo a directive custom E
app.controller('jetwaysController', ['$http', function($http){

  var airportJetways = this;

  airportJetways.jetties = [];

  $http({method: 'GET', url: 'http://127.0.0.1:8188/scada/jetways'}).success(function(data){
  	airportJetways.jetties = data;
  });


}]);

app.directive('toggleButtonOn', function(){


	return{
		restrict: 'E',
		templateUrl: 'toggleOn.html',
		scope: {
      	  jetway: '='
        }
	};


});

app.directive('toggleButtonOff', function(){


	return{
		restrict: 'E',
		templateUrl: 'toggleOff.html',
		scope: {
      	  jetway: '='
      	}
	};


});


})();