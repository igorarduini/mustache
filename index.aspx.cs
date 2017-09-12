using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using MySql.Data.MySqlClient;
using System.Web.Configuration;
using System.Data;
using System.Text;
using System.IO;
using Newtonsoft.Json;

namespace Mustache.WebUI
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static dynamic CarregarCursos()
        {
            MySqlConnection conexao = new MySqlConnection(WebConfigurationManager.ConnectionStrings["mustacheDB"].ToString());
            MySqlCommand comando = new MySqlCommand("SELECT c.*, tc.nome as tipo_curso FROM curso c INNER JOIN tipo_curso tc ON tc.codigo = c.id_tipo_curso", conexao);
            return retornoDatabase(conexao, comando);
        }

        [WebMethod]
        public static dynamic CarregarQuantidadeAlunos()
        {
            MySqlConnection conexao = new MySqlConnection(WebConfigurationManager.ConnectionStrings["mustacheDB"].ToString());
            MySqlCommand comando = new MySqlCommand("SELECT count(*) as quantidade FROM aluno", conexao);
            return retornoDatabase(conexao, comando);
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

        public static string ConvertReaderTOJson(IDataReader reader)
        {
            if (reader != null || !reader.IsClosed)
            {
                StringBuilder sb = new StringBuilder();
                StringWriter sw = new StringWriter(sb);

                using (JsonWriter jsonWriter = new JsonTextWriter(sw))
                {

                    jsonWriter.WriteStartArray();

                    while (reader.Read())
                    {
                        jsonWriter.WriteStartObject();

                        int fields = reader.FieldCount;

                        for (int i = 0; i < fields; i++)
                        {
                            jsonWriter.WritePropertyName(reader.GetName(i));
                            jsonWriter.WriteValue(reader[i]);
                        }
                        jsonWriter.WriteEndObject();
                    }
                    jsonWriter.WriteEndArray();
                }
                return sw.ToString();
            }
            else
                throw new Exception("Reader não tem informação para geração do JSON");
        }
    }
}