<%@ Page Title="" Language="C#" MasterPageFile="~/backoffice/views/MustacheBordo.Master" AutoEventWireup="true" CodeBehind="alterarsenha.aspx.cs" Inherits="Mustache.WebUI.backoffice.views.alterarsenha" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div ng-controller="AlterarSenhaCtrl">
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>
                    Alterar Senha
                </h1>
                <ol class="breadcrumb">
                    <li><a href="starter.aspx"><i class="fa fa-home"></i>Home</a></li>
                    <li class="active">Alterar Senha</li>
                </ol>
            </section>

            <br>
            <!-- Main content -->
            <section class="content col-md-8 col-xs-12">
                <div class="box box-info">
                    <div class="box-header with-border">
                        <h3 class="box-title">Alterar Senha</h3>
                    </div><!-- /.box-header -->
                    <!-- form start -->
                    <form class="form-horizontal">
                        <div class="box-body">
                            <div class="form-group">
                              <label for="inputEmail3" class="col-sm-2 control-label">Usuário (*)</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="inputEmail3" ng-model="item.usuario" maxlength="50" placeholder="Usuário">
                                </div>
                            </div>
                            <br />
                            <br />
                            <div class="form-group">
                                <label for="inputPassword3" class="col-sm-2 control-label">Senha (*)</label>
                                <div class="col-sm-10">
                                    <input type="password" class="form-control" id="inputPassword3" ng-model="item.senha" maxlength="10" placeholder="Password">
                                </div>
                            </div>
                            <br />
                        </div><!-- /.box-body -->
                        <div class="box-footer">
                            <input type="button" class="btn btn-danger" ng-click="onCancel()" value="Cancelar"></input>
                            <input type="button" class="btn btn-info pull-right" ng-click="onSave(item)" value="Salvar"></input>
                        </div><!-- /.box-footer -->
                    </form>
              </div><!-- /.box -->
            </section>
        </div>
    </div>

</asp:Content>
