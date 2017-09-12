using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data.SqlClient;
using System.Reflection;
using System.Web.Services;
using MySql.Data.MySqlClient;
using System.Data;
using System.Configuration;
using System.Web.Configuration;
using System.Net.Mail;
using System.Net;
using System.Net.Mime;
using Newtonsoft.Json;
using System.Text;
using System.IO;
using Centro_Universitário_Mustache.Utils;

namespace Mustache.WebUI.backoffice.views
{
    public partial class alterarsenha : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuarioLogado"] == null)
            {
                Response.Redirect("/backoffice/views/login.aspx");
            }
        }

        [WebMethod]
        public static dynamic AtualizarSenha(string usuario, string senha)
        {

            Object result;

            senha = SenhaUtils.HashSHA1(senha);

            MySqlConnection conexao = new MySqlConnection(WebConfigurationManager.ConnectionStrings["mustacheDB"].ToString());
            MySqlCommand comando = new MySqlCommand("UPDATE login SET usuario = @usuario, senha = @senha, data_alteracao = NOW() WHERE codigo = 1", conexao);

            comando.Parameters.Add(new MySqlParameter("usuario", usuario));
            comando.Parameters.Add(new MySqlParameter("senha", senha));

            try
            {
                conexao.Open();
                result = comando.ExecuteNonQuery();
            }
            finally
            {
                conexao.Close();
            }

            return result;
        }

    }
}