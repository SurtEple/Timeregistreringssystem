
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

/**
 * Endre Fase
 * @author Thomas og Thea, Gruppe 2
 */

namespace Timeregistreringssystem.Prosjektadmin
{
    public partial class EndreFase : System.Web.UI.Page
    {
          //variabler
        DBConnect connection;
        private String nyttNavn, nyBeskrivelse;

        protected void Page_Load(object sender, EventArgs e)
        {

            textBoxNewNavn.Enabled = false;
            textBoxNewBeskrivelse.Enabled = false;
            btnLagreNewFase.Enabled = false;


            //Sjekke etter tom/null input
            if (String.IsNullOrEmpty(DropDownListEditFase.SelectedValue))
            {
                textBoxNewBeskrivelse.Text = "----  Velg en fase fra listen  -----";
                textBoxNewNavn.Text = "------  Velg en fase fra listen  ----";
            }
         
        }

        //Hente informasjon fra det prosjektet som er valgt til redigering
        private string HentRedigerFaseBeskrivelse(int id) 
        {
             connection = new DBConnect();
             try
             {
                 //Sjekke etter tom/null input
                 if (!String.IsNullOrEmpty(DropDownListEditFase.SelectedValue))
                 {                  
                     // returnerer resultat på query etter å ha brukt id i søket.
                     return connection.editFaseHentBeskrivelse(id);
                 }
                 else return "---------  Velg en fase fra listen  ---------";
             }
             catch (Exception ex) { return ex.ToString(); }

        }

        //Hente informasjon fra det prosjektet som er valgt til redigering
        private bool HentRedigerFaseAktiv(int id)
        {
            bool aktiv=false;
            connection = new DBConnect();
            try
            {
                //Sjekke etter tom/null input
                if (!String.IsNullOrEmpty(DropDownListEditFase.SelectedValue))
                {
                    // returnerer resultat på query etter å ha brukt id i søket.
                    aktiv = connection.EditFaseHentAktiv(id);
                    
                }
                else throw new Exception("Dropdown exception!");
            }
            catch (Exception ex) {  }
            return aktiv;
        }

        //Hente informasjon fra det prosjektet som er valgt til redigering
        private string HentRedigerFaseNavn(int id)
        {
            connection = new DBConnect();
            try
            {
                //Sjekke etter tom/null input
                if (!String.IsNullOrEmpty(DropDownListEditFase.SelectedValue))
                {
                    // returnerer resultat på query etter å ha brukt id i søket.
                    return connection.editFaseHentNavn(id);
                }
                else return "---------  Velg en fase fra listen  ---------";
            }
            catch (Exception ex) { return ex.ToString(); }

        }


        //Redigere Fase
        protected void btnLagreNewFase_Click(object sender, EventArgs e)
        {
            connection = new DBConnect();
            try
            {
                //Sjekke etter tom/null input
                if (!String.IsNullOrEmpty(DropDownListEditFase.SelectedValue) || !String.IsNullOrEmpty(textBoxNewNavn.Text) ||
                    !String.IsNullOrEmpty(DropDownListEditFase.Text) )
                {
                    //bekreftelse på redigering av fase
                    System.Windows.Forms.DialogResult dr = new System.Windows.Forms.DialogResult();
                    dr = System.Windows.Forms.MessageBox.Show("Er du sikker på at du vil redigere fasen <<" 
                        + DropDownListEditFase.SelectedItem + ">>\n til <<" +textBoxNewNavn.Text 
                        + ">> med tilhørende beskrivelse?", " Redigere fase", System.Windows.Forms.MessageBoxButtons.YesNo);

                   
                    if (dr == System.Windows.Forms.DialogResult.Yes)
                    {
                        int id = Convert.ToInt32(DropDownListEditFase.SelectedValue);
                        nyttNavn = textBoxNewNavn.Text;
                        nyBeskrivelse = textBoxNewBeskrivelse.Text;

                        bool isActive = EditFaseCheckIsFaseActive.Checked;      
         
                       connection.EditFase(id, nyttNavn, nyBeskrivelse,isActive);
                        Page.Response.Redirect(Page.Request.Url.ToString(), true);
                    }
                }
                else resultLabel0.Text = "Feltene kan ikke være tomme!";
            }

            catch (FormatException formatException) { resultLabel0.Text = "Format Exception: " + formatException.Message; }
            catch (OverflowException overFlowException) { resultLabel0.Text = "Overflow Exception: " + overFlowException.Message; }
            catch (Exception ex) { resultLabel0.Text = "Exception: " + ex.Message; }
        }


        //Index change listener på dropdownlist
        protected void DropDownListEditFase_SelectedIndexChanged(object sender, EventArgs e)
        {
            //oppdatere beskrivelse og navn på valgt fase
            try {
                    int id = Convert.ToInt32(DropDownListEditFase.SelectedValue);

                    if (id != 0)
                    {
                        textBoxNewNavn.Enabled = true;
                        textBoxNewBeskrivelse.Enabled = true;
                        btnLagreNewFase.Enabled = true;

                        textBoxNewNavn.Text = HentRedigerFaseNavn(id);
                        textBoxNewBeskrivelse.Text = HentRedigerFaseBeskrivelse(id);
                        EditFaseCheckIsFaseActive.Checked = HentRedigerFaseAktiv(id);
                        
                    }                          
                }
            catch (FormatException formatException) { resultLabel0.Text = "Format Exception: " + formatException.Message; }
            catch (OverflowException overFlowException) { resultLabel0.Text = "Overflow Exception: " + overFlowException.Message; }
            catch (Exception ex) { resultLabel0.Text = "Exception: " + ex.Message; } 
      
        }



        protected void GridViewFase_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void GridViewFase_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            String tname = (string)e.Values["Navn"].ToString();

            System.Windows.Forms.DialogResult dr = new System.Windows.Forms.DialogResult();
            dr = System.Windows.Forms.MessageBox.Show("Er du sikker på at du vil slette fasen " + tname + " ?", "Slette Fase", System.Windows.Forms.MessageBoxButtons.YesNo);
            //bekreftelse på Sletting
            if (dr == System.Windows.Forms.DialogResult.No)
            {
                e.Cancel = true;

            }   
        }

        protected void GridViewFase_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }
    }
}