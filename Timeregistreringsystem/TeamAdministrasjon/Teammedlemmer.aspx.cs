using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Timeregistreringssystem.TeamAdministrasjon
{
    public partial class Teammedlemmer : System.Web.UI.Page
    {
        private int teamId;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                teamId = Convert.ToInt32(Request.QueryString["id"]);
                string beskrivelse = Request.QueryString["beskrivelse"];
                Response.Write("<h1>" + beskrivelse + "</h1><br />");

                Parameter p = SqlDataSource1.SelectParameters["TeamId"];
                SqlDataSource1.SelectParameters.Remove(p);
                SqlDataSource1.SelectParameters.Add("TeamId", teamId.ToString());

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
            try
            {
                int brukerid = Convert.ToInt32(DropDownList1.SelectedValue);

                DBConnect database = new DBConnect();
                database.KoblingBrukerTeam(teamId, brukerid);

            }
            catch (Exception ex)
            {
                //TODO
            }
            
        }
    }
}