using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.Windows.Forms;
/*
 * @Author Thomas
 * 2014 April
 * */

namespace Timeregistreringssystem.BrukerAdministrasjon
{
    public partial class TimeRegistrering : System.Web.UI.Page
    {
     //   private double timeElapsed = 0.0;

        private DateTime dateStart = new DateTime();
        private DateTime dateStop = new DateTime();
        private DateTime dateTotal = new DateTime();
        private DateTime datePause = new DateTime();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            dateStart = DateTime.Now;
            Session["StartDato"] = dateStart;

            SqlDataSource1.InsertParameters.Add("Start",dateStart.ToString("u"));
            SqlDataSource1.Insert();
            Label1.Text = dateStart.ToString();            
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
             
            datePause = DateTime.Now;
            Session["PauseDato"] = datePause;

            //dateStart = Convert.ToDateTime(Session["StartDato"].ToString());
        //    dateStart = Convert.ToDateTime(Session["StartDato"]);
       //     dateTotal = Convert.ToDateTime(datePause.Subtract(dateStart).ToString());

      //      Label3.Text = "Differanse: " + (datePause.Subtract(dateStart) + "totaltid:" + dateTotal.ToString());
        //    Label2.Text = "StartTid:" + dateStart.TimeOfDay.ToString();

            SqlDataSource2.InsertParameters.Add("Pause", datePause.ToString("u"));
            SqlDataSource2.Insert();
           
            GridView1.DataBind();

        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            dateStop = DateTime.Now;
      //      Session["SluttDato"] = dateStop;

      //      dateStart = Convert.ToDateTime(Session["StartDato"]);
     //       datePause = Convert.ToDateTime(Session["PauseDato"]);
    //        dateStop = Convert.ToDateTime(Session["SluttDato"]);

       //    DateTime dateTotal2 = Convert.ToDateTime(dateStop.Subtract(dateStart).ToString());
        //    dateTotal2.Subtract(datePause);
        
            SqlDataSource3.InsertParameters.Add("Slutt", dateStop.ToString("u"));
            SqlDataSource3.Insert();
            GridView1.DataBind();
          //  dateStop = Convert.ToDateTime(dateStop.Subtract(dateStart));
          //  dateStop.Subtract(dateTotal);
            
            Label3.Text = "ArbeidsTid:"+ dateTotal.ToString(); 
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            
        }

    }
}