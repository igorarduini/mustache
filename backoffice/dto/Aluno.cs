using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace Centro_Universitário_Mustache.dto
{
    public class Aluno
    {
        public int Id { get; set; }
        public string nome { get; set; }
        public string sobrenome { get; set; }
        public string cpf { get; set; }
        public string rg { get; set; }
        public string nacionalidade { get; set; }
        public string naturalidade { get; set; }
        public string telefone { get; set; }
        public string email { get; set; }
        public string data_nascimento { get; set; }
    }
}