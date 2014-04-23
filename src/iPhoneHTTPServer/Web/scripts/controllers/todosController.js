angular.module('application').controller('todosController', [
    '$scope', '$log', '$resource', '$location',  function($scope, console, $resource, $location) {

     var Records = $resource('http://localhost:3000/api/list');
     var Update = $resource('http://localhost:3000/api/:operation/:index');
     var current = -1;

     $scope.records = Records.query();

     $scope.isSelected = function(index) {
        return index === current;
     };

     //$scope.current = function() {return current;}

     $scope.select = function(index) {
        current = index;
     };

     preventBubble = function($event) {
        if ($event.stopPropagation) $event.stopPropagation();
        if ($event.preventDefault) $event.preventDefault();
        $event.cancelBubble = true;
        $event.returnValue = false;
     }

     $scope.newItem = {}

     $scope.save = function(index, $event) {
        preventBubble($event);
        if (index === -1)
            Update.save({operation:'add', index:index}, $scope.newItem,
                function() {
                    $scope.records.push($scope.newItem);
                    current = -1;
                });
        else
            Update.save({operation:'update', index:index}, $scope.records[index],
                function() {
                    current = -1;
                });
     }

     $scope.add = function(index, $event) {
        preventBubble($event);
        var newRecord = {description:''};
        Update.save({operation:'add', index:index}, newRecord,
            function() {
                $scope.records.splice(index+1, 0, newRecord);
                current = index+1;
            });
     }

     $scope.delete = function(index, $event) {
        preventBubble($event);
        Update.save({operation:'delete', index:index}, $scope.records[index+1],
            function() {
                $scope.records.splice(index, 1);
                current = -1;
            });
     }

     $scope.showWatch = function() {
        $location.path("watch");
     };

}])
