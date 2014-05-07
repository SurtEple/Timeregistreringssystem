using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;


namespace Timeregistreringssystem
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            
        }
        protected void Application_Error(object sender, EventArgs e)
        {
            Exception ex = Server.GetLastError();

            if (ex is HttpRequestValidationException)
            {
                Response.Redirect("~/ErrorXSS.aspx", true);
            }
        }
        public static string GetIPAddress()
        {
            System.Web.HttpContext context = System.Web.HttpContext.Current;
            string ipAddress = context.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (!string.IsNullOrEmpty(ipAddress))
            {
                string[] addresses = ipAddress.Split(',');
                if (addresses.Length != 0)
                {
                    return addresses[0];
                }
            }

            return context.Request.ServerVariables["REMOTE_ADDR"];
        }
        public static bool CheckIP()
        {
            System.Web.HttpContext context = System.Web.HttpContext.Current;
            string ip = Convert.ToString(context.Session["IP"]) != null ? Convert.ToString(context.Session["IP"]) : "";
            if (ip.Equals(GetIPAddress()))
            {
                
                return true;
            }
            else
            {
                context.Response.Write("<script>alert('\" Diffrent IP for session discoverd logging you off \"')</script>");
                HttpContext.Current.Session.Abandon();
                HttpContext.Current.Session.Clear();
                
                return false;
                
            }
                
           

        }
    }
}