app.controller('IndexCtrl', ['$scope', '$modal', '$rootScope', '$timeout', '$location', '$interval',
function ($scope, $modal, $rootScope, $timeout, $location, $interval) {

	$rootScope.alert = function (message, sucessCallback, title) {

		var modalInstance = $modal.open({
			template: ' <div class="modal-header" ><h3>{{title}}</h3></div><div class="modal-body"><p ng-bind-html="message"></p><!--{{message}}--></div><div class="modal-footer"><button class="btn btn-primary" ng-click="ok()">OK</button></div>',
			controller: function ($scope, $modalInstance) {
				$scope.message = message;
				$scope.title = title || "Alerta";
				$scope.ok = function () {
					$modalInstance.close();
				};
			}
		});

		modalInstance.result.then(sucessCallback);
	};

	$rootScope.confirm = function (message, positiveCallback, negativeCallback, title) {

		$modal.open({
			template: ' <div class="modal-header"><h3>{{title}}</h3></div><div class="modal-body">{{message}}</div><div class="modal-footer"><button class="btn btn-primary" ng-click="sim()">Sim</button><button class="btn btn-danger" ng-click="nao()">Não</button></div>',
			controller: function ($scope, $modalInstance) {
				$scope.message = message;
				$scope.title = title || "Confirmação";
				$scope.sim = function () {
					$modalInstance.result.then(positiveCallback);
					$modalInstance.close();
				};
				$scope.nao = function () {
					$modalInstance.result.then(negativeCallback);
					$modalInstance.close();
				};
			}
		});
	};
    
    $rootScope.warn = function (message, title, sucessCallback) {

		var modalInstance = $modal.open({
			template: ' <div class="modal-header"><h3>{{title}}</h3></div><div class="modal-body">{{message}}</div><div class="modal-footer"><button class="btn btn-danger" ng-click="ok()">OK</button></div>',
			controller: function ($scope, $modalInstance) {
				$scope.message = message;
				$scope.title = title || "Erro";
				$scope.ok = function () {
					$modalInstance.close();
				};
			}
		});
		modalInstance.result.then(sucessCallback);
	};

    $scope.alertPopup = function (message, title, time){
        $.gritter.add({
            title: title || "Aviso",
            text: message,
            sticky: false,
            time: time || 5000,
            class_name: 'gritter-info'
         });
    }

    $scope.errorPopup = function (message, title, time){
        $.gritter.add({
            title: title || "Aviso",
            text: message,
            sticky: false,
            time: time || 5000,
            class_name: 'gritter-error'
         });
    }

    $rootScope.errorCallback = function(error){
        if(error.data){
            $scope.warn(error.data.message);
        }else{
            $scope.warn("Erro ao executar ação, contacte os responsáveis pelo suporte do sistema.")
        }
    }
}]);
