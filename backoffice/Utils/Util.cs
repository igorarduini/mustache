using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Newtonsoft.Json.Schema;
using System.Data;
using System.IO;
using Newtonsoft.Json;

namespace Mustache.WebUI
{
    sealed class Util
    {
        /// <summary>
        /// Convert um datareader em string JSON
        /// </summary>
        /// <param name="reader"></param>
        /// <returns></returns>
        public string ConvertReaderTOJson(IDataReader reader)
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
