using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Web.Configuration;
using System.Web.Services;
using Centro_Universitário_Mustache.Utils;

namespace Mustache.WebUI.backoffice.views
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public int ValidateLogin(string usuario, string senha)
        {

            if (!String.IsNullOrEmpty(usuario) && !String.IsNullOrEmpty(senha))
            {
                object result;
                MySqlConnection conexao = new MySqlConnection(WebConfigurationManager.ConnectionStrings["mustacheDB"].ToString());

                senha = SenhaUtils.HashSHA1(senha);

                MySqlCommand comando = new MySqlCommand("SELECT 1 FROM login WHERE usuario = @usuario AND senha = @senha", conexao);
                comando.Parameters.Add(new MySqlParameter("usuario", usuario));
                comando.Parameters.Add(new MySqlParameter("senha", senha));

                try
                {
                    conexao.Open();
                    result = comando.ExecuteScalar();

                    if (Convert.ToInt32(result) == 1)
                    {
                        Session["usuarioLogado"] = usuario;
                        return 1;
                    }
                    else
                    {
                        Session.Abandon();
                        return 0;
                    }
                }
                finally
                {
                    conexao.Close();
                }

            }
            else
            {
                return 0;
            }
        }

        protected void btnlogin_Click(object sender, EventArgs e)
        {

            int Results = 0;

            if (txtUsername.Text != string.Empty && txtPassword.Text != string.Empty)
            {

                Results = ValidateLogin(txtUsername.Text.Trim(), txtPassword.Text.Trim());

                if (Results == 1)
                {
                    Response.Redirect("/backoffice/views/starter.aspx");
                }
                else
                {
                    lblMessage.Text = "Login inválido.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }

            }
            else
            {
                lblMessage.Text = "Por favor verifique se seu usuário e senha estão corretos.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }

        }
    }
}