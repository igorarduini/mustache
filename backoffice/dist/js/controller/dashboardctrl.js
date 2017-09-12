app.controller('DashboardCtrl', ['$scope', '$http', 'blockUI',
    function ($scope, $http, blockUI) {

      $scope.plotarGrafico = function() {
        var mecChartCanvas = $("#mecChart").get(0).getContext("2d");
        var mecChart = new Chart(mecChartCanvas);

        var mecChartData = {
          labels: ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho"],
          datasets: [
            {
              label: "Reprovação",
              fillColor: "#f56954",
              strokeColor: "#f56954",
              pointColor: "#f56954",
              pointStrokeColor: "#f56954",
              pointHighlightFill: "#fff",
              pointHighlightStroke: "#f56954",
              data: $scope.dadosReprovacao
            },
            {
              label: "Aprovação",
              fillColor: "#00a65a",
              strokeColor: "#00a65a",
              pointColor: "#00a65a",
              pointStrokeColor: "#00a65a",
              pointHighlightFill: "#fff",
              pointHighlightStroke: "#00a65a",
              data: $scope.dadosAprovacao
            }
          ]
        };

        var mecChartOptions = {
          showScale: true,
          scaleShowGridLines: false,
          scaleGridLineColor: "rgba(0,0,0,.05)",
          scaleGridLineWidth: 1,
          scaleShowHorizontalLines: true,
          scaleShowVerticalLines: true,
          bezierCurve: true,
          bezierCurveTension: 0.3,
          pointDot: false,
          pointDotRadius: 4,
          pointDotStrokeWidth: 1,
          pointHitDetectionRadius: 20,
          datasetStroke: true,
          datasetStrokeWidth: 2,
          datasetFill: true,
          legendTemplate: "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<datasets.length; i++){%><li><span style=\"background-color:<%=datasets[i].lineColor%>\"></span><%=datasets[i].label%></li><%}%></ul>",
          maintainAspectRatio: false,
          responsive: true
        };

        //Cria o gráfico de linhas
        mecChart.Line(mecChartData, mecChartOptions);
        blockUI.stop();
      }

      //Busca as informações do MEC via integração
      $scope.carregarInformacoesMEC = function () {
          var res = $http.post('starter.aspx/DashboardIntegracaoMEC', {});

          res.success(function (data, status, headers, config) {
              if (data.d.length > 0) {
                  $scope.informacoesMEC = JSON.parse(data.d);
                  $scope.informacoesMEC.percentual_reprovacao = calcularPercentualReprovacao($scope.informacoesMEC);
                  $scope.dadosReprovacao = montarArrayReprovacao($scope.informacoesMEC);
                  $scope.dadosAprovacao = montarArrayAprovacao($scope.informacoesMEC);
                  $scope.plotarGrafico();
              }
          });

          res.error(function (data, status, headers, config) {
              blockUI.stop();
              $scope.alert("Mensagem de erro: " + JSON.stringify({ data: data }));
          });
      }

      function montarArrayReprovacao(info) {
        var retorno = [];
        retorno.push(info.censo[0].reprovacoes.janeiro);
        retorno.push(info.censo[0].reprovacoes.fevereiro);
        retorno.push(info.censo[0].reprovacoes.marco);
        retorno.push(info.censo[0].reprovacoes.abril);
        retorno.push(info.censo[0].reprovacoes.maio);
        retorno.push(info.censo[0].reprovacoes.junho);
        retorno.push(info.censo[0].reprovacoes.julho);
        return retorno;
      }

      function montarArrayAprovacao(info) {
        var retorno = [];
        retorno.push(info.censo[1].aprovacoes.janeiro);
        retorno.push(info.censo[1].aprovacoes.fevereiro);
        retorno.push(info.censo[1].aprovacoes.marco);
        retorno.push(info.censo[1].aprovacoes.abril);
        retorno.push(info.censo[1].aprovacoes.maio);
        retorno.push(info.censo[1].aprovacoes.junho);
        retorno.push(info.censo[1].aprovacoes.julho);
        return retorno;
      }

      function calcularPercentualReprovacao(info) {
        return Math.round(info.reprovacoes * 100 / info.alunos);
      }

      //Inicialização
      blockUI.start();
      $scope.carregarInformacoesMEC();
    }

    //{"livros":410,"alunos":500,"aprovacoes":90,"reprovacoes":25,"novos_livros":150,"percentual_presenca":53,"percentual_reprovacao":25,"censo":[{"ano":2017,"reprovacoes":{"janeiro":65,"fevereiro":59,"marco":80,"abril":81,"maio":56,"junho":55,"julho":40}},{"ano":2017,"aprovacoes":{"janeiro":28,"fevereiro":48,"marco":40,"abril":19,"maio":86,"junho":27,"julho":90}}]}
]);
