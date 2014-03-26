using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Timeregistreringssystem.Prosjektadmin
{
    public partial class EndreProsjekt : System.Web.UI.Page
    {
        //variabler
       DBConnect connection;
        private String nyttNavn, nyOppsummering;
        int nyNesteFase;
        private bool  deleteOK = false, editOK = false;
       
        protected void Page_Load(object sender, EventArgs e)
        {
            connection = new DBConnect();
        }

        protected void btnSlett_Click(object sender, EventArgs e)
        {
            try
            {
                //Sjekke etter tom/null input
                if (!String.IsNullOrEmpty(DropDownListSlettProsjekt.SelectedValue))
                {
                    System.Windows.Forms.DialogResult dr = new System.Windows.Forms.DialogResult();
                    // NB!!! trykke på slettknapp, si nei, trykke slettknapp igjen, så popper ikke messagebox opp, men ligger minimized.
                    dr = System.Windows.Forms.MessageBox.Show("Er du sikker på at du vil slette prosjekt " + DropDownListSlettProsjekt.SelectedItem," Slette prosjekt", System.Windows.Forms.MessageBoxButtons.YesNo);
                   //bekreftelse på sletting
                    if (dr == System.Windows.Forms.DialogResult.Yes)
                    {
                       
                        int id = Convert.ToInt32(DropDownListSlettProsjekt.SelectedValue);
                        deleteOK = connection.delProject(id); //lagre boolsk returverdi     
                        System.Windows.Forms.MessageBox.Show("Sletting gjennomført"); 
                        Page.Response.Redirect(Page.Request.Url.ToString(), true);
                       
                    }
                    else { System.Windows.Forms.MessageBox.Show("Sletting ikke gjennomført"); Page.Response.Redirect(Page.Request.Url.ToString(), true); }    
                }
                else resultLabel.Text = "Feltene kan ikke være tomme!";
            }
            catch (FormatException formatException) { resultLabel.Text = "Format Exception: " + formatException.Message; }
            catch (OverflowException overFlowException) { resultLabel.Text = "Overflow Exception: " + overFlowException.Message; }
            catch (Exception ex) { resultLabel.Text = "Exception: " + ex.Message; }
        }

        protected void btnLagreNewProject_Click(object sender, EventArgs e)
        {
             try
            {
                //Sjekke etter tom/null input
                if (!String.IsNullOrEmpty(DropDownListEditProsjekt.SelectedValue) && !String.IsNullOrEmpty(textBoxNewNavn.Text) &&
                    !String.IsNullOrEmpty(DropDownListEditProsjekt.Text) )
                {
                      System.Windows.Forms.DialogResult dr = new System.Windows.Forms.DialogResult();                 
                    dr = System.Windows.Forms.MessageBox.Show("Er du sikker på at du vil redigere prosjekt " + DropDownListEditProsjekt.SelectedItem," Redigere prosjekt", System.Windows.Forms.MessageBoxButtons.YesNo);
                   //bekreftelse på redigering
                    if (dr == System.Windows.Forms.DialogResult.Yes)
                    {
                        int id = Convert.ToInt32(DropDownListEditProsjekt.SelectedValue);
                        nyttNavn = textBoxNewNavn.Text;
                        nyOppsummering = textBoxNewOppsummering.Text;
                        nyNesteFase = Convert.ToInt32(DropDownListNyNesteFase.SelectedValue);   
                      
                        editOK = connection.editProject(id, nyttNavn, nyOppsummering, nyNesteFase); //lagre boolsk returverdi
                        Page.Response.Redirect(Page.Request.Url.ToString(), true);
                    }
                }
                else resultLabel0.Text = "Feltene kan ikke være tomme!";
            }

             catch (FormatException formatException) { resultLabel0.Text = "Format Exception: " + formatException.Message; }
             catch (OverflowException overFlowException) { resultLabel0.Text = "Overflow Exception: " + overFlowException.Message; }
             catch (Exception ex) { resultLabel0.Text = "Exception: " + ex.Message; }

        
        }
    }
}