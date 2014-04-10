using System;
using System.Collections.Generic;
using System.Globalization;
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

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            DateTime dtStart;
            DateTime dtStop;
            try
            {

                //Sjekker etter injection samtidig som stringen blir parset og lagret i dt-referansen
                bool startDateIsValid = DateTime.TryParseExact(
                        e.NewValues["StartDato"].ToString(), //Henter string fra tekstboks
                        "dd.MM.yyyy", //Formatet det skal ha
                        CultureInfo.InvariantCulture, //Ha'kke peiling
                        DateTimeStyles.None, //Null aning
                        out dtStart); //Lagrer det nye DateTime-objektet i dt

                bool finishDateIsValid = DateTime.TryParseExact(
                      e.NewValues["SluttDato"].ToString(), //Henter string fra tekstboks
                      "dd.MM.yyyy", //Formatet det skal ha
                      CultureInfo.InvariantCulture, //Ha'kke peiling
                      DateTimeStyles.None, //Null aning
                      out dtStop); //Lagrer det nye DateTime-objektet i dt

                if (startDateIsValid && finishDateIsValid){

                    GridViewRow row = (GridViewRow)GridView1.Rows[e.RowIndex];
                    int id = Int32.Parse(GridView1.DataKeys[e.RowIndex].Value.ToString());
                   // string datoStart = e.NewValues["StartDato"].ToString(); //Hent dato fra gridview
                    //string datoSlutt = e.NewValues["SluttDato"].ToString(); //Hent dato fra gridview
                    string beskrivelseNew = e.NewValues["Beskrivelse"].ToString();
                    string navnNew = e.NewValues["Navn"].ToString();
                    string aktiv = e.NewValues["Aktiv"].ToString();

                   // DateTime dt = Convert.ToDateTime(datoStart); //konverter datostringen til DateTime
                    string datoStart = dtStart.ToString("u"); //Konverter DateTime til universelt format og tilbake til string
                    string datoFerdig = dtStop.ToString("u"); //Konverter DateTime til universelt format og tilbake til string


                    //Spør brukeren om bekreftelse
                    System.Windows.Forms.DialogResult dr = new System.Windows.Forms.DialogResult();
                    dr = System.Windows.Forms.MessageBox.Show("Er du sikker på at du vil endre milepælen?", "Endre milepæl", System.Windows.Forms.MessageBoxButtons.YesNo);
                    //bekreftelse på Oppdatering
                    if (dr == System.Windows.Forms.DialogResult.No)
                        e.Cancel = true;

                    else
                    {
                       SqlDataSourceFaser.UpdateParameters.Add("ID", id.ToString()); //UPDATE..WHERE ID=@ID
                       SqlDataSourceFaser.UpdateParameters.Add("StartDato", datoStart); //UPDATE..WHERE ID=@ID
                       SqlDataSourceFaser.UpdateParameters.Add("SluttDato", datoStart); //UPDATE..WHERE ID=@ID
                       SqlDataSourceFaser.UpdateParameters.Add("Navn", navnNew); //UPDATE..WHERE ID=@ID
                       SqlDataSourceFaser.UpdateParameters.Add("Aktiv", aktiv); //UPDATE..SET Aktiv=@Aktiv
                       SqlDataSourceFaser.UpdateParameters.Add("Beskrivelse", beskrivelseNew); //UPDATE..SET Beskrivelse=@Beskrivelse

                    }
                }
            }
            catch (System.ArgumentNullException ane) { resultLabel.Text = "Argument Null Exception while trying to parse ID! " + ane.Message; }
        }

    }
}