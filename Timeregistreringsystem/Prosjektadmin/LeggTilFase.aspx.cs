using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

/**
 * author Thea, Surt Eple
 */
namespace Timeregistreringssystem.Prosjektadmin
{

    //Thea 17.03 - 13:00
    //18.03 10:00-12:32
    //12:30-14:15 ferdig ish

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
                || !String.IsNullOrEmpty(dateStopTextBox.Text) || !String.IsNullOrEmpty(statusDropDownList.SelectedValue)
                || !String.IsNullOrEmpty(prosjektDropDownList.SelectedValue))
            {
                connection = new DBConnect();
                string navn = faseNavnTextBox.Text;
                string startDato = dateStartTextBox.Text;
                string sluttDato = dateStopTextBox.Text;
                string status = statusDropDownList.SelectedValue;
                string beskrivelse = beskrivelseTextBox.Text;
                int prosjektID = Convert.ToInt16(prosjektDropDownList.SelectedValue);

                connection.InsertFase(navn, startDato, sluttDato, status, beskrivelse, prosjektID);
            }
        }

    }
}