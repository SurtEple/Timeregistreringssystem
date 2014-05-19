using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Timeregistreringssystem.BrukerProfile
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //sjekker rettighetene til bruker
            int rettighet = Convert.ToInt32(Session["Admin"]);
            if (rettighet == Rettigheter.VANLIG_BRUKER && Global.CheckIP())
            {
                //legger til parametre til datasourcen
                string id = Convert.ToString(Session["BrukerID"]);
                SqlDataSource1.SelectParameters["@brukerID"].DefaultValue = id;
                SqlDataSource2.SelectParameters["@brukerID"].DefaultValue = id;
                SqlDataSource3.SelectParameters["@brukerID"].DefaultValue = id;
            }
            else
                Response.Redirect("~/Default");
        }
    }
}