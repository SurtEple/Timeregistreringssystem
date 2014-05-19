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
            //sjekker om bruker har rettigheter til å se siden.
            int rettighet = Convert.ToInt32(Session["Admin"]);
            if (rettighet == Rettigheter.VANLIG_BRUKER && Global.CheckIP())
            {
                
            }
            else
                Response.Redirect("~/Default");
        }
        //Event som kjøres når knappen blir trykket
        protected void ChangePw(object sender, EventArgs e)
        {
            //henter ut passordene fra teksten
            string password = NyttPassord.Text;
            string gjentaPassword = GjentaPassord.Text;
            //sjekker om teksten brukeren har skrevet er like
            if(password.Equals(gjentaPassword))
            {
                //henter ut id fra sesjonen og sender til metoden EndrePassord i DBConnect klassen, som hasher og legger til nytt passord i databasen
                int id = (int)Session["BrukerID"];
                DBConnect db = new DBConnect();
                db.EndrePassord(id, password);
            }
            //hvis teksten ikker stemmer vis en alert
            else
                this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Passordene er ikke like!')", true);
        }
    }
}