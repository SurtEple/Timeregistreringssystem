/**
       * Redigere&Slette Fase
       * @author Thomas 
       * kl  10:00-18:40   19/3/14   
       */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Timeregistreringssystem.Prosjektadmin
{
    public partial class EndreFase : System.Web.UI.Page
    {
            //variabler
        DBConnect connection;
        private String nyttNavn, nyBeskrivelse;
        private bool  deleteOK = false, editOK = false;

        protected void Page_Load(object sender, EventArgs e)
        {

            textBoxNewNavn.Enabled = false;
            textBoxNewBeskrivelse.Enabled = false;
            btnLagreNewFase.Enabled = false;
            btnSlettFase.Enabled = false;

            //Sjekke etter tom/null input
            if (String.IsNullOrEmpty(DropDownListSlettFase.SelectedValue))
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
                 if (!String.IsNullOrEmpty(DropDownListSlettFase.SelectedValue))
                 {                  
                     // returnerer resultat på query etter å ha brukt id i søket.
                     return connection.editFaseHentBeskrivelse(id);
                 }
                 else return "---------  Velg en fase fra listen  ---------";
             }
             catch (Exception ex) { return ex.ToString(); }

        }

        //Hente informasjon fra det prosjektet som er valgt til redigering
        private string HentRedigerFaseNavn(int id)
        {
            connection = new DBConnect();
            try
            {
                //Sjekke etter tom/null input
                if (!String.IsNullOrEmpty(DropDownListSlettFase.SelectedValue))
                {
                    // returnerer resultat på query etter å ha brukt id i søket.
                    return connection.editFaseHentNavn(id);
                }
                else return "---------  Velg en fase fra listen  ---------";
            }
            catch (Exception ex) { return ex.ToString(); }

        }

        //Slette Fase
        protected void btnSlett_Click(object sender, EventArgs e)
        {
            connection = new DBConnect();
            try {
              //Sjekke etter tom/null input
                if (!String.IsNullOrEmpty(DropDownListSlettFase.SelectedValue))
                {
                    System.Windows.Forms.DialogResult dr = new System.Windows.Forms.DialogResult();
                    // NB!!! trykke på slettknapp, si nei, trykke slettknapp igjen, så popper ikke messagebox opp, men ligger minimized.
                    dr = System.Windows.Forms.MessageBox.Show("Er du sikker på at du vil slette fasen " + DropDownListSlettFase.SelectedItem," Slette fase", System.Windows.Forms.MessageBoxButtons.YesNo);
                   //bekreftelse på sletting
                    if (dr == System.Windows.Forms.DialogResult.Yes)
                    {                       
                        int id = Convert.ToInt32(DropDownListSlettFase.SelectedValue);
                        deleteOK = connection.delFase(id); //lagre boolsk returverdi     
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
                        editOK = connection.editFase(id, nyttNavn, nyBeskrivelse,isActive); //lagre boolsk returverdi
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
                        
                    }                          
                }
            catch (FormatException formatException) { resultLabel0.Text = "Format Exception: " + formatException.Message; }
            catch (OverflowException overFlowException) { resultLabel0.Text = "Overflow Exception: " + overFlowException.Message; }
            catch (Exception ex) { resultLabel0.Text = "Exception: " + ex.Message; } 
      
        }

        protected void DropDownListSlettFase_SelectedIndexChanged(object sender, EventArgs e)
        {
             int id = Convert.ToInt32(DropDownListEditFase.SelectedValue);

             if (id != 0)
             {
                 btnSlettFase.Enabled = true;
             }
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
    }
}