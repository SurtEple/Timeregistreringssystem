/**
       * Redigere og Slette oppgaver, samt sette dem som ferdige
       * @author Bjørn
       * kl  17:00- 19:30   26/3/14 Ferdig med å sette oppgaver som ferdige  
       *
       * kl 20:15 - 20:45   26/3/14 Ferdig med slette metode 
       */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Timeregistreringssystem.OppgaveAdmin
{
    public partial class EndreOppgave : System.Web.UI.Page
    {
        private DBConnect connection;
        private bool deleteOK = false, editOK = false;
        private string nyTittel, nyBeskrivelse, nySluttDato;
        private int nyEstimertTid, nyBruktTid;


        protected void Page_Load(object sender, EventArgs e)
        {
            connection = new DBConnect();
            tbxNyTittel.Enabled = false;
            tbxNyBeskrivelse.Enabled = false;
            tbxNyBruktTid.Enabled = false;
            tbxNyEstimertTid.Enabled = false;
            tbxNySluttDato.Enabled = false;
            btnEndreOppgave.Enabled = false;


            //Sjekke etter tom/null input
            if (String.IsNullOrEmpty(ddlRedigereOppgave.SelectedValue))
            {
                tbxNyTittel.Text = "----  Velg en oppgave fra listen  -----";
                tbxNyBeskrivelse.Text = "------  Velg en oppgave fra listen  ----";
                tbxNyBruktTid.Text = "------  Velg en oppgave fra listen  ----";
                tbxNyEstimertTid.Text = "------  Velg en oppgave fra listen  ----";
                tbxNySluttDato.Text = "------  Velg en oppgave fra listen  ----";
            }
            
        }


        // Metode for å sette oppgaver som ferdig
        protected void btnFerdigOppgave_Click(object sender, EventArgs e)
        {
             //Sjekke etter tom/null input
            if (!String.IsNullOrWhiteSpace(tbxBruktTid.Text) && !String.IsNullOrWhiteSpace(dateStopTextBox2.Text))
            {
                connection = new DBConnect();
                int id = Convert.ToInt32(ddlFerdigeOppgaver.SelectedValue);
                int bruktTid = Convert.ToInt32(tbxBruktTid.Text);
                string sluttDato = dateStopTextBox2.Text;
               

                connection.OppgaveFerdig(id, bruktTid, sluttDato);

                System.Windows.Forms.DialogResult dr = new System.Windows.Forms.DialogResult();
                dr = System.Windows.Forms.MessageBox.Show("Oppgaven er nå registrert som ferdig, godt jobbet!");
                Page.Response.Redirect(Page.Request.Url.ToString(), true);
            }
            else lblFerdigTilbakemelding.Text = "Alle felt med * må fylles ut!";
        }


        // Metode for å slette oppgave
        protected void btnSlettOppgave_Click(object sender, EventArgs e)
        {
            try
            {
                //Sjekke etter tom/null input
                if (!String.IsNullOrEmpty(ddlSlettOppgave.SelectedValue))
                {
                    System.Windows.Forms.DialogResult dr = new System.Windows.Forms.DialogResult();
                    // NB!!! trykke på slettknapp, si nei, trykke slettknapp igjen, så popper ikke messagebox opp, men ligger minimized.
                    dr = System.Windows.Forms.MessageBox.Show("Er du sikker på at du vil slette prosjekt " + ddlSlettOppgave.SelectedItem, " Slette prosjekt", System.Windows.Forms.MessageBoxButtons.YesNo);
                    //bekreftelse på sletting
                    if (dr == System.Windows.Forms.DialogResult.Yes)
                    {

                        int id = Convert.ToInt32(ddlSlettOppgave.SelectedValue);
                        deleteOK = connection.slettOppgave(id); //lagre boolsk returverdi     
                        System.Windows.Forms.MessageBox.Show("Sletting gjennomført");
                        Page.Response.Redirect(Page.Request.Url.ToString(), true);

                    }
                    else { System.Windows.Forms.MessageBox.Show("Sletting ikke gjennomført"); Page.Response.Redirect(Page.Request.Url.ToString(), true); }
                }
                else lblSlettOppgaveTilbakemelding.Text = "Alle felt med * må fylles ut!";
            }
            catch (FormatException formatException) { lblSlettOppgaveTilbakemelding.Text = "Format Exception: " + formatException.Message; }
            catch (OverflowException overFlowException) { lblSlettOppgaveTilbakemelding.Text = "Overflow Exception: " + overFlowException.Message; }
            catch (Exception ex) { lblSlettOppgaveTilbakemelding.Text = "Exception: " + ex.Message; }
        }


        //Hente beskrivelse fra den oppgaven som er valgt til redigering
        private string HentRedigerOppgaveBeskrivelse(int id)
        {
            connection = new DBConnect();
            try
            {
                //Sjekke etter tom/null input
                if (!String.IsNullOrEmpty(ddlRedigereOppgave.SelectedValue))
                {
                    // returnerer resultat på query etter å ha brukt id i søket.
                    return connection.editOppgaveHentBeskrivelse(id);
                }
                else return "---------  Velg en oppgave fra listen  ---------";
            }
            catch (Exception ex) { return ex.ToString(); }

        }

        //Hente tittel fra den oppgaven som er valgt til redigering
        private string HentRedigerOppgaveTittel(int id)
        {
            connection = new DBConnect();
            try
            {
                //Sjekke etter tom/null input
                if (!String.IsNullOrEmpty(ddlRedigereOppgave.SelectedValue))
                {
                    // returnerer resultat på query etter å ha brukt id i søket.
                    return connection.editOppgaveHentTittel(id);
                }
                else return "---------  Velg en fase fra listen  ---------";
            }
            catch (Exception ex) { return ex.ToString(); }

        }

        //Hente estimert tid fra den oppgaven som er valgt til redigering
        private string HentRedigerOppgaveEstimertTid(int id)
        {
            connection = new DBConnect();
            try
            {
                //Sjekke etter tom/null input
                if (!String.IsNullOrEmpty(ddlRedigereOppgave.SelectedValue))
                {
                    // returnerer resultat på query etter å ha brukt id i søket.
                    return connection.editOppgaveHentEstimertTid(id);
                }
                else return "---------  Velg en fase fra listen  ---------";
            }
            catch (Exception ex) { return ex.ToString(); }

        }

        //Hente brukt tid fra den oppgaven som er valgt til redigering
        private string HentRedigerOppgaveBruktTid(int id)
        {
            connection = new DBConnect();
            try
            {
                //Sjekke etter tom/null input
                if (!String.IsNullOrEmpty(ddlRedigereOppgave.SelectedValue))
                {
                    // returnerer resultat på query etter å ha brukt id i søket.
                    return connection.editOppgaveHentBruktTid(id);
                }
                else return "---------  Velg en fase fra listen  ---------";
            }
            catch (Exception ex) { return ex.ToString(); }

        }

        //Hente brukt tid fra den oppgaven som er valgt til redigering
        private string HentRedigerOppgaveSluttDato(int id)
        {
            connection = new DBConnect();
            try
            {
                //Sjekke etter tom/null input
                if (!String.IsNullOrEmpty(ddlRedigereOppgave.SelectedValue))
                {
                    // returnerer resultat på query etter å ha brukt id i søket.
                    return connection.editOppgaveHentSluttDato(id);
                }
                else return "---------  Velg en oppgave fra listen  ---------";
            }
            catch (Exception ex) { return ex.ToString(); }

        }

        //Index change listener på dropdownlist
        protected void ddlRedigereOppgave_SelectedIndexChanged(object sender, EventArgs e)
        {
            //oppdatere beskrivelse og navn på valgt fase
            try
            {
                int id = Convert.ToInt32(ddlRedigereOppgave.SelectedValue);

                if (id != 0)
                {
                    tbxNyTittel.Enabled = true;
                    tbxNyBeskrivelse.Enabled = true;
                    tbxNyBruktTid.Enabled = true;
                    tbxNyEstimertTid.Enabled = true;
                    tbxNySluttDato.Enabled = true;
                    btnEndreOppgave.Enabled = true;

                    tbxNyTittel.Text = HentRedigerOppgaveTittel(id);
                    tbxNyBeskrivelse.Text = HentRedigerOppgaveBeskrivelse(id);
                    tbxNyBruktTid.Text = HentRedigerOppgaveBruktTid(id);
                    tbxNyEstimertTid.Text = HentRedigerOppgaveEstimertTid(id);
                    tbxNySluttDato.Text = HentRedigerOppgaveSluttDato(id);

                }
            }
            catch (FormatException formatException) { lblEndreOppgave.Text = "Format Exception: " + formatException.Message; }
            catch (OverflowException overFlowException) { lblEndreOppgave.Text = "Overflow Exception: " + overFlowException.Message; }
            catch (Exception ex) { lblEndreOppgave.Text = "Exception: " + ex.Message; }

        }

        // Metode for å endre bruker
        protected void btnEndreOppgave_Click(object sender, EventArgs e)
        {
            try
            {
                //Sjekke etter tom/null input
                if (!String.IsNullOrEmpty(ddlRedigereOppgave.SelectedValue) && !String.IsNullOrEmpty(tbxNyBeskrivelse.Text)
                    && !String.IsNullOrEmpty(tbxNyBeskrivelse.Text) && !String.IsNullOrEmpty(tbxNyEstimertTid.Text)
                    && !String.IsNullOrEmpty(tbxNyBruktTid.Text) && !String.IsNullOrEmpty(tbxNySluttDato.Text))
                {
                    //bekreftelse på redigering av fase
                    System.Windows.Forms.DialogResult dr = new System.Windows.Forms.DialogResult();
                    dr = System.Windows.Forms.MessageBox.Show("Er du sikker på at du vil redigere oppgaven til å ha disse verdiene?", "Redigere oppgave", System.Windows.Forms.MessageBoxButtons.YesNo);


                    if (dr == System.Windows.Forms.DialogResult.Yes)
                    {
                        int id = Convert.ToInt32(ddlRedigereOppgave.SelectedValue);
                        nyTittel = tbxNyTittel.Text;
                        nyBeskrivelse = tbxNyBeskrivelse.Text;
                        nySluttDato = tbxNySluttDato.Text;
                        nyEstimertTid = Convert.ToInt32(tbxNyEstimertTid.Text);
                        nyBruktTid = Convert.ToInt32(tbxNyBruktTid.Text);

                        editOK = connection.OppdaterOppgave(id, nyTittel, nyBeskrivelse, nySluttDato, nyEstimertTid, nyBruktTid); //lagre boolsk returverdi
                        Page.Response.Redirect(Page.Request.Url.ToString(), true);
                    }
                }
                else lblEndreOppgave.Text = "Feltene kan ikke være tomme!";
            }

            catch (FormatException formatException) { lblEndreOppgave.Text = "Format Exception: " + formatException.Message; }
            catch (OverflowException overFlowException) { lblEndreOppgave.Text = "Overflow Exception: " + overFlowException.Message; }
            catch (Exception ex) { lblEndreOppgave.Text = "Exception: " + ex.Message; }

        }

       


    }
}