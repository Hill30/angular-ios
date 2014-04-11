angular.module('application').controller('watchController', [
    '$scope', '$log', '$resource', '$location', 'NotificationService',  function($scope, console, $resource, $location) {

     $scope.time = '--:--:--'

     $scope.$on('updateWatch', function(event, time) {
                    $scope.time = time;
                    $scope.$apply();
                }
            );

     $scope.showTodo = function() {
        $location.path("todos");
     }
                                                             
     window.testing = function(time) {
        $scope.time = time;
        $scope.$apply();
     }

}])
