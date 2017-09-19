app.controller('AlterarSenhaCtrl', ['$scope', '$http', '$rootScope', '$log', '$modal', '$location',
    function ($scope, $http, $rootScope, $log, $modal, $location) {

        $scope.onSave = function (item) {

            if ((item.usuario == undefined || item.usuario == "" || item.usuario == null) && (item.senha == undefined || item.senha == "" || item.senha == null)) {
                $scope.alert("Campo obrigatório não preenchido");
            }
            else {
                var res = $http.post('alterarsenha.aspx/AtualizarSenha', { 'usuario': item.usuario, 'senha': item.senha });

                res.success(function (data, status, headers, config) {
                    if (data.d == 1) {
                        $scope.alert("Senha alterada com sucesso.", function(){
                           window.location = "/backoffice/views/starter.aspx";
                        });
                    }
                });

                res.error(function (data, status, headers, config) {
                    $scope.alert("Mensagem de erro: " + JSON.stringify({ data: data }));
                });
            }
        }

        $scope.onCancel = function () {
            window.location = "/backoffice/views/starter.aspx";
        }

    }
]);