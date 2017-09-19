app.controller('CursoCtrl', ['$scope', '$http', '$rootScope', '$log', '$modal', 'ngTableParams', '$filter', 'blockUI',
    function ($scope, $http, $rootScope, $log, $modal, ngTableParams, $filter, blockUI) {

        $scope.isSearch = false;

        $scope.tableCurso = new ngTableParams({
            page: 1,
            count: 10,
            sorting: {
                codigo: 'asc'
            }
        }, {
            counts: [],
            total: 0,
            getData: function ($defer, params) {
                var dados = carregaGrid($scope.item, function (data) {
                    params.total(data.length);
                    var orderedData = params.sorting() ? $filter('orderBy')(data, params.orderBy()) : data;
                    $defer.resolve(orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count()))
                });
            }
        });

        //Busca cursos
        function carregaGrid(item, callback) {
            var dados = null;

            if (!$scope.isSearch) {
              var res = $http.post('curso.aspx/CarregarCursos', {});

              res.success(function (data, status, headers, config) {

                  $scope.cursos = JSON.parse(data.d);
                  blockUI.stop();

                  if (callback != undefined && callback != null) {
                      callback($scope.cursos);
                  }
              });

              res.error(function (data, status, headers, config) {
                  blockUI.stop();
                  $scope.alert("Mensagem de erro: " + JSON.stringify({ data: data }));
              });
            } else {
                var res = $http.post('curso.aspx/CarregarCursosPesquisa', { 'nome': $scope.nome });

                res.success(function (data, status, headers, config) {

                    $scope.cursos = JSON.parse(data.d);
                    blockUI.stop();

                    if (callback != undefined && callback != null) {
                        callback($scope.cursos);
                    }
                });

                res.error(function (data, status, headers, config) {
                    blockUI.stop();
                    $scope.alert("Mensagem de erro: " + JSON.stringify({ data: data }));
                });
            }
        }

        $scope.onSaveDetalhes = function () {

          var item = angular.copy($scope.itemForm);
          blockUI.start();

          // check to make sure the form is completely valid
          if (!item.nome || !item.valor_periodo || !item.valor_total || !item.duracao_anos || !item.id_tipo_curso) {
            blockUI.stop();
            $scope.alert("Campos obrigatórios não preenchidos.");
          }
          else {
              //Inserir novo curso
              if (item.codigo == undefined || item.codigo == null || item.codigo == "") {
                  var res = $http.post('curso.aspx/SalvarCurso', JSON.stringify(item));

                  res.success(function (data, status, headers, config) {
                      if (data.d == 1) {
                          $scope.tableCurso.page(1);
                          $scope.tableCurso.reload();
                          fecharModalCurso();
                          $scope.alert("Curso cadastrado com sucesso.");
                          proximoPassoWizard();
                      }
                      blockUI.stop();
                  });

                  res.error(function (data, status, headers, config) {
                      blockUI.stop();
                      $scope.alert("Mensagem de erro: " + JSON.stringify({ data: data }));
                  });
              }
              //Atualizar curso cadastrado
              else {
                  var res = $http.post('curso.aspx/AtualizarCurso', JSON.stringify(item));

                  res.success(function (data, status, headers, config) {
                      if (data.d == 1) {
                          $scope.tableCurso.reload();
                          fecharModalCurso();
                          $scope.alert("Curso editado com sucesso.");
                          proximoPassoWizard();
                      }
                      blockUI.stop();
                  });

                  res.error(function (data, status, headers, config) {
                      blockUI.stop();
                      $scope.alert("Mensagem de erro: " + JSON.stringify({ data: data }));
                  });
              }
          }
        }

        //Método para deletar uma notícia
        $scope.onDelete = function (item) {

            $rootScope.confirm('Realmente deseja remover este curso?', function () {
                blockUI.start();
                var res = $http.post('curso.aspx/DeletarCurso', { 'codigo': item.codigo });

                res.success(function (data, status, headers, config) {
                    if (data.d == 1) {
                        $scope.tableCurso.page(1);
                        $scope.tableCurso.reload();
                        $scope.alert("Curso removido com sucesso.");
                    }
                    blockUI.stop();
                });

                res.error(function (data, status, headers, config) {
                    blockUI.stop();
                    $scope.alert("Mensagem de erro: " + JSON.stringify({ data: data }));
                });

            }, function () { }, 'Confirmação');
        }

        //Busca todos os tipos de curso cadastrados na base
        $scope.carregaTiposCurso = function () {
            var res = $http.post('curso.aspx/CarregarTipoCurso', {});

            res.success(function (data, status, headers, config) {
                if (data.d.length > 0) {
                    $scope.tiposCurso = JSON.parse(data.d);
                }
                blockUI.stop();
            });

            res.error(function (data, status, headers, config) {
                blockUI.stop();
                $scope.alert("Mensagem de erro: " + JSON.stringify({ data: data }));
            });
        }

        //Limpa todas as variáveis na inserção
        $scope.onInsertMode = function () {
            $scope.itemForm = {}
            angular.element("#passo2").addClass('disabled');
            angular.element("#passo2").removeClass('active');
            angular.element("#passo1").addClass('active');
            angular.element("#step2").removeClass('active');
            angular.element("#step1").addClass('active');
        }

        $scope.onEdit = function (item) {
            $scope.itemForm = angular.copy(item);
            angular.element("#passo2").removeClass('disabled');
            angular.element("#passo2").removeClass('active');
            angular.element("#passo1").addClass('active');
            angular.element("#step2").removeClass('active');
            angular.element("#step1").addClass('active');
        }

        //Limpa todas as variáveis na pesquisa
        $scope.onSearchMode = function () {
            $scope.itemSearch = {};
            $scope.insertMode = false;
            $scope.editMode = false;
            $scope.isSearch = true;
        }

        $scope.onSearch = function (item) {
            if (item && item.nome) $scope.nome = item.nome;
            else $scope.nome = "";

            $('.pesquisa').modal('toggle');
            $scope.tableCurso.reload();
            $scope.tableCurso.page(1);
        }

        function nextTab(elem) {
            $(elem).next().find('a[data-toggle="tab"]').click();
        }

        function prevTab(elem) {
            $(elem).prev().find('a[data-toggle="tab"]').click();
        }

        function proximoPassoWizard() {
            var $active = $('.wizard .nav-tabs li.active');
            $active.next().removeClass('disabled');
            nextTab($active);
        }

        function voltarPassoWizard() {
            var $active = $('.wizard .nav-tabs li.active');
            prevTab($active);
        }

        //Limpa o método de pesquisa
        $scope.onClean = function () {
            $scope.isSearch = false;
            $scope.tableCurso.reload();
            $scope.tableCurso.page(1);
        }

        function fecharModalCurso() {
          $('.curso').modal('hide');
          $('body').removeClass('modal-open');
          $('.modal-backdrop').remove();
        }

        //Inicialização
        blockUI.start();
        $scope.carregaTiposCurso();
    }
]);
