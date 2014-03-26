using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Timeregistreringssystem.OppgaveAdmin
{
    public partial class LeggTilOppgave : System.Web.UI.Page
    {

        private DBConnect connection;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLagre_Click(object sender, EventArgs e)
        {
            //Sjekke etter tom/null input
            if (!String.IsNullOrEmpty(tbxOppgaveTittel.Text) || !String.IsNullOrEmpty(tbxOppgaveBeskrivelse.Text)
                || !String.IsNullOrEmpty(tbxOppgaveEstimertTid.Text) || !String.IsNullOrEmpty(ddlForeldreProsjekt.SelectedValue))
            {
                connection = new DBConnect();
                string tittel = tbxOppgaveTittel.Text;
                string beskrivelse = tbxOppgaveBeskrivelse.Text;
                string startDato = dateStartTextBox.Text;
                string sluttDato = dateStopTextBox.Text;
                string tempid = ddlForeldreOppgave.SelectedValue;
                int foreldreOppgave = Convert.ToInt32(ddlForeldreOppgave.SelectedValue);
                int foreldreProsjekt = Convert.ToInt32(ddlForeldreProsjekt.SelectedValue);
                int estimertTid = Convert.ToInt16(tbxOppgaveEstimertTid.Text);


                connection.InsertOppgave(foreldreProsjekt, foreldreOppgave, estimertTid, tittel, beskrivelse, startDato, sluttDato);
            }
        }
    }
}