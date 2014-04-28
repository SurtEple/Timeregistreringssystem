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
        protected void Page_Load(object sender, EventArgs e)
        {
            connection = new DBConnect();
        }

        protected void btnLagre_Click(object sender, EventArgs e)
        {
            //Sjekke etter tom/null input
            if (!String.IsNullOrWhiteSpace(tbxOppgaveTittel.Text) && !String.IsNullOrWhiteSpace(tbxOppgaveBeskrivelse.Text)
                && !String.IsNullOrWhiteSpace(tbxOppgaveEstimertTid.Text) && !String.IsNullOrWhiteSpace(ddlForeldreProsjekt.SelectedValue)
                && !String.IsNullOrWhiteSpace(dateStopTextBox.Text))
            {
                connection = new DBConnect();
                string tittel = tbxOppgaveTittel.Text;
                string beskrivelse = tbxOppgaveBeskrivelse.Text;
                string startDato = dateStartTextBox.Text;
                string sluttDato = dateStopTextBox.Text;
                int foreldreOppgave = Convert.ToInt32(ddlForeldreOppgave.SelectedValue);
                int foreldreProsjekt = Convert.ToInt32(ddlForeldreProsjekt.SelectedValue);
                int estimertTid = Convert.ToInt16(tbxOppgaveEstimertTid.Text);


                connection.InsertOppgave(foreldreProsjekt, foreldreOppgave, estimertTid, tittel, beskrivelse, startDato, sluttDato);

                lblTilbakemelding.Text = "Oppgaven er nå lagt til!";
                Page.Response.Redirect(Page.Request.Url.ToString(), true);
            }
            else lblTilbakemelding.Text = "Alle feltene må være fyllt ut!";
        }
    }
}