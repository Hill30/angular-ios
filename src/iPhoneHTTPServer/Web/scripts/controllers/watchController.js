angular.module('application').controller('watchController', [
    '$scope', '$log', '$resource', '$location', 'NotificationService',  function($scope, console, $resource, $location) {

    $scope.time = '--:--:--';

    $scope.$on('updateWatch', function(event, time) {
                    $scope.time = time;
                    $scope.$apply();
    });

     $scope.showTodo = function() {
        $location.path("todos");
        // for test
        //var User = $resource('http://api/v1/users/:userId', {userId:'@id'});
        //User.get({userId:123}, function(res) { $scope.response = 'ok'; });
     }
                                                             

}])
