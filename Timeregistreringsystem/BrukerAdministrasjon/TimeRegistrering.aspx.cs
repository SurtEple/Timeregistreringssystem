using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Globalization;
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
        private DateTime datePauseStart = new DateTime();
        private DateTime datePauseStop = new DateTime();
        TimeSpan pauseTSFraDB = new TimeSpan();
        private DateTime pauseSum = new DateTime();

        private TimeSpan TotalTid = new TimeSpan();
        //private bool isPaused;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] != null)
            {
                var userID = (int) Session["Admin"];
                if (userID == Rettigheter.VANLIG_BRUKER || userID == Rettigheter.PROSJEKT_ANSVARLIG 
                        || userID==Rettigheter.ADMINISTRATOR || userID==Rettigheter.TEAMLEDER)
                {
                   Parameter p = SqlDataSourceRegistreringer.SelectParameters["BrukerID"];
                    SqlDataSourceRegistreringer.SelectParameters.Remove(p);
                 SqlDataSourceRegistreringer.SelectParameters.Add("BrukerID", Session["BrukerID"].ToString());
                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }
            }
            else
                Response.Redirect("~/Default.aspx");
        }


        // Starttidspunkt, må være logget inn for å koble en bruker til registreringen
        protected void Button1_Click(object sender, EventArgs e)
        {
            ButtonStart.Enabled = false;
            ButtonPause.Enabled = true;
            ButtonStop.Enabled = true;

            dateStart = DateTime.Now;
            Session["StartDato"] = dateStart;
            int BrukerID = (int)Session["BrukerID"];
            SqlDataSourceTimer.InsertParameters.Add("Start",dateStart.ToString("u"));
            SqlDataSourceTimer.InsertParameters.Add("BrukerID", BrukerID.ToString() );
       //     SqlDataSourcePause.InsertParameters.Add("Totaltid","0");  
            SqlDataSourceTimer.Insert();

           TimerGridView.DataBind();
            GridView1.DataBind();
            Label1.Text = dateStart.ToString();            
        }

        protected void ButtonPause_Click(object sender, EventArgs e)
        {
            ButtonStart.Enabled = false;
            ButtonStop.Enabled = false;
            ButtonPause.Text = "Unpause";

          
            var timerID = GridView1.DataKeys[0].Value.ToString();
           
            bool isPaused = ((System.Web.UI.WebControls.CheckBox) GridView1.Rows[0].Cells[1].Controls[0]).Checked;
          
            
            if (!isPaused) //Brukeren tar en pause
            {
                datePauseStart = DateTime.Now;
                Session["PauseStartDato"] = datePauseStart;

            

                SqlDataSourcePause.InsertParameters.Add("PauseStart", datePauseStart.ToString("u"));
                SqlDataSourcePause.InsertParameters.Add("ID", timerID);
       
                SqlDataSourcePause.Insert();

               SqlDataSourceTimer.UpdateParameters.Add("IsPaused", "1");   
              SqlDataSourceTimer.UpdateParameters.Add("ID", timerID);
   
               SqlDataSourceTimer.Update();

               Parameter p3 = SqlDataSourcePause.SelectParameters["ID"];
               SqlDataSourcePause.SelectParameters.Remove(p3);

               try
               {
                   SqlDataSourcePause.SelectParameters.Add("ID", timerID);
               }
               catch { }

                    GridView1.DataBind();
                   TimerGridView.DataBind();
              
            }
            else //Brukeren er ferdig med pausen
            {
               
                ButtonStop.Enabled = true;
                ButtonPause.Text = "Pause";

                DateTime dtStart;
               
                datePauseStop = DateTime.Now;
                datePauseStart = Convert.ToDateTime(Session["PauseStartDato"]);
                var pauseTS = datePauseStop.Subtract(datePauseStart);
                Label2.Text = pauseTS.ToString();
                Session["PauseTS"] = pauseTS;
                string pauseID = "";
                bool timeSpanIsValid=false;

         if (!String.IsNullOrEmpty(TimerGridView.Rows[0].Cells[1].Text))
                {
                    var pauseIDFromGV= TimerGridView.Rows[0].Cells[1].Text;
                    int pauseIDint;
                    //Sjekker etter injection samtidig som stringen blir parset og lagret i dt-referansen
                    if (int.TryParse(pauseIDFromGV, out pauseIDint))
                        pauseID = pauseIDFromGV;
                }
          


              // pauseSum += pauseTS;
               // UPDATE Pause SET PauseStop = @PauseStop, PauseSum = @PauseSum WHERE (Timer_ID = @ID) and (Pause.ID = @PauseID)
                SqlDataSourcePause.UpdateParameters.Add("PauseStop", datePauseStop.ToString("u"));
                SqlDataSourcePause.UpdateParameters.Add("PauseSum", pauseTS.ToString());

                SqlDataSourcePause.UpdateParameters.Add("ID", timerID);
                SqlDataSourcePause.UpdateParameters.Add("PauseID", pauseID);

                SqlDataSourcePause.Update();

                SqlDataSourceTimer.UpdateParameters.Add("IsPaused", "0");
                SqlDataSourceTimer.UpdateParameters.Add("ID", timerID);
                SqlDataSourceTimer.Update();


                Parameter p4 = SqlDataSourceTotalTidPause.SelectParameters["TimerID"];
                SqlDataSourceTotalTidPause.SelectParameters.Remove(p4);
                SqlDataSourceTotalTidPause.SelectParameters.Add("TimerID", timerID);

                GridView1.DataBind();
             
              
                      




               // GridView1.DataBind();
               // TimerGridView.DataBind();

          
               
            }
            

        }

        //@author Thea
        protected void ButtonStop_Click(object sender, EventArgs e)
        {
            ButtonStart.Enabled = true;
            dateStop = DateTime.Now;

           TimeSpan stopStartDelta = dateStop.Subtract(dateStart);

           TimeSpan TotalArbeidsTid =  stopStartDelta.Subtract(pauseTSFraDB);
              var dataKey = GridView1.DataKeys[0];
            if (dataKey != null)
            {
                var timerID = dataKey.Value.ToString();
                Parameter p = SqlDataSourceStop.SelectParameters["ID"];
                SqlDataSourceStop.SelectParameters.Remove(p);
                Parameter p2 = SqlDataSourceStop.SelectParameters["Slutt"];
                SqlDataSourceStop.SelectParameters.Remove(p2);


                SqlDataSourceStop.SelectParameters.Add("ID", timerID);
                SqlDataSourceStop.SelectParameters.Add("Slutt", dateStop.ToString("u"));
                var stopSelectArgs = new DataSourceSelectArguments();
                var stopDV = (DataView) SqlDataSourceStop.Select(stopSelectArgs);

                if (stopDV.Count != 0)
                {
                    string pauseSumFromSelect = stopDV[0][0].ToString();

                    

                    SqlDataSourceStop.UpdateParameters.Add("Slutt", dateStop.ToString("u"));
                    SqlDataSourceStop.UpdateParameters.Add("Totaltid", pauseSumFromSelect);
                    SqlDataSourceStop.UpdateParameters.Add("ID", timerID);
                    SqlDataSourceStop.Update();


                }
            }


            // UPDATE Timer SET Slutt = @Slutt WHERE ID = @ID

           // SqlDataSourceStop.UpdateParameters.Add("Slutt", dateStop.ToString("u"));
           // SqlDataSourceStop.UpdateParameters.Add("Totaltid", TotalArbeidsTid.ToString("g"));
           // SqlDataSourceStop.UpdateParameters.Add("ID", timerID);
            //SqlDataSourceStop.Update();
          
            GridView1.DataBind();
            
        
        }

        /**


       protected void TimerGridView0_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
           DateTime dtStart = new DateTime();
            DateTime dtStop = new DateTime(); 
           DateTime totalDT;
          
            TimeSpan totalTid=new TimeSpan();
           bool timeSpanIsValid=false;
           bool startDateIsValid=false;
           bool finishDateIsValid=false;
            //UPDATE Timer SET Start = @Start, Slutt = @Slutt, Totaltid = @Totaltid WHERE (ID = @ID)

      
               //Sjekker etter injection samtidig som stringen blir parset og lagret i dt-referansen
               startDateIsValid = DateTime.TryParseExact(
                        e.NewValues["Start"].ToString(), //Henter string fra tekstboks
                        "YYYY-MM-dd HH:mm:ss", //Formatet det skal ha
                        CultureInfo.InvariantCulture, //Ha'kke peiling
                        DateTimeStyles.None, //Null aning
                        out dtStart); //Lagrer det nye DateTime-objektet i dt


      


               finishDateIsValid = DateTime.TryParseExact(
              e.NewValues["Slutt"].ToString(), //Henter string fra tekstboks
              "YYYY-MM-dd HH:mm:ss", //Formatet det skal ha
              CultureInfo.InvariantCulture, //Ha'kke peiling
              DateTimeStyles.None, //Null aning
              out dtStop); //Lagrer det nye DateTime-objektet i dt
           
        

                timeSpanIsValid = TimeSpan.TryParseExact(
                      e.NewValues["Totaltid"].ToString(), //Henter string fra tekstboks
                      "c", CultureInfo.InvariantCulture, out totalTid);

 
          

           Label4.Text = "" + totalTid.ToString();

           if (startDateIsValid && finishDateIsValid && timeSpanIsValid)
           {

               GridViewRow row = (GridViewRow) GridView1.Rows[e.RowIndex];
               var id = GridView1.DataKeys[e.RowIndex].Value.ToString();
              
               DateTime derp = new DateTime();
               
               var totalTidDTString = dtStart.ToString("YYYY-MM-dd") + totalTid.ToString("g");


               Label4.Text = " Totaltidstring: " + Convert.ToDateTime(totalTidDTString);

               //    UPDATE Timer SET Start = @Start, Slutt = @Slutt, Totaltid = @Totaltid WHERE (ID = @ID)
              // SqlDataSourceRegistreringer.UpdateParameters.Add("ID", id);
             //  SqlDataSourceRegistreringer.UpdateParameters.Add("Start", dtStart.ToString("YYYY-MM-dd HH:mm:ss"));
               //SqlDataSourceRegistreringer.UpdateParameters.Add("Slutt", dtStop.ToString("YYYY-MM-dd HH:mm:ss"));
               //SqlDataSourceRegistreringer.UpdateParameters.Add("Totaltid", totalTidDTString);
               //SqlDataSourceRegistreringer.Update();
               //Label4.Text = "Updated with: IN: " + e.NewValues["Totaltid"].ToString() + "\n OUT:" +
                 //            totalTid.ToString();

           }
           else Label4.Text = "Valid timespan: " + timeSpanIsValid + "\n Valid finishDate: " + finishDateIsValid 
               + "\n Valid startDate: " + startDateIsValid;
        }

  
   
        */
    }
}