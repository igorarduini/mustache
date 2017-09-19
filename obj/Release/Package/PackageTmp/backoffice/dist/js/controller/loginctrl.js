app.controller('LoginCtrl', ['$scope', '$http', '$rootScope',
    function ($scope, $http, $rootScope) {

        $scope.logar = function (item) {
            console.log(item);
        }

    }
]);