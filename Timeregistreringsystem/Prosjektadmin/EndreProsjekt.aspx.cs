using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

/**
 * Endre Prosjekt
 * @author Thomas og Thea, Gruppe 2
 */ 
namespace Timeregistreringssystem.Prosjektadmin
{
    public partial class EndreProsjekt : System.Web.UI.Page
    {
       
        private DBConnect connection;
        private string nyttNavn, nyOppsummering, navn, oppsummering, ansvarlig;
        private int nyNesteFase, prosjektAnsvarlig, nyMilestone, id;
        private Parameter faseParam, milestoneParam;
       
        protected void Page_Load(object sender, EventArgs e)
        {
            
            /* Bruker parametere i datasourcene til dropdownlistene for Ny Neste Fase og Ny Neste Milepæl
            * Slik at brukeren ikke kan sette en fase/milepæl til prosjektet om prosjektet ikke er registrert med den fasen/milepælen
            * Noen enklere måte å gjøre det på? Fiks gjerne.
            */ 
                
            faseParam = SqlDataSourceNyNesteFase.SelectParameters["Prosjekt_ID"]; //SELECT... FROM Fase WHERE Prosjekt_ID=@Prosjekt_ID
            if (faseParam == null)
                SqlDataSourceNyNesteFase.SelectParameters.Add("Prosjekt_ID", "0"); //SELECT... FROM Fase WHERE Prosjekt_ID=0

            milestoneParam = SqlDataSourceNyMilestone.SelectParameters["Prosjekt_ID"]; //SELECT... FROM Milepael WHERE ProsjektID=@Prosjekt_ID

            if (milestoneParam == null)
                SqlDataSourceNyMilestone.SelectParameters.Add("Prosjekt_ID", "0"); //SELECT... FROM Milepael WHERE ProsjektID=0

            connection = new DBConnect();

        }
        
        /// <summary>
        /// Eventmetode for Lagre-knappen
        /// </summary>
        protected void btnLagreNewProject_Click(object sender, EventArgs e)
        {
             try
            {
                //Sjekke etter tom/null input i non-optonal felter
                if (!String.IsNullOrEmpty(textBoxNewNavn.Text.Trim()) && !String.IsNullOrEmpty(textBoxNewOppsummering.Text.Trim())
                    &&  !String.IsNullOrEmpty(idLabel.Text.Trim()) )  
                {
                    //Hent verdier   
                    nyttNavn = textBoxNewNavn.Text; 
                    nyOppsummering = textBoxNewOppsummering.Text;
                    id = Convert.ToInt32(idLabel.Text);
                    prosjektAnsvarlig = Convert.ToInt32(DropDownListAnsvarlig.SelectedValue); //Er aldri null

                    //Bruker dummy items i tilfelle prosjektet ikke har noen faser eller milepæler      
                    if (String.IsNullOrEmpty(DropDownListMilestone.SelectedValue.Trim()))
                        nyMilestone = 0; //Dummy-milepæl
                    else
                        nyMilestone = Convert.ToInt32(DropDownListMilestone.SelectedValue);

                    if (String.IsNullOrEmpty(DropDownListNyNesteFase.SelectedValue.Trim()))
                        nyNesteFase = 0; //Dummy-fase
                    else
                        nyNesteFase = Convert.ToInt32(DropDownListNyNesteFase.SelectedValue);
                    

                    /**Få bekreftelse fra brukeren via MessageBoxpå at han/hun ønsker å redigere
                    *Noen ganger bugger det og den popper ikke opp ordentlig, vet ikke hvorfor.
                    *Det skjer om du allerede har trykket på "Lagre" og så trykket "No", og så trykke "Lagre" igjen.
                    */
                    string dialogString = String.Format("Er du sikker på at du vil redigere prosjektet {0} med Ansvarlig={1}, Milepæl={2}, Fase={3}, id={4}", 
                        nyttNavn, prosjektAnsvarlig, nyMilestone, nyNesteFase,id);
                    System.Windows.Forms.DialogResult dr = new System.Windows.Forms.DialogResult();

                    dr = System.Windows.Forms.MessageBox.Show(dialogString, "Endre Prosjekt", System.Windows.Forms.MessageBoxButtons.YesNo);
                    //bekreftelse på redigering
                    if (dr == System.Windows.Forms.DialogResult.Yes)
                   {
                        connection.EditProject(id, nyttNavn, nyOppsummering, nyNesteFase, prosjektAnsvarlig, nyMilestone); //Metode i DBConnect
                        Page.Response.Redirect(Page.Request.Url.ToString(), true); //Refresh siden 
                    }
                }
                else resultLabel.Text = "Alle feltene må fylles ut!";
            }

             catch (FormatException formatException) { resultLabel.Text = "Format Exception: " + formatException.Message; }
             catch (OverflowException overFlowException) { resultLabel.Text = "Overflow Exception: " + overFlowException.Message; }
             catch (Exception ex) { resultLabel.Text = "Exception: " + ex.Message; }

        
        }
        /// <summary>
        /// Eventmetode for 
        /// </summary>
        protected void GridViewEditProject_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                GridViewRow row = GridViewEditProject.SelectedRow;

                //hente verdier fra den valgte raden
                id = Convert.ToInt32(row.Cells[1].Text); 
                navn = row.Cells[2].Text;
                ansvarlig = row.Cells[3].Text;
                oppsummering = row.Cells[4].Text;

                textBoxNewNavn.Text = navn;
                textBoxNewOppsummering.Text = oppsummering;
                idLabel.Text = id.ToString();
                DropDownListAnsvarlig.SelectedValue = DropDownListAnsvarlig.Items.FindByText(ansvarlig).Value;

                SqlDataSourceNyNesteFase.SelectParameters.Remove(faseParam);
                SqlDataSourceNyMilestone.SelectParameters.Remove(milestoneParam);

                SqlDataSourceNyNesteFase.SelectParameters.Add("Prosjekt_ID", id.ToString());
                SqlDataSourceNyMilestone.SelectParameters.Add("Prosjekt_ID", id.ToString());

            }
            catch(Exception ex)
            {
                //TODO
            }
     
        }

        protected void GridViewEditProject_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            String tname = (string)e.Values["Navn"].ToString();

                System.Windows.Forms.DialogResult dr = new System.Windows.Forms.DialogResult();
                dr = System.Windows.Forms.MessageBox.Show("Er du sikker på at du vil slette prosjektet " +  tname + " ?", "Slette Prosjekt", System.Windows.Forms.MessageBoxButtons.YesNo);
                //bekreftelse på sletting
                if (dr == System.Windows.Forms.DialogResult.No)
                {
                    e.Cancel=true;
                    
                }    
        }
    }
}