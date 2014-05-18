using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Timeregistreringssystem
{
    public partial class BrukerForside : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int rettighet = Convert.ToInt32(Session["Admin"]);

            if ((rettighet == Rettigheter.VANLIG_BRUKER || rettighet == Rettigheter.TEAMLEDER) && Global.CheckIP())
            {
                // Henter ut brukerens ID ved innlogging
                int BrukerId = (int)Session["BrukerID"]; // Tar vare på den inlogged brukerens ID
                SqlDataSourceDDLVelgTeam.SelectParameters.Add("ID", BrukerId.ToString()); // Setter inn verdien til Brukerens id i Select query.

                // Setter "Velg Prosjekt" til å ikke vises før "Team" er valgt
                lblVelgProsjekt.Visible = false;
                ddlVelgProsjekt.Visible = false;
                btnProsjektBekreft.Visible = false;
                btnTilbakeTilTeam.Visible = false;

                // Setter "Velg Hovedoppgave" til å ikke vises før "Prosjekt" er valgt
                lblVelgHovedoppgave.Visible = false;
                ddlVelgHovedoppgave.Visible = false;
                btnHovedoppgaveBekreft.Visible = false;

                // Setter "Velg Oppgave" til å ikke vises før "Hovedoppgave" er valgt
                GridViewVelgOppgave.Visible = false;
            }
            else
                Response.Redirect("~/Default");
            
        }

        // Knapp som tar deg videre til "Velg Prosjekt"
        protected void btnTeamBekreft_Click(object sender, EventArgs e)
        {
            if (ddlVelgTeam.SelectedValue == "")
            {
                // Har ikke valgt Team
                lblIkkeValgtTeam.Visible = true;
            }
            else
            {
                lblIkkeValgtTeam.Visible = false;

                //Setter alle "Team" felt og knapper til å være "Deaktivert"
                lblVelgTeam.Enabled = false;
                ddlVelgTeam.Enabled = false;
                btnTeamBekreft.Enabled = false;

                // Viser alle "Prosjekt" knapper og felt
                lblVelgProsjekt.Visible = true;
                ddlVelgProsjekt.Visible = true;
                btnProsjektBekreft.Visible = true;
                btnTilbakeTilTeam.Visible = true;

            
                int TeamId = Convert.ToInt32(ddlVelgTeam.SelectedValue); // Tar vare på valgt Team-ID
                SqlDataSourceDDLVelgProsjekt.SelectParameters.Add("TeamID", TeamId.ToString()); // Setter inn verdien til brukerens valgte team i Select query
       
            }

             }

        //Knapp som tar deg videre til "Velg Hovedoppgave"
        protected void btnProsjektBekreft_Click(object sender, EventArgs e)
        {
            if (ddlVelgProsjekt.SelectedValue == "")
            {
                // Ingen prosjekt er valgt
                lblIkkeValgtProsjekt.Visible = true;

                // La brukeren velge et annet Prosjekt
                lblVelgProsjekt.Visible = true;
                ddlVelgProsjekt.Visible = true;
                btnProsjektBekreft.Visible = true;
                btnTilbakeTilTeam.Visible = true;
            }
            else
            {
                lblIkkeValgtProsjekt.Visible = false;

                // Tar vare på alle "Prosjekt" knapper og felt men setter dem som "Deaktivert"
                lblVelgProsjekt.Enabled = false;
                ddlVelgProsjekt.Enabled = false;
                btnProsjektBekreft.Enabled = false;

                lblVelgProsjekt.Visible = true;
                ddlVelgProsjekt.Visible = true;
                btnProsjektBekreft.Visible = true;
                btnTilbakeTilTeam.Visible = true;

            
                lblVelgHovedoppgave.Visible = true;
                ddlVelgHovedoppgave.Visible = true;
                btnHovedoppgaveBekreft.Visible = true;

                int Prosjekt_ID = Convert.ToInt32(ddlVelgProsjekt.SelectedValue);
                SqlDataSourceVelgHovedoppgave.SelectParameters.Add("Prosjekt_ID", Prosjekt_ID.ToString());
            }
            
            

        }

        // Knapp som tar deg videre til "Velg Deloppgave" i GridView
        protected void btnHovedoppgaveBekreft_Click(object sender, EventArgs e)
        {
            if (ddlVelgHovedoppgave.SelectedValue == "")
            {
                lblIngenOppgaver.Visible = true;
                
                lblVelgProsjekt.Enabled = false;
                ddlVelgProsjekt.Enabled = false;
                btnProsjektBekreft.Enabled = false;


                lblVelgProsjekt.Visible = true;
                ddlVelgProsjekt.Visible = true;
                btnProsjektBekreft.Visible = true;
                btnTilbakeTilTeam.Visible = true;

                lblVelgHovedoppgave.Enabled = true;
                ddlVelgHovedoppgave.Enabled = true;
                btnHovedoppgaveBekreft.Enabled = true;

                lblVelgHovedoppgave.Visible = true;
                ddlVelgHovedoppgave.Visible = true;
                btnHovedoppgaveBekreft.Visible = true;
            }
            else
            {
                lblIngenOppgaver.Visible = false;

                // Tar vare på alle knapper og felt men setter dem som "Deaktivert"
                lblVelgProsjekt.Enabled = false;
                ddlVelgProsjekt.Enabled = false;
                btnProsjektBekreft.Enabled = false;


                lblVelgProsjekt.Visible = true;
                ddlVelgProsjekt.Visible = true;
                btnProsjektBekreft.Visible = true;
                btnTilbakeTilTeam.Visible = true;

                lblVelgHovedoppgave.Enabled = false;
                ddlVelgHovedoppgave.Enabled = false;
                btnHovedoppgaveBekreft.Enabled = false;

                lblVelgHovedoppgave.Visible = true;
                ddlVelgHovedoppgave.Visible = true;
                btnHovedoppgaveBekreft.Visible = true;


                int Foreldreoppgave_ID = Convert.ToInt32(ddlVelgHovedoppgave.SelectedValue);
                SqlDataSourceVelgOppgave.SelectParameters.Add("Foreldreoppgave_ID", Foreldreoppgave_ID.ToString());
                Session["OppgaveID"] = Foreldreoppgave_ID;
                Session["OppgaveTittel"] = ddlVelgHovedoppgave.SelectedItem.ToString();
                GridViewVelgOppgave.Visible = true;
            }
            
        }

        // Metode for å velge "Deloppgave" i GridView
        protected void GridViewVelgHovedppgave_SelectedIndexChanged(object sender, EventArgs e)
        {

        }


        // Knapp som lar deg gå tilbake for å velge et annet Team.
        protected void btnTilbakeTilTeam_Click(object sender, EventArgs e)
        {
            Response.Redirect("BrukerForside.aspx");
        }
    } 
    
}