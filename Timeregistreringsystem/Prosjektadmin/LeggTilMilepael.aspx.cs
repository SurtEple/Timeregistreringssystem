﻿
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

/* @author Thomas
* 26/03/14
 */
namespace Timeregistreringssystem.Prosjektadmin
{
    public partial class LeggTilMilepael : System.Web.UI.Page
    {
        private DBConnect connection;
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void btnLagre_Click(object sender, EventArgs e)
        {
            //Sjekke etter tom/null input
            if (!String.IsNullOrEmpty(textBoxBeskrivelse.Text))
            {
                string beskrivelse = textBoxBeskrivelse.Text;

                try
                {
                    connection = new DBConnect();
                    connection.InsertMilepael(beskrivelse, Convert.ToInt32(DropDownListProsjekt.SelectedValue));

                }
                catch (System.FormatException ex) { resultLabel.Text = "Format Exception! " + ex.Message; }
                catch (System.OverflowException ex) { resultLabel.Text = "Overflow Exception! " + ex.Message; }
                catch (Exception ex) { resultLabel.Text = ex.Message; }
                finally { Page.Response.Redirect(Page.Request.Url.ToString(), true); }
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string milestoneNavn = (string)e.Values["Milepæl Beskrivelse"].ToString();

            System.Windows.Forms.DialogResult dr = new System.Windows.Forms.DialogResult();
            dr = System.Windows.Forms.MessageBox.Show("Er du sikker på at du vil slette milepælen " + milestoneNavn + " ?", "slette milepæl", System.Windows.Forms.MessageBoxButtons.YesNo);
            //bekreftelse på sletting
            if (dr == System.Windows.Forms.DialogResult.No){
                e.Cancel = true;
            }    
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = (GridViewRow)GridView1.Rows[e.RowIndex];
                int id = Int32.Parse(GridView1.DataKeys[e.RowIndex].Value.ToString());
                string beskrivelseNew = e.NewValues["Milepæl Beskrivelse"].ToString();
                string møtt = e.NewValues["Møtt"].ToString();


                System.Windows.Forms.DialogResult dr = new System.Windows.Forms.DialogResult();
                dr = System.Windows.Forms.MessageBox.Show("ProsjektID: " + id + "Er du sikker på at du vil endre beskrivelsen til' " + beskrivelseNew + "' og status Møtt til " + møtt + " ?", "Endre milepæl", System.Windows.Forms.MessageBoxButtons.YesNo);
                //bekreftelse på Oppdatering
                if (dr == System.Windows.Forms.DialogResult.No)
                {
                    e.Cancel = true;
                }

                else
                {
                    SqlDataSourceMilepael.UpdateParameters.Add("ID", id.ToString()); //UPDATE..WHERE ID=@ID
                    SqlDataSourceMilepael.UpdateParameters.Add("Beskrivelse", beskrivelseNew); //UPDATE..SET Beskrivelse=@Beskrivelse
                    SqlDataSourceMilepael.UpdateParameters.Add("Møtt", møtt); //Update... SET Møtt=@Møtt

                }
            }
            catch (System.ArgumentNullException ane) { resultLabel.Text = "Argument Null Exception while trying to parse ID! " + ane.Message; }
            
        }

    }
}