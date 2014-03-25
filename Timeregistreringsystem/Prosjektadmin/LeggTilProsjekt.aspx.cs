using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Timeregistreringssystem.Prosjektadmin
{
    public partial class LeggTilProsjekt : System.Web.UI.Page
    {
        //variabler
        private DBConnect connection;
        private bool insertOK = false;
        private String navn, oppsummering, nesteFase;

        protected void Page_Load(object sender, EventArgs e)
        {
            connection = new DBConnect();
        }

        protected void btnLagre_Click(object sender, EventArgs e)
        {
            //Sjekke etter tom/null input
            if (!String.IsNullOrEmpty(textBoxNavn.Text) || !String.IsNullOrEmpty(textBoxOppsummering.Text))
                //|| !String.IsNullOrEmpty(textBoxNesteFase.Text))
            {
                //Hente input
                navn = textBoxNavn.Text;
                oppsummering = textBoxOppsummering.Text;
              //  nesteFase = textBoxNesteFase.Text;
                
                insertOK = connection.insertProject(navn, oppsummering, DropDownListNyttProsjektNesteFase.SelectedValue); //lagre boolsk returverdi
                Page.Response.Redirect(Page.Request.Url.ToString(), true);

                
            }

            else resultLabel.Text = "Feltene kan ikke være tomme!";
        }
    }
}