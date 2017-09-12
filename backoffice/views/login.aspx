<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Mustache.WebUI.backoffice.views.login" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Mustache BORDO - Login</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- Bootstrap 3.3.4 -->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Font Awesome Icons -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="../dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <!-- iCheck -->
    <link href="../plugins/iCheck/square/blue.css" rel="stylesheet" type="text/css" />

    <!-- iCheck -->
    <link href="../../css/line-icons.css" rel="stylesheet" type="text/css" />

	<!--<link href="../dist/img/favicon.ico" rel="shortcut icon" />-->

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <style>
	.login-page {
		background-image: url("../../img/background-login.jpg");
	}
  </style>
  <body class="login-page">
    <div class="login-box">
      <div class="login-logo">
        <a href="/" class="logo" style="color: white"><span class="lnr lnr-mustache"></span> MUSTACHE</a>
      </div><!-- /.login-logo -->
      <div class="login-box-body">
        <p class="login-box-msg">Entre para acessar a área administrativa do sistema:</p>
        <form method="post" runat="server">
          <div class="form-group has-feedback">
              <asp:textbox id="txtUsername" runat="server" class="form-control usuario" placeholder="Usuário"></asp:textbox>
              <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
          </div>
          <div class="form-group has-feedback">
              <asp:textbox id="txtPassword" class="form-control senha" runat="server" TextMode="Password" placeholder="Senha"></asp:textbox>
              <span class="glyphicon glyphicon-lock form-control-feedback"></span>
          </div>
          <div class="row">
            <div class="col-xs-8">
              <div class="checkbox icheck">
                <label>
                  <input type="checkbox"> Lembrar
                </label>
                <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
              </div>
            </div><!-- /.col -->
            <div class="col-xs-4">
              <asp:button id="Button1" class="btn btn-primary btn-block btn-flat" runat="server" onclick="btnlogin_Click" Font-Names="Verdana" Text="Logar"></asp:button>
            </div><!-- /.col -->
          </div>
        </form>

        <a href="#">Esqueci minha senha</a><br>

      </div><!-- /.login-box-body -->
    </div><!-- /.login-box -->

    <!-- jQuery 2.1.4 -->
    <script src="../plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- Bootstrap 3.3.2 JS -->
    <script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <!-- iCheck -->
    <script src="../plugins/iCheck/icheck.min.js" type="text/javascript"></script>
    <script>
      $(function () {
        $('input').iCheck({
          checkboxClass: 'icheckbox_square-blue',
          radioClass: 'iradio_square-blue',
          increaseArea: '20%' // optional
        });
      });
    </script>
  </body>
</html>
