﻿using System;
using System.Web.UI.WebControls;

/**
 * Endre Prosjekt
 * author Thomas og Thea, Gruppe 2
 */ 
namespace Timeregistreringssystem.Prosjektadmin
{
    public partial class EndreProsjekt : System.Web.UI.Page
    {
       
        private DBConnect connection;
        private string nyttNavn, nyOppsummering, navn, oppsummering, ansvarlig;
        private int nyNesteFase, prosjektAnsvarlig, nyNesteMilestone, id, nyMilestone;
        private Parameter faseParam, milestoneParam, nyMilestoneParam;

        private void Page_Init(object sender, EventArgs e)
        {
            if (Session["Admin"] != null)
            {
                if (!((int)Session["Admin"] == Rettigheter.PROSJEKT_ANSVARLIG && Global.CheckIP()))
                    Response.Redirect("~/Default.aspx");
            }
            else
                Response.Redirect("~/Default.aspx");
        }
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
                    prosjektAnsvarlig = Convert.ToInt32(DropDownListAnsvarlig.SelectedItem.Value); //Er aldri null

                    //Bruker dummy items i tilfelle prosjektet ikke har noen faser eller milepæler      
                    if (String.IsNullOrEmpty(DropDownListMilestone.SelectedValue.Trim()))
                        nyNesteMilestone = 0; //Dummy-milepæl
                    else
                        nyNesteMilestone = Convert.ToInt32(DropDownListMilestone.SelectedItem.Value);

                    if (String.IsNullOrEmpty(DropDownListNyNesteFase.SelectedValue.Trim()))
                        nyNesteFase = 0; //Dummy-fase
                    else
                        nyNesteFase = Convert.ToInt32(DropDownListNyNesteFase.SelectedItem.Value);
                    

                    //Få bekreftelse fra brukeren vha javascript
                    string confirmValue = Request.Form["confirm_value"];
                    if (confirmValue == "Yes")
                    {
                       
                        SqlDataSource1.UpdateParameters.Add("ProsjektNavn", nyttNavn);
                        SqlDataSource1.UpdateParameters.Add("ProsjektOppsummering", nyOppsummering);
                        SqlDataSource1.UpdateParameters.Add("AnsvarligID", prosjektAnsvarlig.ToString());
                        SqlDataSource1.UpdateParameters.Add("NesteFase", nyNesteFase.ToString());
                        SqlDataSource1.UpdateParameters.Add("NesteMil", nyNesteMilestone.ToString());
                        SqlDataSource1.UpdateParameters.Add("ID", id.ToString());

                        SqlDataSource1.Update();


                        Page.Response.Redirect(Page.Request.Url.ToString(), true); //Refresh siden 
                    }
                    else
                        this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Avbrutt')", true);
        
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

    }
}