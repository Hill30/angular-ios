angular.module('application').controller('todosController', [
    '$scope', '$log', '$resource', '$location',  function($scope, console, $resource, $location) {

     var Records = $resource('api/todos');

     $scope.records = Records.query();

     $scope.showWatch = function() {
        $location.path("watch");
     }

}])
