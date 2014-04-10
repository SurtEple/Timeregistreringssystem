
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;


/* 
*   author Thea, Surt Eple
*/
namespace Timeregistreringssystem.Prosjektadmin
{
    public partial class Milestones : Page
    {
      
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLagre_Click(object sender, EventArgs e)
        {
            DialogResult dr;
            DateTime dt;
            //Sjekke etter tom/null input
            if (!String.IsNullOrEmpty(dateFerdigTextBox.Text) && DropDownListOppgave.SelectedValue != null) {
                try {
                    //Sjekker etter injection samtidig som stringen blir parset og lagret i dt-referansen
                    bool isValid = DateTime.TryParseExact(
                           dateFerdigTextBox.Text, //Henter string fra tekstboks
                            "yyyy/MM/dd HH:mm", //Formatet det skal ha
                            CultureInfo.InvariantCulture, //Ha'kke peiling
                            DateTimeStyles.None, //Null aning
                            out dt); //Lagrer det nye DateTime-objektet i dt
                   
                    if (isValid) {
                        string datoFerdig = dt.ToString("u"); //Konverter til universelt format og tilbake til en string

                        //Spør brukeren om bekreftelse
                        dr = MessageBox.Show("Er du sikker på at du vil legge til en milepæl? Dato Ferdig = " + datoFerdig, "Legg Til milepæl", System.Windows.Forms.MessageBoxButtons.YesNo);
                        if (dr == System.Windows.Forms.DialogResult.Yes) {
                            SqlDataSource1.InsertParameters.Add("Dato", datoFerdig); //INSERT INTO .. VALUES (@OppgID, @Dato)
                            SqlDataSource1.InsertParameters.Add("OppgID", DropDownListOppgave.SelectedValue.ToString()); //INSERT INTO .. VALUES (@OppgID, @Dato)

                            SqlDataSource1.Insert(); //Utfører insert
                            resultLabel.Text = "Milepælen ble lagret!";
                            GridView1.DataBind(); //Oppdaterer gridviewet
                        }
                    }
                    else resultLabel.Text = "Invalid format!";
                }
                catch (InvalidOperationException ioe) { resultLabel.Text = "Invalid operation exception" + ioe.Message; }
                catch (System.FormatException fe) { resultLabel.Text = "Format Exception: " + fe.Message; }
                catch (ArgumentOutOfRangeException argoor) { resultLabel.Text = "Argument Out of Range exception: " + argoor.Message; }
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string milestoneNavn = (string)e.Values["Beskrivelse"].ToString();

            System.Windows.Forms.DialogResult dr = new System.Windows.Forms.DialogResult();
            dr = System.Windows.Forms.MessageBox.Show("Er du sikker på at du vil slette milepælen " + milestoneNavn + " ?", "slette milepæl", System.Windows.Forms.MessageBoxButtons.YesNo);
            //bekreftelse på sletting
            if (dr == System.Windows.Forms.DialogResult.No){
                e.Cancel = true;
            }
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            DateTime dt;
            try
            {
                //Sjekker etter injection samtidig som stringen blir parset og lagret i dt-referansen
                bool isValid = DateTime.TryParseExact(
                        e.NewValues["Dato Ferdig"].ToString(), //Henter string fra tekstboks
                        "dd.MM.yyyy HH:mm:ss", //Formatet det skal ha
                        CultureInfo.InvariantCulture, //Ha'kke peiling
                        DateTimeStyles.None, //Null aning
                        out dt); //Lagrer det nye DateTime-objektet i dt

                if (isValid){

                    GridViewRow row = (GridViewRow)GridView1.Rows[e.RowIndex];
                    int id = Int32.Parse(GridView1.DataKeys[e.RowIndex].Value.ToString());
                    string beskrivelseNew = e.NewValues["Beskrivelse"].ToString();
                    //DateTime dt = Convert.ToDateTime(dato); //konverter datostringen til DateTime
                    string datoFerdig = dt.ToString("u"); //Konverter DateTime til universelt format og tilbake til en string

                    //Spør brukeren om bekreftelse
                    System.Windows.Forms.DialogResult dr = new System.Windows.Forms.DialogResult();
                    dr = System.Windows.Forms.MessageBox.Show("Er du sikker på at du vil endre milepælen?", "Endre milepæl", MessageBoxButtons.YesNo);
                    //bekreftelse på Oppdatering
                    if (dr == DialogResult.No)
                        e.Cancel = true;

                    else{
                        SqlDataSourceMilepael.UpdateParameters.Add("ID", id.ToString()); //UPDATE..WHERE ID=@ID
                        SqlDataSourceMilepael.UpdateParameters.Add("DatoFerdig", datoFerdig); //UPDATE..WHERE ID=@ID
                        SqlDataSourceMilepael.UpdateParameters.Add("Beskrivelse", beskrivelseNew); //UPDATE..SET Beskrivelse=@Beskrivelse
                    }
                }
                else resultLabel.Text = "Invalid Date Format!";
            }
            catch (System.ArgumentNullException ane) { resultLabel.Text = "Argument Null Exception while trying to parse ID! " + ane.Message; }

        }

        protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.Exception != null)
                System.Windows.Forms.MessageBox.Show(e.Exception.Message);

            Page.Response.Redirect(Page.Request.Url.ToString(), true); //Refresh siden
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            
        }

    }
}