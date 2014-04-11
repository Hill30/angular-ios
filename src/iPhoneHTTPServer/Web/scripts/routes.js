angular.module('application').config(['$routeProvider',
    function($routeProvider){
        $routeProvider
            .when("/watch",
                {
                    templateUrl: "views/watch.html"
                })
            .when("/todos",
                {
                    templateUrl: "views/todos.html"
                })
            .otherwise(
                {
                    redirectTo: "/watch"
                });
}]);
