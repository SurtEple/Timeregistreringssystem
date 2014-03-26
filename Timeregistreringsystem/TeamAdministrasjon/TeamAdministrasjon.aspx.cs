﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Timeregistreringssystem
{
    public partial class TeamAdministrasjon : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void gridViewTeam_SelectedIndexChanged(object sender, EventArgs e) 
        {
            try
            {
                GridViewRow row = gridViewTeam.SelectedRow;

                int id = Convert.ToInt32(row.Cells[2].Text.ToString());
                string beskrivelse = row.Cells[3].Text.ToString();

                String transferString = "Teammedlemmer.aspx?id=" + id + "&beskrivelse=" + beskrivelse;
                Server.Transfer(transferString);
            }
            catch(Exception ex)
            {
                //TODO
            }
        }

        protected void btnNyttTeam_Click(object sender, EventArgs e)
        {
            Server.Transfer("OpprettTeam.aspx");
        }

        protected void gridViewTeam_RowEditing(object sender, GridViewEditEventArgs e)
        {
            //TODO
            //Sjekk at du får gyldig input
        }

        protected void gridViewTeam_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
           //TODO
           //Popup er du sikker?
        }
    }
}