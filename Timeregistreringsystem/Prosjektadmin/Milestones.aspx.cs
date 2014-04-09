
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

/* @author Thomas og Thea
* 
 * 08.04 - 12:30-13:30 fikk til datetimepicker WOOHOO
 */
namespace Timeregistreringssystem.Prosjektadmin
{
    public partial class Milestones : System.Web.UI.Page
    {
        private DBConnect connection;
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void btnLagre_Click(object sender, EventArgs e)
        {
            //Sjekke etter tom/null input
            if (!String.IsNullOrEmpty(dateFerdigTextBox.Text) && DropDownListOppgave.SelectedValue!=null)
            {
                string datoFerdig = dateFerdigTextBox.Text;
                int oppgaveID = Convert.ToInt32(DropDownListOppgave.SelectedValue);

                try
                {
                    connection = new DBConnect();
                    connection.InsertMilepæl(datoFerdig, oppgaveID);

                }
                catch (System.FormatException ex) { resultLabel.Text = "Format Exception! " + ex.Message; }
                catch (System.OverflowException ex) { resultLabel.Text = "Overflow Exception! " + ex.Message; }
                catch (Exception ex) { resultLabel.Text = ex.Message; }
                finally { Page.Response.Redirect(Page.Request.Url.ToString(), true); }
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string milestoneNavn = (string)e.Values["Oppgave"].ToString();

            System.Windows.Forms.DialogResult dr = new System.Windows.Forms.DialogResult();
            dr = System.Windows.Forms.MessageBox.Show("Er du sikker på at du vil slette milepælen " + milestoneNavn + " ?", "slette milepæl", System.Windows.Forms.MessageBoxButtons.YesNo);
            //bekreftelse på sletting
            if (dr == System.Windows.Forms.DialogResult.No)
            {
                e.Cancel = true;
            }
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                
                GridViewRow row = (GridViewRow)GridView1.Rows[e.RowIndex];
                int id = Int32.Parse(GridView1.DataKeys[e.RowIndex].Value.ToString());
                string datoFerdig = e.NewValues["Dato Ferdig"].ToString();
              //  string beskrivelseNew = e.NewValues["Beskrivelse"].ToString();
              //  string datoFerdigFormat = string.Format("{yyyy-MM-dd}", datetime);



                System.Windows.Forms.DialogResult dr = new System.Windows.Forms.DialogResult();
                dr = System.Windows.Forms.MessageBox.Show("Milepæl ID " + id + "Er du sikker på at du vil endre dato til' " + datoFerdig + "' ?", "Endre milepæl", System.Windows.Forms.MessageBoxButtons.YesNo);
                //bekreftelse på Oppdatering
                if (dr == System.Windows.Forms.DialogResult.No)
                {
                    e.Cancel = true;
                }

                else
                {
                    SqlDataSourceMilepael.UpdateParameters.Add("ID", id.ToString()); //UPDATE..WHERE ID=@ID
                   // SqlDataSourceMilepael.UpdateParameters.Add("Tittel", tittel); //UPDATE..WHERE ID=@ID
                    SqlDataSourceMilepael.UpdateParameters.Add("DatoFerdig", datoFerdig); //UPDATE..WHERE ID=@ID
                   // SqlDataSourceMilepael.UpdateParameters.Add("Beskrivelse", beskrivelseNew); //UPDATE..SET Beskrivelse=@Beskrivelse
                  



                }
            }
            catch (System.ArgumentNullException ane) { resultLabel.Text = "Argument Null Exception while trying to parse ID! " + ane.Message; }

        }

        protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {

            if (e.Exception != null)
                System.Windows.Forms.MessageBox.Show(e.Exception.Message);

            Page.Response.Redirect(Page.Request.Url.ToString(), true); //Refresh siden

        }

    }
}