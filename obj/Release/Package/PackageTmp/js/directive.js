app.directive('fileUploader', function () {
    return {
        restrict: 'E',
        transclude: true,
        template: ' <div class="col-xs-12" style="margin-top: 10px;">' +
                    '   <input id="searchImage" type="file" multiple class="col-md-4"/>' +
                    '   <input type="button" ng-if="showUpload" class="btn btn-sm btn-info btn-flat" ng-click="event.preventDefault(); upload()" value="Upload" />' +
                    '</div>'
		         + '<!--<ul><li ng-repeat="file in files" class="itensList">{{file.name}} - {{file.type}}</li></ul>-->',
        controller: function ($scope, $fileUpload) {
            $scope.notReady = true;
            $scope.upload = function () {
                $fileUpload.upload($scope.files);
            };
        },
        link: function ($scope, $element) {
            var fileInput = $element.find('input[type="file"]');
            fileInput.bind('change', function (e) {
                $scope.notReady = e.target.files.length == 0;
                $scope.files = [];
                for (i in e.target.files) {
                    //Only push if the type is object for some stupid-ass reason browsers like to include functions and other junk
                    if (typeof e.target.files[i] == 'object') $scope.files.push(e.target.files[i]);
                }
            });
        }
    }
});

app.service('$fileUpload', ['$http', '$rootScope', function ($http, $rootScope) {
    this.upload = function (files) {

        if (files) {

            var formData = new FormData();
            for (i in files) {
                formData.append('file_' + i, files[i]);
            }

            formData.append('codigo', $rootScope.Codigo);
            formData.append('produto', $rootScope.Nome);

            //$.blockUI({ message: '<h5><img src="images/loading.gif" /></h5>' });
            //$.blockUI({ css: { backgroundColor: '#FFFFFF', border: '3px solid #AAAAAA', color: '#000000', cursor: 'wait', left: '45%', margin: '0', padding: '16px', position: 'fixed', top: '40%', width: '190px'} });

            $http({ method: 'POST', url: '/ImageHandler.ashx/ProcessRequest', data: formData, headers: { 'Content-Type': undefined }, transformRequest: angular.identity })
		    .success(function (data, status, headers, config) {
		        //$.unblockUI();
		        $rootScope.alert("Imagens upadas com sucesso.");
		        $rootScope.loadImages($rootScope.Codigo);
		    });
        }
        else {
            $rootScope.alert("Selecione uma imagem para prosseguir.");
        }
    };

} ]);