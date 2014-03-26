using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Timeregistreringsystem
{
    public partial class Teammedlemmer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(Request.QueryString["id"]);

                string beskrivelse = Request.QueryString["beskrivelse"];
                Response.Write("<h1>" + beskrivelse + "</h1><br />");

                Parameter p = SqlDataSource1.SelectParameters["TeamId"];
                SqlDataSource1.SelectParameters.Remove(p);
                SqlDataSource1.SelectParameters.Add("TeamId", id.ToString());

            }
            catch (Exception ex)
            {
                //TODO
            }

            if (Page.IsPostBack)
            {
                GridView1.DataBind();
            }
        }

        protected void btnTilbake_Click(object sender, EventArgs e)
        {
            Server.Transfer("TeamAdministrason.aspx");
        }

        protected void btnLeggTil_Click(object sender, EventArgs e)
        {
            
        }
    }
}