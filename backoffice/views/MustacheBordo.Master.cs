using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Mustache.WebUI.backoffice.views
{
    public partial class MustacheBordo : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnsair_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("/backoffice/views/login.aspx");
        }
    }
}