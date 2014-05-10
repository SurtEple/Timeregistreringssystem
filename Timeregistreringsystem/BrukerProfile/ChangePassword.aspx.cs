using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Timeregistreringssystem.BrukerProfile
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int rettighet = Convert.ToInt32(Session["Admin"]);
            if (rettighet == Rettigheter.VANLIG_BRUKER && Global.CheckIP())
            {
                
            }
            else
                Response.Redirect("~/Default");
        }
        protected void ChangePw(object sender, EventArgs e)
        {
            string password = NyttPassord.Text;
            string gjentaPassword = GjentaPassord.Text;

            if(password.Equals(gjentaPassword))
            {
                int id = (int)Session["BrukerID"];
                DBConnect db = new DBConnect();
                db.EndrePassord(id, password);
            }
            else
                this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Passordene er ikke like!')", true);
        }
    }
}