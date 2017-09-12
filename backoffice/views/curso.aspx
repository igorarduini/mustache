<%@ Page Title="" Language="C#" MasterPageFile="~/backoffice/views/MustacheBordo.Master" AutoEventWireup="true" CodeBehind="curso.aspx.cs" Inherits="Mustache.WebUI.backoffice.views.curso" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div ng-controller="CursoCtrl">
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Cursos <small>Todos os cursos cadastrados</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="starter.aspx"><i class="fa fa-home"></i>Home</a></li>
        <li class="active">Cursos</li>
      </ol>
    </section>

    <br>
    <!-- Main content -->
    <section class="content">
      <div class="box box-info">
        <div class="box-header with-border">
          <h3 class="box-title">Cursos</h3>
          <div class="box-tools pull-right">
            <a href="#" ng-if="isSearch" class="btn btn-sm btn-danger btn-flat pull-left" style="margin-right: 5px;" data-toggle="modal" ng-click="onClean()"><i class="fa fa-eraser"></i>&nbsp; Limpar</a>
				    <a href="#" class="btn btn-sm btn-success btn-flat pull-left" style="margin-right: 5px;" data-toggle="modal" ng-click="onSearchMode()" data-target="#pesquisarCurso"><i class="fa fa-search"></i>&nbsp; Pesquisar</a>
            <a href="#" class="btn btn-sm btn-info btn-flat pull-left" ng-click="onInsertMode()" data-toggle="modal" data-target="#novoCurso"><i class="fa fa-plus"></i>&nbsp; Novo Curso</a>
          </div>
        </div><!-- /.box-header -->
        <div class="box-body">
          <div class="table-responsive">
            <table ng-table="tableCurso" class="table table-bordered table-striped table-hover">
              <tbody>
                <tr ng-repeat="item1 in $data | filter:item">
                  <td ng-style="{ 'width': '7%' }" data-title="'#'" sortable="'codigo'">{{item1.codigo}}</td>
                  <td ng-style="{ 'width': '15%' }" data-title="'Nome'" sortable="'nome'">{{item1.nome}}</td>
                  <td ng-style="{ 'width': '10%' }" data-title="'Ícone'" sortable="'icone'">{{item1.icone}}</td>
                  <td ng-style="{ 'width': '10%' }" data-title="'Tipo Curso'" sortable="'tipo_curso'">{{item1.tipo_curso}}</td>
                  <td ng-style="{ 'width': '10%' }" data-title="'Valor Total'" sortable="'valor_total'">{{item1.valor_total}}</td>
                  <td ng-style="{ 'width': '10%' }" data-title="'Valor Período'" sortable="'valor_periodo'">{{item1.valor_periodo}}</td>
                  <td ng-style="{ 'width': '10%' }" data-title="'Duração'" sortable="'duracao'">{{item1.duracao_anos + ' anos'}}</td>
                  <td ng-style="{ 'width': '15%' }" class="action-buttons center">
                    <a href="#" class="btn btn-sm btn-info btn-flat pull-left" style="margin-right: 5px;" data-toggle="modal" data-target="#novoCurso" ng-click="onEdit(item1)"><i class="fa fa-edit"></i>&nbsp;</a>
                    <a href="#" class="btn btn-sm btn-danger btn-flat pull-left" ng-click="onDelete(item1)"><i class="fa fa-trash-o"></i>&nbsp;</a>
                  </td>
                </tr>
                <tr ng-show="$data.length == 0 && $data != undefined">
                  <td colspan="7" class="text-center">Nenhum registro encontrado</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div><!-- /.box-body -->

        <div class="box-footer clearfix"></div><!-- /.box-footer -->
      </div><!-- /.box -->
    </section><!-- /.content -->
  </div><!-- /.content-wrapper -->

  <div class='control-sidebar-bg'></div>

  <!-- MODAL CURSO -->
  <div class="modal fade curso" id="novoCurso" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header texto-modal-azul">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">Curso</h4>
        </div>
        <div class="wizard">
            <div class="wizard-inner">
                <div class="connecting-line"></div>
                <ul class="nav nav-tabs" role="tablist">

                    <li id="passo1" role="presentation" class="active step1">
                        <a href="#step1" data-toggle="tab" aria-controls="step1" role="tab" title="Detalhes">
                            <span class="round-tab">
                                <i class="glyphicon glyphicon-info-sign"></i>
                            </span>
                        </a>
                    </li>

                    <li id="passo2" role="presentation" class="disabled step2">
                        <a href="#step2" data-toggle="tab" aria-controls="step2" role="tab" title="Descrição">
                            <span class="round-tab">
                                <i class="glyphicon glyphicon-briefcase"></i>
                            </span>
                        </a>
                    </li>
                </ul>
            </div>

            <form role="form">
                <div class="tab-content">
                    <div class="tab-pane active" role="tabpanel" id="step1">
                        <form name="cursoForm" ng-submit="onSave()" novalidate>
                          <div class="modal-body">
                            <h3>Detalhes</h3>
                            <div class="row">
                            </div>
                            <div class="row">
                              <div class="form-group col-xs-6" ng-class="{ 'has-error' : cursoForm.nome.$invalid && !cursoForm.nome.$pristine }">
                                <label for="nome" class="col-sm-4 control-label">Nome (*)</label>
                                <div class="col-sm-8">
                                  <input type="text" class="form-control" name="nome" ng-model="itemForm.nome" placeholder="Nome" maxlength="50" required>
                                </div>
                              </div>
                              <div class="form-group col-xs-6" ng-class="{ 'has-error' : cursoForm.rg.$invalid && !cursoForm.rg.$pristine }">
                                <label for="nome" class="col-sm-4 control-label">Tipo de Curso (*)</label>
                                <div class="col-sm-8">
                                  <select class="form-control" ng-model="itemForm.id_tipo_curso" name="id_tipo_curso" required>
                                      <option value=""></option>
                                      <option ng-repeat="item in tiposCurso" value="{{item.codigo}}">{{item.nome}}</option>
                                  </select>
                                </div>
                              </div>
                              <div class="form-group col-xs-6" ng-class="{ 'has-error' : cursoForm.valor_periodo.$invalid && !cursoForm.valor_periodo.$pristine }">
                                <label for="valor_periodo" class="col-sm-4 control-label">Valor Período (*)</label>
                                <div class="col-sm-8">
                                  <div class="input-group">
                                    <div class="input-group-addon">
                                      <i class="fa fa-money"></i>
                                    </div>
                                    <input type="text" class="form-control" name="sobrenome" ng-model="itemForm.valor_periodo" placeholder="Valor Período" maxlength="12" required format="number">
                                  </div>
                                </div>
                              </div>
                              <div class="form-group col-xs-6" ng-class="{ 'has-error' : cursoForm.valor_total.$invalid && !cursoForm.valor_total.$pristine }">
                                <label for="valor_total" class="col-sm-4 control-label">Valor Total (*)</label>
                                <div class="col-sm-8">
                                  <div class="input-group">
                                    <div class="input-group-addon">
                                      <i class="fa fa-money"></i>
                                    </div>
                                    <input type="text" class="form-control" name="valor_total" ng-model="itemForm.valor_total" placeholder="Valor Total" maxlength="12" required format="number">
                                  </div>
                                </div>
                              </div>
                              <div class="form-group col-xs-6" ng-class="{ 'has-error' : cursoForm.duracao_anos.$invalid && !cursoForm.duracao_anos.$pristine }">
                                <label for="duracao_anos" class="col-sm-4 control-label">Duração (*)</label>
                                <div class="col-sm-8">
                                  <input type="text" class="form-control" name="duracao_anos" ng-model="itemForm.duracao_anos" placeholder="Duração em Anos" maxlength="1" required>
                                </div>
                              </div>
                              <div class="form-group col-xs-6" ng-class="{ 'has-error' : cursoForm.icone.$invalid && !cursoForm.icone.$pristine }">
                                <label for="icone" class="col-sm-4 control-label">Ícone (*)</label>
                                <div class="col-sm-8">
                                  <div class="input-group">
                                    <div class="input-group-addon">
                                      <i class="fa fa-font"></i>
                                    </div>
                                    <input type="text" class="form-control" name="icone" ng-model="itemForm.icone" placeholder="Ícone" maxlength="30" required>
                                  </div>
                                </div>
                              </div>
                            </div>

                            <div class="row">
                            </div>
                          </div>
                          <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-close"></i>&nbsp; Cancelar</button>
                            <button type="button" class="btn btn-primary next-step"><i class="fa fa-arrow-right"></i>&nbsp; Próximo</button>
                          </div>
                        </form>
                    </div>
                    <div class="tab-pane" role="tabpanel" id="step2">
                        <div class="modal-body">
                          <h3>Descrição</h3>
                          <div class="form-group">
                            <textarea class="form-control" rows="6" placeholder="Descrição" ng-model="itemForm.descricao" maxlength="500"></textarea>
                          </div>
                          <ul class="list-inline pull-right">
                              <li><button type="button" class="btn btn-default prev-step"><i class="fa fa-arrow-left"></i>&nbsp; Voltar</button></li>
                              <li><button type="button" class="btn btn-primary" ng-click="onSaveDetalhes()"><i class="fa fa-check"></i>&nbsp;Finalizar</button></li>
                          </ul>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </form>
        </div>
      </div>
    </div>
  </div>

  <!-- MODAL PESQUISAR ALUNO -->
  <div class="modal fade pesquisa" id="pesquisarCurso" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header texto-modal-verde">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="H1">Pesquisar Curso</h4>
        </div>
        <div class="modal-body">
          <div id="Div2" class="tabbable">
            <div class="container">
              <div class="row">
                <div class="form-group">
                  <label class="col-sm-2">Nome</label>
                  <div class="col-xs-12 col-sm-7">
                    <input type="text" class="form-control" id="modelo" ng-model="itemSearch.nome" placeholder="nome" maxlength="50">
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-close"></i>&nbsp; Cancelar</button>
          <button type="button" class="btn btn-success" ng-click="onSearch(itemSearch)"><i class="fa fa-check"></i>&nbsp; Pesquisar</button>
        </div>
      </div>
    </div>
  </div>
</div>

<script>
  $(".home").removeClass("active");
  $(".aluno").removeClass("active");
  $(".curso").addClass("active");

  $("#data_nascimento").inputmask("dd/mm/yyyy", {"placeholder": "dd/mm/yyyy"});
  $("[data-mask]").inputmask();
</script>
</asp:Content>
