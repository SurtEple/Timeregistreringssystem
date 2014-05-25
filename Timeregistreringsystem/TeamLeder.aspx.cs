using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Timeregistreringssystem
{

    public partial class TeamLeder : System.Web.UI.Page
    {

        //Variabler
        private DBConnect connection;
        private String brukernavn;
        private int nyStillingsId;
        private bool oppdateringOk = false;
        private void Page_Init(object sender, EventArgs e)
        {
            if (Session["Admin"] != null)
            {
                if (((int)Session["Admin"] == Rettigheter.PROSJEKT_ANSVARLIG || (int)Session["Admin"] == Rettigheter.TEAMLEDER) && Global.CheckIP())
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
            connection = new DBConnect();
        }

        // Tar vare på brukerens id når han / hun blir valgt fra GridView
        public void grdvwBrukere_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow rad = grdvwBrukere.SelectedRow;
            txtbxValgt.Text = rad.Cells[1].Text;
            txtbxID.Text = rad.Cells[0].Text;

        }

        // Sjekker at en bruker er valgt, 
        protected void btnSetTeamLeder_Click(object sender, EventArgs e)
        {
            try
            {
                if (!String.IsNullOrEmpty(txtbxID.Text) && !String.IsNullOrEmpty(txtbxValgt.Text))
                {
                    int id = Convert.ToInt32(txtbxID.Text);
                    brukernavn = txtbxValgt.Text;
                    nyStillingsId = 4;

                    // lagrer boolsk returverdi
                    oppdateringOk = connection.setTeamLeder(id);

                    txtbxDetaljer.Text = "Bruker " + brukernavn + " er nå blitt satt som team-leder." + Environment.NewLine
                        + "Oppdatering Ok: " + oppdateringOk;
                }
                else txtbxDetaljer.Text = "Du må velge en person!";
            }
            catch (FormatException formatException) { txtbxConnectionResult.Text = "Format Exception: " + formatException.Message; }
            catch (OverflowException overflowException) { txtbxConnectionResult.Text = "Overflow Exception: " + overflowException.Message; }
            catch (Exception exception) { txtbxConnectionResult.Text = "Exception: " + exception.Message; }

            grdvwBrukere.DataBind(); // Oppdaterer gridview'et med ny stillings_id
        }

    }
}