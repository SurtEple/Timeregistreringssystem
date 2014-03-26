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

                    //Her burde nok mysqldatasource1 benyttes og ikke dbconnect
                    DBConnect database = new DBConnect();
                    bool ok = database.InsertTeam(new Team(0, teamlederId, "", teamNavn));

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