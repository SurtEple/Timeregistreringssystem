using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

/**
 * author Thomas og Thea, Surt Eple
 */
namespace Timeregistreringssystem.Prosjektadmin
{

  

    public partial class LeggTilFase : System.Web.UI.Page
    {
        private DBConnect connection;

        //string startDato, sluttDato;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLagre_Click(object sender, EventArgs e)
        {
            //Sjekke etter tom/null input
            if (!String.IsNullOrEmpty(faseNavnTextBox.Text) || !String.IsNullOrEmpty(dateStartTextBox.Text)
                || !String.IsNullOrEmpty(dateStopTextBox.Text) || !String.IsNullOrEmpty(prosjektDropDownList.SelectedValue))
            {
                connection = new DBConnect();
                string navn = faseNavnTextBox.Text;
                string startDato = dateStartTextBox.Text;
                string sluttDato = dateStopTextBox.Text;
                string beskrivelse = beskrivelseTextBox.Text;
                int prosjektID = Convert.ToInt16(prosjektDropDownList.SelectedValue);

                connection.InsertFase(navn, startDato, sluttDato,  beskrivelse, prosjektID);
                
                Page.Response.Redirect(Page.Request.Url.ToString(), true);
            }
        }

    }
}