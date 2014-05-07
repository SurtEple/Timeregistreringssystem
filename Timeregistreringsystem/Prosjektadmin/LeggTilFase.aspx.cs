using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

/**
 * author Thomas og Thea, Surt Eple
 */
namespace Timeregistreringssystem.Prosjektadmin
{

  

    public partial class LeggTilFase : System.Web.UI.Page
    {
        private DBConnect connection;
        private void Page_Init(object sender, EventArgs e)
        {
            if (Session["Admin"] != null)
            {
                if ((int)Session["Admin"] == Rettigheter.PROSJEKT_ANSVARLIG && Global.CheckIP())
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
          
        }

        protected void btnLagre_Click(object sender, EventArgs e)
        {
            //Format i tekstboks: 2014-04-28
            
            DateTime dtStart;
            DateTime dtSlutt;
            DialogResult dr;

            try{
                //Sjekker etter injection samtidig som stringen blir parset og lagret i dt-referansen
                bool startIsValid = DateTime.TryParseExact(
                        dateStartTextBox.Text, //Henter string fra tekstboks
                        "yyyy-MM-dd", //Formatet det skal ha
                        CultureInfo.InvariantCulture, //Ha'kke peiling
                        DateTimeStyles.None, //Null aning
                        out dtStart); //Lagrer det nye DateTime-objektet i dt

                bool sluttIsValid = DateTime.TryParseExact(
                        dateStopTextBox.Text, //Henter string fra tekstboks
                        "yyyy-MM-dd", //Formatet det skal ha
                        CultureInfo.InvariantCulture, //Ha'kke peiling
                        DateTimeStyles.None, //Null aning
                        out dtSlutt); //Lagrer det nye DateTime-objektet i dt

                //Om datoene har riktig format
                if (startIsValid && sluttIsValid) {

                    //Sjekke etter tom/null input
                    if (!String.IsNullOrEmpty(faseNavnTextBox.Text) || !String.IsNullOrEmpty(beskrivelseTextBox.Text)
                       || !String.IsNullOrEmpty(prosjektDropDownList.SelectedValue)){
                       
                       // string datoStart = dtStart.ToString("yyyy-MM-dd"); //Konverter til bestemt format og tilbake til en string
                       // string datoFerdig = dtSlutt.ToString("yyyy-MM-dd"); //Konverter til bestemt format og tilbake til en string

                        string datoStart = dateStartTextBox.Text;
                        string datoFerdig = dateStopTextBox.Text;
                        
                        //Spør brukeren om bekreftelse
                        string confirmValue = Request.Form["confirm_value"];
                        if (confirmValue == "Yes")
                        {
                            //VALUES (@Navn, @StartDato, @SluttDato, @ProsjektID, @Beskrivelse)
                            SqlDataSourceFaser.InsertParameters.Add("Navn", faseNavnTextBox.Text); //Setter inn @Navn i Insertkommandoen
                            SqlDataSourceFaser.InsertParameters.Add("Beskrivelse", beskrivelseTextBox.Text); //Setter inn @Beskrivelse
                            SqlDataSourceFaser.InsertParameters.Add("StartDato", datoStart); //Setter inn @StartDato
                            SqlDataSourceFaser.InsertParameters.Add("SluttDato", datoFerdig); //Setter inn @SluttDato
                            SqlDataSourceFaser.InsertParameters.Add("ProsjektID", prosjektDropDownList.SelectedValue.ToString()); //Setter inn @ProsjektID

                            SqlDataSourceFaser.Insert(); //Utfører insert
                            resultLabel.Text = "Fasen ble lagret!";
                            GridView1.DataBind(); //Oppdaterer gridviewet
                            this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Fasen er lagt til')", true);
                        }
                        else
                        {
                            this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Avbrutt')", true);
                        }
                           /*
                           dr = MessageBox.Show("Er du sikker på at du vil legge til en Fase?", "Legg Til Fase", MessageBoxButtons.YesNo);
                           if (dr == DialogResult.Yes)
                           {
                               //VALUES (@Navn, @StartDato, @SluttDato, @ProsjektID, @Beskrivelse)
                               SqlDataSourceFaser.InsertParameters.Add("Navn", faseNavnTextBox.Text); //Setter inn @Navn i Insertkommandoen
                               SqlDataSourceFaser.InsertParameters.Add("Beskrivelse", beskrivelseTextBox.Text); //Setter inn @Beskrivelse
                               SqlDataSourceFaser.InsertParameters.Add("StartDato", datoStart); //Setter inn @StartDato
                               SqlDataSourceFaser.InsertParameters.Add("SluttDato", datoFerdig); //Setter inn @SluttDato
                               SqlDataSourceFaser.InsertParameters.Add("ProsjektID", prosjektDropDownList.SelectedValue.ToString()); //Setter inn @ProsjektID

                               SqlDataSourceFaser.Insert(); //Utfører insert
                               resultLabel.Text = "Fasen ble lagret!";
                               GridView1.DataBind(); //Oppdaterer gridviewet
                           
                           }*/

                       }
                    else resultLabel.Text = "Feltene kan ikke være tomme!";


                }
                else resultLabel.Text = "Invalid Date Format!";
            }

            catch (Exception ex) { }

           
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
                        "yyyy-MM-dd", //Formatet det skal ha
                        CultureInfo.InvariantCulture, //Ha'kke peiling
                        DateTimeStyles.None, //Null aning
                        out dtStart); //Lagrer det nye DateTime-objektet i dt

                bool finishDateIsValid = DateTime.TryParseExact(
                      e.NewValues["SluttDato"].ToString(), //Henter string fra tekstboks
                      "yyyy-MM-dd", //Formatet det skal ha
                      CultureInfo.InvariantCulture, //Ha'kke peiling
                      DateTimeStyles.None, //Null aning
                      out dtStop); //Lagrer det nye DateTime-objektet i dt

                if (startDateIsValid && finishDateIsValid){

                    GridViewRow row = (GridViewRow)GridView1.Rows[e.RowIndex];
                    int id = Int32.Parse(GridView1.DataKeys[e.RowIndex].Value.ToString());
                    string beskrivelseNew = e.NewValues["Beskrivelse"].ToString();
                    string navnNew = e.NewValues["Navn"].ToString();
                    string aktiv = e.NewValues["Aktiv"].ToString();
                    

                    //http://msdn.microsoft.com/en-us/library/8kb3ddd4(v=vs.110).aspx for forskjellige formater
                    //Formatet i Update-querien ser slik ut:
                    // DATE_FORMAT(Fase.Dato_startet , '%Y-%m-%d') AS &quot;StartDato&quot;

                   string datoStart = dtStart.ToString("yyyy-MM-dd"); //Konverter DateTime til universelt format og tilbake til string
                     string datoFerdig = dtStop.ToString("yyyy-MM-dd"); //Konverter DateTime til universelt format og tilbake til string
                    

                    //Spør brukeren om bekreftelse
                    DialogResult dr = new DialogResult();
                    dr = System.Windows.Forms.MessageBox.Show("Er du sikker på at du vil endre Fasen? Ny StartDato: " + datoStart, "Endre milepæl", System.Windows.Forms.MessageBoxButtons.YesNo);
                    //bekreftelse på Oppdatering
                    if (dr == DialogResult.No)
                        e.Cancel = true;

                    else
                    {
                       SqlDataSourceFaser.UpdateParameters.Add("ID", id.ToString()); //UPDATE..WHERE ID=@ID
                       SqlDataSourceFaser.UpdateParameters.Add("StartDato", datoStart); //UPDATE..SET Dato_startet=@StartDato
                       SqlDataSourceFaser.UpdateParameters.Add("SluttDato", datoStart); //UPDATE..SET Dato_Sluttet=@SluttDato
                       SqlDataSourceFaser.UpdateParameters.Add("Navn", navnNew); //UPDATE..SET Navn=@Navn
                       SqlDataSourceFaser.UpdateParameters.Add("Aktiv", aktiv); //UPDATE..SET Aktiv=@Aktiv
                       SqlDataSourceFaser.UpdateParameters.Add("Beskrivelse", beskrivelseNew); //UPDATE..SET Beskrivelse=@Beskrivelse

                    }
                }
            }
            catch (System.ArgumentNullException ane) { resultLabel.Text = "Argument Null Exception while trying to parse ID! " + ane.Message; }
        }

        //Event-metode for å når brukeren vil slette en rad
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            DialogResult dr = MessageBox.Show("Er du sikker på at du ønsker å slette?", "Slette Fase", MessageBoxButtons.YesNo);

            if (dr == DialogResult.No)
                e.Cancel = true;
        }

    }
}