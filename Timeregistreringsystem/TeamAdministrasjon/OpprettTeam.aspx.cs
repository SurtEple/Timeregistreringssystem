using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Timeregistreringssystem.TeamAdministrasjon
{
    public partial class OpprettTeam : System.Web.UI.Page
    {
        private void Page_Init(object sender, EventArgs e)
        {
            if (Session["Admin"] != null)
            {
                if (((int)Session["Admin"] == Rettigheter.PROSJEKT_ANSVARLIG || (int) Session["Admin"] == Rettigheter.TEAMLEDER) && Global.CheckIP())
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
        }

        //Henter ut formdata og lagrer nytt team i database
        protected void btnLagreNyttTeam_Click(object sender, EventArgs e)
        {
            try
            {

                string teamNavn = tbNavn.Text.ToString();
                int teamlederId = Convert.ToInt32(ddlTeamleder.SelectedItem.Value.ToString());

                if (teamNavn.Equals(""))
                {
                    labelTilbakemelding.Text = "Teamet må ha et navn";
                }
                else
                {
                    labelTilbakemelding.Text = "";

                    DBConnect database = new DBConnect();
                    bool ok = database.InsertTeam(new Team(0, teamlederId, "", teamNavn));

                    if (ok)
                    {
                        //Vet ikke TeamId før etter team er satt inn i database
                        //Henter derfor ut alle team og finner et med matchende
                        //teamlederid og beskrivelse.

                        List<Team> team = database.selectTeam();
                        Team nyttTeam = null;

                        foreach (Team t in team)
                        {
                            if (t.Beskrivelse.Equals(teamNavn))
                            {
                                if (t.TeamLederId == teamlederId)
                                {
                                    nyttTeam = t;
                                    break;
                                }
                            }
                        }

                        if (nyttTeam != null)
                            ok = database.KoblingBrukerTeam(nyttTeam.Id, nyttTeam.TeamLederId);
                        else
                            ok = false;
                    }
                    
                    if (ok)
                    {
                        Response.Redirect("TeamAdministrasjon.aspx");
                    }
                    else
                    {
                        throw new Exception("Innsetting i database ikke ok!");
                    }
                }
            }
            catch (Exception ex)
            {
                labelTilbakemelding.Text = ex.Message.ToString();
            }
        }

        //Sender bruker tilbake til teamadministrasjon
        protected void btnAvbryt_Click(object sender, EventArgs e)
        {
            Response.Redirect("TeamAdministrasjon.aspx");
        }
    }
}