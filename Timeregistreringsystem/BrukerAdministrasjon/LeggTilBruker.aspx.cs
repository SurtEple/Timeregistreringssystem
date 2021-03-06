﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Timeregistreringssystem.BrukerAdministrasjon
{
    public partial class LeggTilBruker : System.Web.UI.Page
    {
        private DBConnect db;

        protected void Page_Load(object sender, EventArgs e)
        {
            int rettighet = Convert.ToInt32(Session["Admin"]);
            if (rettighet == Rettigheter.ADMINISTRATOR || rettighet == Rettigheter.PROSJEKT_ANSVARLIG && Global.CheckIP())
            {
                
            }
            else
                Response.Redirect("~/Default");

            lblFeilmelding0.Visible = true;
            imgStjerne0.Visible = true;
            db = new DBConnect();
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "Yes")
            {
                if (!String.IsNullOrEmpty(tbBrukernavn.Text)
                    && !String.IsNullOrEmpty(tbPassord.Text)
                    && !String.IsNullOrEmpty(tbFornavn.Text)
                    && !String.IsNullOrEmpty(tbEtternavn.Text)
                    && !String.IsNullOrEmpty(tbEpost.Text)
                    && !String.IsNullOrEmpty(tbAdresse.Text)
                    && !String.IsNullOrEmpty(tbPostnr.Text)
                    && !String.IsNullOrEmpty(tbTelefonnr.Text)
                    && !String.IsNullOrEmpty(tbBy.Text))
                {
                    if (tbPassord.Text.Equals(tbPassord2.Text))
                    {
                        db = new DBConnect();
                        string brukernavn = tbBrukernavn.Text;
                        string passord = tbPassord.Text;
                        string passord2 = tbPassord2.Text;
                        string fornavn = tbFornavn.Text;
                        string mellomnavn = tbMellomnavn.Text;
                        string etternavn = tbEtternavn.Text;
                        string epost = tbEpost.Text;
                        string im = tbIm.Text;
                        string adresse = tbAdresse.Text;
                        string postnr = tbPostnr.Text;
                        string telefonnr = tbTelefonnr.Text;
                        string by = tbBy.Text;
                        int administrator = Convert.ToInt32(ddlBrukertype.SelectedValue);

                        db.InsertBruker(brukernavn, passord, fornavn, mellomnavn, etternavn, epost, im, adresse, postnr, telefonnr, by, administrator);

                        lblFeilmelding0.Visible = false;
                        imgStjerne0.Visible = false;
                        lblFeilmelding.Text = "Bruker lagt til!";
                        this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Brukeren er lagt til')", true);
                    }
                    else //else passord ikke matcher
                    {
                        lblFeilmelding0.Visible = false;
                        imgStjerne0.Visible = false;
                        lblFeilmelding.Visible = true;
                        lblFeilmelding.Text = "Passordene matcher ikke!";
                        
                    }
                }
                else //else tomme felter
                {
                    lblFeilmelding0.Visible = false;
                    imgStjerne0.Visible = false;
                    lblFeilmelding.Visible = true;
                    lblFeilmelding.Text = "Du må fylle ut alle feltene som kreves";
                }
            } //slutt confirm if
            else
                this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Avbrutt')", true);
            
        } //slutt btnRegister_click
    }
}