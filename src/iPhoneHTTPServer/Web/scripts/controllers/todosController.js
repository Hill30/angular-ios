angular.module('application').controller('todosController', [
	'$scope', '$log', '$resource', '$location',  function($scope, console, $resource, $location) {

	 var Records = $resource('api/todos');
	 $scope.records = Records.query();

	$scope.todos = [
		{ text:'learn angular', done:true },
		{ text:'build an angular app', done:false }];

	$scope.addTodo = function() {
		$scope.todos.push({ text:$scope.todoText, done:false });
		$scope.todoText = '';
	};

	$scope.showWatch = function() {
		$location.path("watch");
	}

}])
