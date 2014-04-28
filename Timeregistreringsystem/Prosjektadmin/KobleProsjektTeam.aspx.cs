using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Timeregistreringssystem.Prosjektadmin
{
    public partial class KobleProsjektTeam : System.Web.UI.Page
    {

        //variabler
        private DBConnect connection;
        private bool insertOK = false, deleteOK = false, editOK = false, connectOK = false;
        private String navn, oppsummering, nesteFase, nyttNavn, nyOppsummering, nyNesteFase;
        protected void Page_Load(object sender, EventArgs e)
        {
            connection = new DBConnect();
        }
        private void Page_Init(object sender, EventArgs e)
        {
            if (Session["Admin"] != null)
            {
                if ((int)Session["Admin"] == Rettigheter.PROSJEKT_ANSVARLIG)
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
        protected void btnConnectTeamProject_Click(object sender, EventArgs e)
        {
            try
            {
                //Sjekke etter tom/null input
                if (!String.IsNullOrEmpty(DropDownListKobleProsjekt.SelectedValue) || !String.IsNullOrEmpty(DropDownListKobleTeam.SelectedValue))
                {
                    int prosjektID = Convert.ToInt32(DropDownListKobleProsjekt.SelectedValue);
                    int teamID = Convert.ToInt32(DropDownListKobleTeam.SelectedValue);
                    connectOK = connection.connectTeamToProject(teamID, prosjektID); //lagre boolsk returverdi

                    Page.Response.Redirect(Page.Request.Url.ToString(), true);
                }
                else resultLabel.Text = "Feltene kan ikke være tomme!";
            }
            catch (FormatException formatException) { resultLabel.Text = "Exception: " + formatException.Message; }
            catch (OverflowException overFlowException) { resultLabel.Text = "Exception: " + overFlowException.Message; }
            catch (Exception ex) { resultLabel.Text = "Exception: " + ex.Message; }
        }


    }
}