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
    public partial class aluno : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuarioLogado"] == null)
            {
                Response.Redirect("/backoffice/views/login.aspx");
            }
        }

        [WebMethod]
        public static dynamic SalvarAluno(String nome, String sobrenome, String email, String data_nascimento, String cpf, String rg, String nacionalidade, String naturalidade, String telefone, String endereco)
        {
            MySqlConnection conexao = new MySqlConnection(WebConfigurationManager.ConnectionStrings["mustacheDB"].ToString());
            MySqlCommand comando = new MySqlCommand(@"INSERT INTO aluno (nome, sobrenome, cpf, rg, naturalidade, nacionalidade, data_nascimento, telefone, email, endereco) 
                VALUES (@nome, @sobrenome, @cpf, @rg, @naturalidade, @nacionalidade, @data_nascimento, @telefone, @email, @endereco);", conexao);
            
            comando.Parameters.Add(new MySqlParameter("nome", nome));
            comando.Parameters.Add(new MySqlParameter("sobrenome", sobrenome));
            comando.Parameters.Add(new MySqlParameter("cpf", cpf));
            comando.Parameters.Add(new MySqlParameter("rg", rg));
            comando.Parameters.Add(new MySqlParameter("naturalidade", naturalidade));
            comando.Parameters.Add(new MySqlParameter("nacionalidade", nacionalidade));
            comando.Parameters.Add(new MySqlParameter("data_nascimento", data_nascimento));
            comando.Parameters.Add(new MySqlParameter("telefone", telefone));
            comando.Parameters.Add(new MySqlParameter("email", email));
            comando.Parameters.Add(new MySqlParameter("endereco", endereco));

            return RetornarIDInserido(conexao, comando);
        }

        [WebMethod]
        public static dynamic AtualizarAluno(int codigo, String nome, String sobrenome, String email, String data_nascimento, String cpf, String rg, String nacionalidade, 
            String naturalidade, String telefone, String endereco)
        {
            MySqlConnection conexao = new MySqlConnection(WebConfigurationManager.ConnectionStrings["mustacheDB"].ToString());
            MySqlCommand comando = new MySqlCommand(@"UPDATE aluno SET nome = @nome, sobrenome = @sobrenome, cpf = @cpf, rg = @rg, naturalidade = @naturalidade, nacionalidade = @nacionalidade, 
                data_nascimento = @data_nascimento, telefone = @telefone, email = @email, endereco = @endereco, data_alteracao = NOW() 
                WHERE codigo = @codigo", conexao);

            comando.Parameters.Add(new MySqlParameter("codigo", codigo));
            comando.Parameters.Add(new MySqlParameter("nome", nome));
            comando.Parameters.Add(new MySqlParameter("sobrenome", sobrenome));
            comando.Parameters.Add(new MySqlParameter("cpf", cpf));
            comando.Parameters.Add(new MySqlParameter("rg", rg));
            comando.Parameters.Add(new MySqlParameter("naturalidade", naturalidade));
            comando.Parameters.Add(new MySqlParameter("nacionalidade", nacionalidade));
            comando.Parameters.Add(new MySqlParameter("data_nascimento", data_nascimento));
            comando.Parameters.Add(new MySqlParameter("telefone", telefone));
            comando.Parameters.Add(new MySqlParameter("email", email));
            comando.Parameters.Add(new MySqlParameter("endereco", endereco));

            return ExecutarQuery(conexao, comando);
        }

        [WebMethod]
        public static dynamic AtualizarCurso(int codigo, String matricula, int id_curso)
        {
            MySqlConnection conexao = new MySqlConnection(WebConfigurationManager.ConnectionStrings["mustacheDB"].ToString());
            MySqlCommand comando = new MySqlCommand(@"UPDATE aluno SET matricula = @matricula, id_curso = @id_curso, data_alteracao = NOW() 
                WHERE codigo = @codigo", conexao);

            comando.Parameters.Add(new MySqlParameter("codigo", codigo));
            comando.Parameters.Add(new MySqlParameter("matricula", matricula));
            comando.Parameters.Add(new MySqlParameter("id_curso", id_curso));
            return ExecutarQuery(conexao, comando);
        }

        [WebMethod]
        public static dynamic CarregarAlunos()
        {
            MySqlConnection conexao = new MySqlConnection(WebConfigurationManager.ConnectionStrings["mustacheDB"].ToString());
            MySqlCommand comando = new MySqlCommand("SELECT * FROM aluno", conexao);
            return retornoDatabase(conexao, comando);
        }

        [WebMethod]
        public static dynamic DeletarAluno(int codigo)
        {
            MySqlConnection conexao = new MySqlConnection(WebConfigurationManager.ConnectionStrings["mustacheDB"].ToString());
            MySqlCommand comando = new MySqlCommand("DELETE FROM aluno WHERE codigo = @codigo", conexao);

            comando.Parameters.Add(new MySqlParameter("codigo", codigo));
            return ExecutarQuery(conexao, comando);
        }

        [WebMethod]
        public static dynamic CarregarCursos()
        {
            MySqlConnection conexao = new MySqlConnection(WebConfigurationManager.ConnectionStrings["mustacheDB"].ToString());
            MySqlCommand comando = new MySqlCommand("SELECT * FROM curso", conexao);
            return retornoDatabase(conexao, comando);
        }

        [WebMethod]
        public static dynamic CarregarAlunosPesquisa(string nome, string cpf, string rg)
        {
            MySqlConnection conexao = new MySqlConnection(WebConfigurationManager.ConnectionStrings["mustacheDB"].ToString());

            string sql = @"SELECT * FROM aluno WHERE 1 = 1 ";

            if (!String.IsNullOrEmpty(nome))
            {
                sql += " AND nome like '%" + nome + "%'";
            }

            if (!String.IsNullOrEmpty(cpf))
            {
                sql += " AND cpf like '%" + cpf + "%'";
            }

            if (!String.IsNullOrEmpty(rg))
            {
                sql += " AND rg like '%" + rg + "%'";
            }

            MySqlCommand comando = new MySqlCommand(sql, conexao);
            return retornoDatabase(conexao, comando);
        }

        [WebMethod]
        public static dynamic GerarMatricula(int id_curso)
        {
            MySqlConnection conexao = new MySqlConnection(WebConfigurationManager.ConnectionStrings["mustacheDB"].ToString());
            MySqlCommand comando = new MySqlCommand("SELECT nome FROM curso WHERE codigo = @id_curso", conexao);
            comando.Parameters.Add(new MySqlParameter("id_curso", id_curso));
            String curso = String.Empty;

            try
            {
                Util util = new Util();
                conexao.Open();
                IDataReader reader = comando.ExecuteReader();

                if (reader.Read())
                {
                    curso = reader.GetString(0);
                }
            }
            finally
            {
                conexao.Close();
            }

            Random rnd = new Random();
            int matricula = rnd.Next(100000, 999999);
            return curso.Substring(0, 3) + matricula.ToString();
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

        private static long RetornarIDInserido(MySqlConnection conexao, MySqlCommand comando)
        {
            long imageId;
            try
            {
                conexao.Open();
                comando.ExecuteNonQuery();
                imageId = comando.LastInsertedId;
            }
            finally
            {
                conexao.Close();
            }
            return imageId;
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
