﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Timeregistreringssystem.BrukerAdministrasjon
{
    public partial class EndreBruker : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            int rettighet = Convert.ToInt32(Session["Admin"]);
            if (rettighet == Rettigheter.ADMINISTRATOR || rettighet == Rettigheter.PROSJEKT_ANSVARLIG && Global.CheckIP())
            {
                
            }
            else
                Response.Redirect("~/Default");


        }
    }
}