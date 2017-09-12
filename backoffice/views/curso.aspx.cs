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

namespace Mustache.WebUI.backoffice.views
{
    public partial class curso : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuarioLogado"] == null)
            {
                Response.Redirect("/backoffice/views/login.aspx");
            }
        }

        [WebMethod]
        public static dynamic SalvarCurso(string nome, string valor_periodo, string valor_total, double duracao_anos, int id_tipo_curso, string descricao, string icone)
        {
            MySqlConnection conexao = new MySqlConnection(WebConfigurationManager.ConnectionStrings["mustacheDB"].ToString());
            MySqlCommand comando = new MySqlCommand(@"INSERT INTO curso (nome, valor_periodo, valor_total, duracao_anos, id_tipo_curso, descricao, icone) 
                VALUES (@nome, @valor_periodo, @valor_total, @duracao_anos, @id_tipo_curso, @descricao, @icone)", conexao);
            
            comando.Parameters.Add(new MySqlParameter("nome", nome));
            comando.Parameters.Add(new MySqlParameter("valor_periodo", valor_periodo.Replace(".", "").Replace(",", ".")));
            comando.Parameters.Add(new MySqlParameter("valor_total", valor_total.Replace(".", "").Replace(",", ".")));
            comando.Parameters.Add(new MySqlParameter("duracao_anos", duracao_anos));
            comando.Parameters.Add(new MySqlParameter("id_tipo_curso", id_tipo_curso));
            comando.Parameters.Add(new MySqlParameter("descricao", descricao));
            comando.Parameters.Add(new MySqlParameter("icone", icone));
            return ExecutarQuery(conexao, comando);
        }

        [WebMethod]
        public static dynamic AtualizarCurso(int codigo, string nome, string valor_periodo, string valor_total, double duracao_anos, int id_tipo_curso, string descricao, string icone)
        {
            MySqlConnection conexao = new MySqlConnection(WebConfigurationManager.ConnectionStrings["mustacheDB"].ToString());
            MySqlCommand comando = new MySqlCommand(@"UPDATE curso SET nome = @nome, valor_periodo = @valor_periodo, valor_total = @valor_total, duracao_anos = @duracao_anos, 
                id_tipo_curso = @id_tipo_curso, descricao = @descricao, icone = @icone, data_alteracao = NOW() 
                WHERE codigo = @codigo", conexao);

            comando.Parameters.Add(new MySqlParameter("codigo", codigo));
            comando.Parameters.Add(new MySqlParameter("nome", nome));
            comando.Parameters.Add(new MySqlParameter("valor_periodo", valor_periodo.Replace(".", "").Replace(",", ".")));
            comando.Parameters.Add(new MySqlParameter("valor_total", valor_total.Replace(".", "").Replace(",", ".")));
            comando.Parameters.Add(new MySqlParameter("duracao_anos", duracao_anos));
            comando.Parameters.Add(new MySqlParameter("id_tipo_curso", id_tipo_curso));
            comando.Parameters.Add(new MySqlParameter("descricao", descricao));
            comando.Parameters.Add(new MySqlParameter("icone", icone));

            return ExecutarQuery(conexao, comando);
        }

        [WebMethod]
        public static dynamic CarregarCursosPesquisa(string nome)
        {
            MySqlConnection conexao = new MySqlConnection(WebConfigurationManager.ConnectionStrings["mustacheDB"].ToString());

            string sql = @"SELECT c.*, tc.nome as tipo_curso FROM curso c INNER JOIN tipo_curso tc ON tc.codigo = c.id_tipo_curso WHERE 1 = 1 ";

            if (!String.IsNullOrEmpty(nome))
            {
                sql += " AND c.nome like '%" + nome + "%'";
            }

            MySqlCommand comando = new MySqlCommand(sql, conexao);
            return retornoDatabase(conexao, comando);
        }

        [WebMethod]
        public static dynamic CarregarTipoCurso()
        {
            Util util = new Util();
            MySqlConnection conexao = new MySqlConnection(WebConfigurationManager.ConnectionStrings["mustacheDB"].ToString());
            MySqlCommand comando = new MySqlCommand("SELECT * FROM tipo_curso", conexao);

            try
            {
                conexao.Open();
                IDataReader reader = comando.ExecuteReader();
                return util.ConvertReaderTOJson(reader);
            }
            finally
            {
                conexao.Close();
            }
        }

        [WebMethod]
        public static dynamic CarregarCursos()
        {
            MySqlConnection conexao = new MySqlConnection(WebConfigurationManager.ConnectionStrings["mustacheDB"].ToString());
            MySqlCommand comando = new MySqlCommand("SELECT c.*, tc.nome as tipo_curso FROM curso c INNER JOIN tipo_curso tc ON tc.codigo = c.id_tipo_curso", conexao);
            return retornoDatabase(conexao, comando);
        }

        [WebMethod]
        public static dynamic DeletarCurso(int codigo)
        {
            MySqlConnection conexao = new MySqlConnection(WebConfigurationManager.ConnectionStrings["mustacheDB"].ToString());
            MySqlCommand comando = new MySqlCommand("DELETE FROM curso WHERE codigo = @codigo", conexao);

            comando.Parameters.Add(new MySqlParameter("codigo", codigo));
            return ExecutarQuery(conexao, comando);
        }

        private static object ExecutarQuery(MySqlConnection conexao, MySqlCommand comando)
        {
            Object result;
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

        private static dynamic retornoDatabase(MySqlConnection conexao, MySqlCommand comando)
        {
            try
            {
                Util util = new Util();
                conexao.Open();
                IDataReader reader = comando.ExecuteReader();
                return util.ConvertReaderTOJson(reader);
            }
            finally
            {
                conexao.Close();
            }
        }

    }
}
