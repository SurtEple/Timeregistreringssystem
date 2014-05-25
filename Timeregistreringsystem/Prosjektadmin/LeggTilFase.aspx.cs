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
 * Legg til/Endre fase
 * author Thomas og Thea, Gruppe 2
 */
namespace Timeregistreringssystem.Prosjektadmin
{

  

    public partial class LeggTilFase : Page
    {
       
        private void Page_Init(object sender, EventArgs e)
        {
            if (Session["Admin"] != null)
            {
               // if (!((int)Session["Admin"] == Rettigheter.PROSJEKT_ANSVARLIG && Global.CheckIP()) )
                    //Response.Redirect("~/Default.aspx");

            }
            else
                Response.Redirect("~/Default.aspx");
        }


        protected void btnLagre_Click(object sender, EventArgs e)
        {
            //Format i tekstboks: 2014-04-28
            
            DateTime dtStart;
            DateTime dtSlutt;

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
                            GridView1.DataBind(); //Oppdaterer gridviewet
                            this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Fasen er lagt til')", true);
                        }
                        else
                        {
                            this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Avbrutt')", true);
                        }
                   

                       }
                    else resultLabel.Text = "Feltene kan ikke være tomme!";


                }
                else resultLabel.Text = "Invalid Date Format!";
            }

            catch (Exception ex) { }

           
        }

       

      
    }
}