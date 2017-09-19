app.controller('AlunoCtrl', ['$scope', '$http', '$rootScope', '$log', '$modal', 'ngTableParams', '$filter', 'blockUI',
    function ($scope, $http, $rootScope, $log, $modal, ngTableParams, $filter, blockUI) {

        $scope.isSearch = false;

        $scope.tableAluno = new ngTableParams({
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

        //Busca Alunos
        function carregaGrid(item, callback) {
            var dados = null;

            if (!$scope.isSearch) {
              var res = $http.post('aluno.aspx/CarregarAlunos', {});

              res.success(function (data, status, headers, config) {

                  $scope.alunos = JSON.parse(data.d);
                  blockUI.stop();

                  if (callback != undefined && callback != null) {
                      callback($scope.alunos);
                  }
              });

              res.error(function (data, status, headers, config) {
                  blockUI.stop();
                  $scope.alert("Mensagem de erro: " + JSON.stringify({ data: data }));
              });
            } else {
                var res = $http.post('aluno.aspx/CarregarAlunosPesquisa', { 'nome': $scope.nome, 'cpf': $scope.cpf, 'rg': $scope.rg });

                res.success(function (data, status, headers, config) {

                    $scope.alunos = JSON.parse(data.d);
                    blockUI.stop();

                    if (callback != undefined && callback != null) {
                        callback($scope.alunos);
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
          if (!item.nome || !item.sobrenome || !item.email || !item.data_nascimento || !item.cpf || !item.rg
            || !item.nacionalidade || !item.naturalidade || !item.telefone || !item.endereco) {
            blockUI.stop();
            $scope.alert("Campos obrigatórios não preenchidos.");
          }
          else {
              item.data_nascimento = moment(item.data_nascimento, 'DD/MM/YYYY').format('YYYY/MM/DD');

              //Inserir novo aluno
              if (item.codigo == undefined || item.codigo == null || item.codigo == "") {
                  var res = $http.post('aluno.aspx/SalvarAluno', JSON.stringify(item));

                  res.success(function (data, status, headers, config) {
                      if (data.d) {
                          $scope.itemForm.codigo = data.d;
                          $scope.tableAluno.page(1);
                          $scope.tableAluno.reload();
                          $scope.alert("Aluno cadastrado com sucesso.");
                          proximoPassoWizard();
                      }
                      blockUI.stop();
                  });

                  res.error(function (data, status, headers, config) {
                      blockUI.stop();
                      $scope.alert("Mensagem de erro: " + JSON.stringify({ data: data }));
                  });
              }
              //Atualizar aluno cadastrado
              else {
                  var res = $http.post('aluno.aspx/AtualizarAluno', JSON.stringify(item));

                  res.success(function (data, status, headers, config) {
                      if (data.d == 1) {
                          $scope.tableAluno.reload();
                          $scope.alert("Aluno editado com sucesso.");
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

            $rootScope.confirm('Realmente deseja remover este aluno?', function () {
                blockUI.start();
                var res = $http.post('aluno.aspx/DeletarAluno', { 'codigo': item.codigo });

                res.success(function (data, status, headers, config) {
                    if (data.d == 1) {
                        $scope.tableAluno.page(1);
                        $scope.tableAluno.reload();
                        $scope.alert("Aluno removido com sucesso.");
                    }

                    blockUI.stop();
                });

                res.error(function (data, status, headers, config) {
                    blockUI.stop();
                    $scope.alert("Mensagem de erro: " + JSON.stringify({ data: data }));
                });

            }, function () { }, 'Confirmação');
        }

        //Busca todos os cursos cadastrados na base
        $scope.carregaCursos = function () {
            var res = $http.post('curso.aspx/CarregarCursos', {});

            res.success(function (data, status, headers, config) {
                if (data.d.length > 0) {
                    $scope.cursos = JSON.parse(data.d);
                }
                blockUI.stop();
            });

            res.error(function (data, status, headers, config) {
                blockUI.stop();
                $scope.alert("Mensagem de erro: " + JSON.stringify({ data: data }));
            });
        }

        //Gera o número de matrícula do aluno
        $scope.gerarMatricula = function () {
            blockUI.start();
            var res = $http.post('aluno.aspx/GerarMatricula', {'id_curso': $scope.itemForm.id_curso});

            res.success(function (data, status, headers, config) {
                if (data.d) {
                    $scope.itemForm.matricula = data.d;
                }
                blockUI.stop();
            });

            res.error(function (data, status, headers, config) {
                blockUI.stop();
                $scope.alert("Mensagem de erro: " + JSON.stringify({ data: data }));
            });
        }

        //Atualiza informações de curso
        $scope.atualizarCurso = function () {
            blockUI.start();
            var res = $http.post('aluno.aspx/AtualizarCurso', {'codigo': $scope.itemForm.codigo, 'matricula': $scope.itemForm.matricula, 'id_curso': $scope.itemForm.id_curso});

            res.success(function (data, status, headers, config) {
                if (data.d == 1) {
                    $scope.isSearch = false;
                    $scope.tableAluno.reload();
                    fecharModalAluno();
                    $scope.alert("Curso registrado com sucesso.");
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
            $scope.itemForm = {};
            angular.element("#passo2").addClass('disabled');
            angular.element("#passo2").removeClass('active');
            angular.element("#passo1").addClass('active');
            angular.element("#step2").removeClass('active');
            angular.element("#step1").addClass('active');
        }

        $scope.onEdit = function (item) {
            $scope.itemForm = angular.copy(item);
            $scope.itemForm.data_nascimento = moment(item.data_nascimento, 'YYYY/MM/DD').format('DD/MM/YYYY');
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

            if (item && item.cpf) $scope.cpf = item.cpf;
            else $scope.cpf = "";

            if (item && item.rg) $scope.rg = item.rg;
            else $scope.rg = "";

            $('.pesquisa').modal('toggle');
            $scope.tableAluno.reload();
            $scope.tableAluno.page(1);
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
            $scope.tableAluno.reload();
            $scope.tableAluno.page(1);
        }

        function fecharModalAluno() {
          $('.aluno').modal('hide');
          $('body').removeClass('modal-open');
          $('.modal-backdrop').remove();
        }

        //Inicialização
        blockUI.start();
        $scope.carregaCursos();
    }
]);
