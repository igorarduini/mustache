using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Mustache.WebUI.backoffice.views
{
    public partial class starter : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuarioLogado"] == null)
            {
                Response.Redirect("/backoffice/views/login.aspx");
            }
        }

        [WebMethod]
        public static dynamic DashboardIntegracaoMEC()
        {
            var url = "https://api.myjson.com/bins/z61o5";
            var webrequest = (HttpWebRequest)System.Net.WebRequest.Create(url);

            using (var response = webrequest.GetResponse())
            using (var reader = new StreamReader(response.GetResponseStream()))
            {
                var result = reader.ReadToEnd();
                return result;
            }
        }
    }
}