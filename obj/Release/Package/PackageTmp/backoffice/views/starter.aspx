<%@ Page Title="" Language="C#" MasterPageFile="~/backoffice/views/MustacheBordo.Master" AutoEventWireup="true" CodeBehind="starter.aspx.cs" Inherits="Mustache.WebUI.backoffice.views.starter" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <style>
    .small-box .icon {
      top: 3px;
    }
  </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div ng-controller="DashboardCtrl">
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            Dashboard <small>Detalhes MEC</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li class="active">Dashboard</li>
          </ol>
        </section>
        <!-- Main content -->
        <section class="content">

          <div class="row">
            <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box">
                <span class="info-box-icon bg-aqua">
                  <i class="fa fa-book" style="margin-top: 18px"></i>
                </span>
                <div class="info-box-content">
                  <span class="info-box-text">Livros</span>
                  <span class="info-box-number" ng-bind="informacoesMEC.livros"></span>
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
            </div><!-- /.col -->
            <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box">
                <span class="info-box-icon bg-yellow"><i class="fa fa-users" style="margin-top: 18px"></i></span>
                <div class="info-box-content">
                  <span class="info-box-text">Alunos</span>
                  <span class="info-box-number">774</span>
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
            </div><!-- /.col -->
            <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box">
                <span class="info-box-icon bg-green"><i class="fa fa-thumbs-o-up" style="margin-top: 18px"></i></span>
                <div class="info-box-content">
                  <span class="info-box-text">Aprovados</span>
                  <span class="info-box-number" ng-bind="informacoesMEC.aprovacoes"></span>
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
            </div><!-- /.col -->
            <div class="col-md-3 col-sm-6 col-xs-12">
              <div class="info-box">
                <span class="info-box-icon bg-red"><i class="fa fa-thumbs-o-down" style="margin-top: 18px"></i></span>
                <div class="info-box-content">
                  <span class="info-box-text">Reprovados</span>
                  <span class="info-box-number" ng-bind="informacoesMEC.reprovacoes"></span>
                </div><!-- /.info-box-content -->
              </div><!-- /.info-box -->
            </div><!-- /.col -->
          </div><!-- /.row -->

          <!-- Small boxes (Stat box) -->
          <div class="row">
            <div class="col-lg-3 col-xs-6">
              <!-- small box -->
              <div class="small-box bg-aqua">
                <div class="inner">
                  <h3 ng-bind="informacoesMEC.novos_livros"></h3>
                  <p>Novos livros</p>
                </div>
                <div class="icon">
                  <i class="fa fa-shopping-cart"></i>
                </div>
              </div>
            </div><!-- ./col -->
            <div class="col-lg-3 col-xs-6">
              <!-- small box -->
              <div class="small-box bg-yellow">
                <div class="inner">
                  <h3>45</h3>
                  <p>Novos Alunos</p>
                </div>
                <div class="icon">
                  <i class="ion ion-person-add"></i>
                </div>
              </div>
            </div><!-- ./col -->
            <div class="col-lg-3 col-xs-6">
              <!-- small box -->
              <div class="small-box bg-green">
                <div class="inner">
                  <h3>{{informacoesMEC.percentual_presenca || 0}}<sup style="font-size: 20px">%</sup></h3>
                  <p>Percentual Presença</p>
                </div>
                <div class="icon">
                  <i class="ion ion-stats-bars"></i>
                </div>
              </div>
            </div><!-- ./col -->
            <div class="col-lg-3 col-xs-6">
              <!-- small box -->
              <div class="small-box bg-red">
                <div class="inner">
                  <h3>{{informacoesMEC.percentual_reprovacao || 0}}<sup style="font-size: 20px">%</sup></h3>
                  <p>Percentual Reprovação</p>
                </div>
                <div class="icon">
                  <i class="ion ion-pie-graph"></i>
                </div>
              </div>
            </div><!-- ./col -->
          </div><!-- /.row -->
          <div class="row">
            <div class="col-md-12">
              <div class="box">
                <div class="box-header with-border">
                  <h3 class="box-title">Relatório de Aproveitamento dos Alunos</h3>
                  <div class="box-tools pull-right">
                    <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    <button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                  </div>
                </div><!-- /.box-header -->
                <div class="box-body">
                  <div class="row">
                    <div class="col-md-8">
                      <p class="text-center">
                        <strong>Aprovações e Reprovações: 01 Jan de 2017 - 31 Jul de 2017</strong>
                      </p>
                      <div class="chart">
                        <!-- Sales Chart Canvas -->
                        <canvas id="mecChart" height="180"></canvas>
                      </div><!-- /.chart-responsive -->
                    </div><!-- /.col -->
                    <div class="col-md-4">
                      <p class="text-center">
                        <strong>Resumo</strong>
                      </p>
                      <div class="progress-group">
                        <span class="progress-text">Reprovados</span>
                        <span class="progress-number"><b>{{informacoesMEC.reprovacoes}}</b>/{{informacoesMEC.alunos}}</span>
                        <div class="progress sm">
                          <div class="progress-bar progress-bar-red" style="width: 80%"></div>
                        </div>
                      </div><!-- /.progress-group -->
                      <div class="progress-group">
                        <span class="progress-text">Aprovados</span>
                        <span class="progress-number"><b>{{informacoesMEC.aprovacoes}}</b>/{{informacoesMEC.alunos}}</span>
                        <div class="progress sm">
                          <div class="progress-bar progress-bar-green" style="width: 80%"></div>
                        </div>
                      </div>
                    </div><!-- /.col -->
                  </div><!-- /.row -->
                </div><!-- ./box-body -->
              </div><!-- /.box -->
            </div><!-- /.col -->
          </div><!-- /.row (main row) -->

        </section><!-- /.content -->
      </div>
    </div>
    <div class='control-sidebar-bg'></div>

    <script>
        $(".home").addClass("active");
        $(".aluno").removeClass("active");
        $(".curso").removeClass("active");
    </script>
</asp:Content>
