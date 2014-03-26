using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

/**
 *Opprette Prosjekt
 * author Thomas og Thea, Surt Eple
 */
namespace Timeregistreringssystem.Prosjektadmin
{
    public partial class LeggTilProsjekt : System.Web.UI.Page
    {
        //variabler
        private DBConnect connection;
        private string navn, oppsummering;
        private int lederID;

        protected void Page_Load(object sender, EventArgs e)
        {
            connection = new DBConnect();
        }

        protected void btnLagre_Click(object sender, EventArgs e)
        {
            //Sjekke etter tom/null input
            if (!String.IsNullOrEmpty(textBoxNavn.Text) && !String.IsNullOrEmpty(textBoxOppsummering.Text) 
                && !String.IsNullOrEmpty(lederDropDownList.SelectedValue))
            {
                //Hente input
                lederID = Convert.ToInt32(lederDropDownList.SelectedValue);
                navn = textBoxNavn.Text;
                oppsummering = textBoxOppsummering.Text;
                connection.InsertProject(navn, oppsummering, lederID); 
                Page.Response.Redirect(Page.Request.Url.ToString(), true);

                
            }

            else resultLabel.Text = "Feltene kan ikke være tomme!";
        }
    }
}