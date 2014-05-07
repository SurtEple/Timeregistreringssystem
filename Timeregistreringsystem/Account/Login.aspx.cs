using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.Security;
using Timeregistreringssystem.Models;
using System.Windows.Forms;

namespace Timeregistreringssystem.Account
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void LogIn(object sender, EventArgs e)
        {
            if (IsValid)
            {
                DBConnect db = new DBConnect();
                Bruker bruker = db.CheckInnlogging(UserName.Text, Password.Text);
                if (bruker != null)
                {

                    Session["Innlogget"] = true;
                    Session["Admin"] = bruker.Rettigheter;
                    Session["BrukerID"] = bruker.Id;
                    Session["IP"] = Global.GetIPAddress();
                    IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);

                }
                else
                {
                    MessageBox.Show("Feil brukernavn og/eller passord");
                }

                /*
                var manager = new UserManager();
                
                ApplicationUser user = manager.Find(UserName.Text, Password.Text);
                if (user != null)
                {
                    IdentityHelper.SignIn(manager, user, RememberMe.Checked);

                    IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                }
                else
                {
                    FailureText.Text = "Invalid username or password.";
                    ErrorMessage.Visible = true;
                }
                 */
            }
        }
    }
}