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
        private void Page_Init(object sender, EventArgs e)
        {
            if (Session["Admin"] != null)
            {
                if ((int)Session["Admin"] == Rettigheter.PROSJEKT_ANSVARLIG && Global.CheckIP())
                {

                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }
            }
            else
                Response.Redirect("~/Default.aspx");
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            int rettighet = Convert.ToInt32(Session["Admin"]);
            if (rettighet != Rettigheter.PROSJEKT_ANSVARLIG)
            {
                Response.Redirect("~/Default.aspx");
            }

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
                bool ok = database.KoblingBrukerTeam(teamId, brukerid);
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                //TODO
            }
        }
    }
}