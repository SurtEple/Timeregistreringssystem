using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Timeregistreringssystem
{
    public partial class OpprettTeam : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DBConnect database = new DBConnect();
                List<Bruker> brukere = database.selectBruker();
                //Legger til alle brukere som mulige teamledere i dropdownlist
                foreach (Bruker b in brukere)
                {
                    string navn;

                    if (b.Mellomnavn.Equals(""))
                        navn = b.Fornavn + " " + b.Etternavn;
                    else
                        navn = b.Fornavn + " " + b.Mellomnavn + " " + b.Etternavn;

                    ddlTeamleder.Items.Add(navn);
                }
            }
        }

        //Henter ut formdata og lagrer nytt team i database
        protected void btnLagreNyttTeam_Click(object sender, EventArgs e)
        {
            try
            {
                DBConnect database = new DBConnect();
                List<Bruker> brukere = database.selectBruker();

                string teamNavn = tbNavn.Text.ToString();
                Bruker b = brukere.ElementAt(ddlTeamleder.SelectedIndex);
                int teamlederId = b.Id;
                string teamlederNavn = ddlTeamleder.SelectedItem.ToString();

                if (teamNavn.Equals(""))
                {
                    labelTilbakemelding.Text = "Teamet må ha et navn";
                }
                else
                {
                    labelTilbakemelding.Text = "";
                    bool ok = database.InsertTeam(new Team(0, teamlederId, teamNavn, teamlederNavn));
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
                labelTilbakemelding.Text = ex.Message.ToString() + 0;
            }
        }

        //Sender bruker tilbake til teamadministrasjon
        protected void btnAvbryt_Click(object sender, EventArgs e)
        {
            Response.Redirect("TeamAdministrasjon.aspx");
        }
    }
}