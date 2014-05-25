using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Timeregistreringssystem.BrukerAdministrasjon
{
    public partial class OversiktTimeEndringer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] != null)
            {
                var userID = (int)Session["Admin"];

                if (!( userID == Rettigheter.PROSJEKT_ANSVARLIG || userID == Rettigheter.ADMINISTRATOR || 
                    userID == Rettigheter.TEAMLEDER) || !Global.CheckIP())
                    Response.Redirect("~/Default.aspx");
             }
            else
                Response.Redirect("~/Default.aspx");
        }
    }
}