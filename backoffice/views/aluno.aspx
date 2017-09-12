<%@ Page Title="" Language="C#" MasterPageFile="~/backoffice/views/MustacheBordo.Master" AutoEventWireup="true" CodeBehind="aluno.aspx.cs" Inherits="Mustache.WebUI.backoffice.views.aluno" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div ng-controller="AlunoCtrl">
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Alunos <small>Todos os alunos cadastrados</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="starter.aspx"><i class="fa fa-home"></i>Home</a></li>
        <li class="active">Alunos</li>
      </ol>
    </section>

    <br>
    <!-- Main content -->
    <section class="content">
      <div class="box box-info">
        <div class="box-header with-border">
          <h3 class="box-title">Alunos</h3>
          <div class="box-tools pull-right">
            <a href="#" ng-if="isSearch" class="btn btn-sm btn-danger btn-flat pull-left" style="margin-right: 5px;" data-toggle="modal" ng-click="onClean()"><i class="fa fa-eraser"></i>&nbsp; Limpar</a>
				    <a href="#" class="btn btn-sm btn-success btn-flat pull-left" style="margin-right: 5px;" data-toggle="modal" ng-click="onSearchMode()" data-target="#pesquisarAluno"><i class="fa fa-search"></i>&nbsp; Pesquisar</a>
            <a href="#" class="btn btn-sm btn-info btn-flat pull-left" ng-click="onInsertMode()" data-toggle="modal" data-target="#novoAluno"><i class="fa fa-plus"></i>&nbsp; Novo Aluno</a>
          </div>
        </div><!-- /.box-header -->
        <div class="box-body">
          <div class="table-responsive">
            <table ng-table="tableAluno" class="table table-bordered table-striped table-hover">
              <tbody>
                <tr ng-repeat="item1 in $data | filter:item">
                  <td ng-style="{ 'width': '7%' }" data-title="'#'" sortable="'codigo'">{{item1.codigo}}</td>
                  <td ng-style="{ 'width': '15%' }" data-title="'Nome'" sortable="'nome'">{{item1.nome + ' ' + item1.sobrenome}}</td>
                  <td ng-style="{ 'width': '10%' }" data-title="'Telefone'" sortable="'telefone'">{{item1.telefone}}</td>
                  <td ng-style="{ 'width': '10%' }" data-title="'CPF'" sortable="'cpf'">{{item1.cpf}}</td>
                  <td ng-style="{ 'width': '10%' }" data-title="'RG'" sortable="'rg'">{{item1.rg}}</td>
                  <td ng-style="{ 'width': '23%' }" data-title="'Email'" sortable="'email'">{{item1.email}}</td>
                  <td ng-style="{ 'width': '15%' }" class="action-buttons center">
                    <a href="#" class="btn btn-sm btn-info btn-flat pull-left" style="margin-right: 5px;" data-toggle="modal" data-target="#novoAluno" ng-click="onEdit(item1)"><i class="fa fa-edit"></i>&nbsp;</a>
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

  <!-- MODAL ALUNO -->
  <div class="modal fade aluno" id="novoAluno" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header texto-modal-azul">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">Aluno</h4>
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
                        <a href="#step2" data-toggle="tab" aria-controls="step2" role="tab" title="Curso">
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
                        <form name="alunoForm" ng-submit="onSave()" novalidate>
                          <div class="modal-body">
                            <h3>Detalhes</h3>
                            <div class="row">
                            </div>
                            <div class="row">
                              <div class="form-group col-xs-6" ng-class="{ 'has-error' : alunoForm.nome.$invalid && !alunoForm.name.$pristine }">
                                <label for="nome" class="col-sm-4 control-label">Nome (*)</label>
                                <div class="col-sm-8">
                                  <input type="text" class="form-control" name="nome" ng-model="itemForm.nome" placeholder="Nome" maxlength="50" required>
                                </div>
                              </div>
                              <div class="form-group col-xs-6" ng-class="{ 'has-error' : alunoForm.sobrenome.$invalid && !alunoForm.sobrenome.$pristine }">
                                <label for="nome" class="col-sm-4 control-label">Sobrenome (*)</label>
                                <div class="col-sm-8">
                                  <input type="text" class="form-control" name="sobrenome" ng-model="itemForm.sobrenome" placeholder="Sobrenome" maxlength="100" required>
                                </div>
                              </div>
                              <div class="form-group col-xs-6" ng-class="{ 'has-error' : alunoForm.naturalidade.$invalid && !alunoForm.naturalidade.$pristine }">
                                <label for="nome" class="col-sm-4 control-label">Naturalidade (*)</label>
                                <div class="col-sm-8">
                                  <input type="text" class="form-control" name="naturalidade" ng-model="itemForm.naturalidade" placeholder="Naturalidade" maxlength="50" required>
                                </div>
                              </div>
                              <div class="form-group col-xs-6" ng-class="{ 'has-error' : alunoForm.nacionalidade.$invalid && !alunoForm.nacionalidade.$pristine }">
                                <label for="nome" class="col-sm-4 control-label">Nacionalidade (*)</label>
                                <div class="col-sm-8">
                                  <input type="text" class="form-control" name="nacionalidade" ng-model="itemForm.nacionalidade" placeholder="Nacionalidade" maxlength="50" required>
                                </div>
                              </div>
                              <div class="form-group col-xs-6" ng-class="{ 'has-error' : alunoForm.rg.$invalid && !alunoForm.rg.$pristine }">
                                <label for="nome" class="col-sm-4 control-label">RG (*)</label>
                                <div class="col-sm-8">
                                  <input type="text" class="form-control" name="rg" ng-model="itemForm.rg" placeholder="RG" maxlength="10" required data-inputmask='"mask": "99.999.999"' data-mask>
                                </div>
                              </div>
                              <div class="form-group col-xs-6" ng-class="{ 'has-error' : alunoForm.cpf.$invalid && !alunoForm.cpf.$pristine }">
                                <label for="nome" class="col-sm-4 control-label">CPF (*)</label>
                                <div class="col-sm-8">
                                  <input type="text" class="form-control" name="cpf" ng-model="itemForm.cpf" placeholder="CPF" maxlength="14" required data-inputmask='"mask": "999.999.999-99"' data-mask>
                                </div>
                              </div>
                              <div class="form-group col-xs-6" ng-class="{ 'has-error' : alunoForm.data_nascimento.$invalid && !alunoForm.data_nascimento.$pristine }">
                                <label for="nome" class="col-sm-4 control-label">Nascimento (*)</label>
                                <div class="col-sm-8">
                                  <div class="input-group">
                                    <div class="input-group-addon">
                                      <i class="fa fa-calendar"></i>
                                    </div>
                                    <input type="text" class="form-control" name="data_nascimento" id="data_nascimento" ng-model="itemForm.data_nascimento" placeholder="Data de Nascimento" maxlength="11" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask required/>
                                  </div>
                                </div>
                              </div>
                              <div class="form-group col-xs-6" ng-class="{ 'has-error' : alunoForm.email.$invalid && !alunoForm.email.$pristine }">
                                <label for="nome" class="col-sm-4 control-label">Email (*)</label>
                                <div class="col-sm-8">
                                  <div class="input-group">
                                    <div class="input-group-addon">
                                      <i class="fa fa-envelope"></i>
                                    </div>
                                    <input type="text" class="form-control" name="email" ng-model="itemForm.email" placeholder="Email" maxlength="50" required>
                                  </div>
                                </div>
                              </div>
                              <div class="form-group col-xs-6" ng-class="{ 'has-error' : alunoForm.endereco.$invalid && !alunoForm.endereco.$pristine }">
                                <label for="nome" class="col-sm-4 control-label">Logradouro (*)</label>
                                <div class="col-sm-8">
                                  <input type="text" class="form-control" name="endereco" ng-model="itemForm.endereco" placeholder="Logradouro" maxlength="50" required>
                                </div>
                              </div>
                              <div class="form-group col-xs-6" ng-class="{ 'has-error' : alunoForm.telefone.$invalid && !alunoForm.telefone.$pristine }">
                                <label for="nome" class="col-sm-4 control-label">Telefone (*)</label>
                                <div class="col-sm-8">
                                  <div class="input-group">
                                    <div class="input-group-addon">
                                      <i class="fa fa-phone"></i>
                                    </div>
                                    <input type="text" class="form-control" name="telefone" ng-model="itemForm.telefone" placeholder="Telefone" maxlength="13" data-inputmask='"mask": "(99)9999-9999"' data-mask required>
                                  </div>
                                </div>
                              </div>
                            </div>

                            <div class="row">
                            </div>
                          </div>
                          <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-close"></i>&nbsp; Cancelar</button>
                            <button type="button" class="btn btn-primary" ng-click="onSaveDetalhes()"><i class="fa fa-arrow-right"></i>&nbsp; Salvar e Continuar</button>
                          </div>
                        </form>
                    </div>
                    <div class="tab-pane" role="tabpanel" id="step2">
                      <div class="modal-body">
                        <h3>Informações</h3>
                        <div class="row"></div>
                        <div class="row">
                          <div class="form-group col-xs-6" ng-class="{ 'has-error' : cursoForm.rg.$invalid && !cursoForm.rg.$pristine }">
                            <label for="nome" class="col-sm-4 control-label">Curso</label>
                            <div class="col-sm-8">
                              <select class="form-control" ng-model="itemForm.id_curso" name="id_curso" required>
                                  <option value=""></option>
                                  <option ng-repeat="item in cursos" value="{{item.codigo}}">{{item.nome}}</option>
                              </select>
                            </div>
                          </div>
                        </div>
                        <div class="row">
                          <div class="form-group col-xs-6">
                            <label for="nome" class="col-sm-4 control-label">Matrícula</label>
                            <div class="col-sm-8">
                              <input class="form-control" type="text" ng-model="itemForm.matricula" ng-disabled="true">
                            </div>
                          </div>
                          <div class="form-group col-xs-6 input-group input-group-sm">
                              <button class="btn btn-info btn-flat" type="button" ng-click="gerarMatricula(itemForm.id_curso)" ng-disabled="!itemForm.id_curso || itemForm.matricula">Gerar Matrícula</button>
                          </div>
                        </div>
                        <ul class="list-inline pull-right">
                            <li><button type="button" class="btn btn-default prev-step"><i class="fa fa-arrow-left"></i>&nbsp; Voltar</button></li>
                            <li><button type="button" class="btn btn-primary" ng-click="atualizarCurso()"><i class="fa fa-check"></i>&nbsp;Finalizar</button></li>
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
  <div class="modal fade pesquisa" id="pesquisarAluno" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header texto-modal-verde">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="H1">Pesquisar Aluno</h4>
        </div>
        <div class="modal-body">
          <div class="row">
            <div class="form-group col-xs-6">
              <label for="nome" class="col-sm-4 control-label">Nome</label>
              <div class="col-sm-8">
                <input type="text" class="form-control" id="nome" ng-model="itemSearch.nome" placeholder="nome" maxlength="50">
              </div>
            </div>
            <div class="form-group col-xs-6">
              <label for="nome" class="col-sm-4 control-label">CPF</label>
              <div class="col-sm-8">
                <input type="text" class="form-control" id="cpf" ng-model="itemSearch.cpf" placeholder="cpf" maxlength="14" data-inputmask='"mask": "999.999.999-99"' data-mask>
              </div>
            </div>
            <div class="form-group col-xs-6">
              <label for="nome" class="col-sm-4 control-label">RG</label>
              <div class="col-sm-8">
                <input type="text" class="form-control" id="rg" ng-model="itemSearch.rg" placeholder="rg" maxlength="10" data-inputmask='"mask": "99.999.999"' data-mask>
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
  $(".aluno").addClass("active");
  $(".curso").removeClass("active");

  $("#data_nascimento").inputmask("dd/mm/yyyy", {"placeholder": "dd/mm/yyyy"});
  $("[data-mask]").inputmask();
</script>
</asp:Content>
