/* @author Thomas
* 26/03/14
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Timeregistreringssystem.Prosjektadmin
{
    public partial class LeggTilMilepael : System.Web.UI.Page
    {
        private DBConnect connection;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //Sjekke etter tom/null input
            if (!String.IsNullOrEmpty(TextBoxMilepaelBeskrivelse.Text) )
            {
               connection = new DBConnect();
         
                string beskrivelse = TextBoxMilepaelBeskrivelse.Text;

                try
                {
                    connection.InsertMilepael(beskrivelse, Convert.ToInt32(DropDownListLeggTilMilepaelVisProsjekt.SelectedValue));
                }
                catch(Exception ex)
                {
                    //exceptions mangler
                }
             }
        }
    }
}