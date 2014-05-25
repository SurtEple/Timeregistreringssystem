
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
        private Parameter selectParameterFase, prosjektIdSelectParameterOppgave, faseIdSelectParamtererOppgave;
        private void Page_Init(object sender, EventArgs e)
        {
            if (Session["Admin"] != null)
            {
                if ( (int)Session["Admin"] == Rettigheter.PROSJEKT_ANSVARLIG && Global.CheckIP() )
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
            selectParameterFase = SqlDataSourceFase.SelectParameters["Prosjekt_ID"];
            SqlDataSourceFase.SelectParameters.Remove(selectParameterFase);
            SqlDataSourceFase.SelectParameters.Add("Prosjekt_ID", "0");

            faseIdSelectParamtererOppgave = oppgaveDropDown.SelectParameters["FaseID"];
            oppgaveDropDown.SelectParameters.Remove(faseIdSelectParamtererOppgave);
            oppgaveDropDown.SelectParameters.Add("FaseID", "0");


            prosjektIdSelectParameterOppgave = oppgaveDropDown.SelectParameters["Prosjekt_ID"];
            oppgaveDropDown.SelectParameters.Remove(prosjektIdSelectParameterOppgave);
            oppgaveDropDown.SelectParameters.Add("Prosjekt_ID", "0");
        }

        protected void btnLagre_Click(object sender, EventArgs e)
        {
           
            DateTime dt;
            //Sjekke etter tom/null input
            if (!String.IsNullOrEmpty(dateFerdigTextBox.Text) && DropDownListOppgave.SelectedItem.Value != null && DropDownListProsjekt.SelectedItem.Value != null && DropDownListFase.SelectedItem.Value != null)
            {
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
                        string confirmValue = Request.Form["confirm_value"];
                        if (confirmValue == "Yes")
                        {
                            SqlDataSource1.InsertParameters.Add("Dato", datoFerdig); //INSERT INTO .. VALUES (@OppgID, @Dato)
                            SqlDataSource1.InsertParameters.Add("OppgID", DropDownListOppgave.SelectedItem.Value); //INSERT INTO .. VALUES (@OppgID, @Dato)
                            SqlDataSource1.InsertParameters.Add("FaseID", DropDownListFase.SelectedItem.Value);
                            SqlDataSource1.Insert(); //Utfører insert
                            resultLabel.Text = "Milepælen ble lagret!";
                            GridView1.DataBind(); //Oppdaterer gridviewet
                            this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Milepælen er lagt til')", true);
                        }
                        else
                            this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Avbrutt')", true);


                    }
                    else resultLabel.Text = "Invalid format!";
                }
                catch (InvalidOperationException ioe) { resultLabel.Text = "Invalid operation exception" + ioe.Message; }
                catch (System.FormatException fe) { resultLabel.Text = "Format Exception: " + fe.Message; }
                catch (ArgumentOutOfRangeException argoor) { resultLabel.Text = "Argument Out of Range exception: " + argoor.Message; }
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

                  
                        SqlDataSourceMilepael.UpdateParameters.Add("ID", id.ToString()); //UPDATE..WHERE ID=@ID
                        SqlDataSourceMilepael.UpdateParameters.Add("DatoFerdig", datoFerdig); //UPDATE..WHERE ID=@ID
                        SqlDataSourceMilepael.UpdateParameters.Add("Beskrivelse", beskrivelseNew); //UPDATE..SET Beskrivelse=@Beskrivelse
                   
                }
                else resultLabel.Text = "Invalid Date Format!";
            }
            catch (System.ArgumentNullException ane) { resultLabel.Text = "Argument Null Exception while trying to parse ID! " + ane.Message; }

        }

        protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            

            Page.Response.Redirect(Page.Request.Url.ToString(), true); //Refresh siden
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            
        }

        protected void DropDownListProsjekt_SelectedIndexChanged(object sender, EventArgs e)
        {
           string prosjektID =  DropDownListProsjekt.SelectedItem.Value;


            selectParameterFase = SqlDataSourceFase.SelectParameters["Prosjekt_ID"];
            SqlDataSourceFase.SelectParameters.Remove(selectParameterFase);
            SqlDataSourceFase.SelectParameters.Add("Prosjekt_ID", prosjektID);


            prosjektIdSelectParameterOppgave = oppgaveDropDown.SelectParameters["Prosjekt_ID"];
            oppgaveDropDown.SelectParameters.Remove(prosjektIdSelectParameterOppgave);
            oppgaveDropDown.SelectParameters.Add("Prosjekt_ID", prosjektID);
        }

        protected void DropDownListOppgave_SelectedIndexChanged(object sender, EventArgs e)
        {
            string faseID = DropDownListFase.SelectedItem.Value;

            faseIdSelectParamtererOppgave = oppgaveDropDown.SelectParameters["FaseID"];
            oppgaveDropDown.SelectParameters.Remove(faseIdSelectParamtererOppgave);
            oppgaveDropDown.SelectParameters.Add("FaseID", faseID);
        }


    }
}