using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

/*
 * @Author Thomas
 * 2014 April
 * */

namespace Timeregistreringssystem.BrukerAdministrasjon
{
    public partial class TimeRegistrering : Page
    {
        //   private double timeElapsed = 0.0;

        private DateTime dateStart;
        private DateTime dateStop;
        private DateTime datePauseStart;
        private DateTime datePauseStop;
        //private bool isPaused;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] != null)
            {
                if (Session["OppgaveID"] != null)
                {

                    var userID = (int) Session["Admin"];
                    if ((userID == Rettigheter.VANLIG_BRUKER || userID == Rettigheter.PROSJEKT_ANSVARLIG
                         || userID == Rettigheter.ADMINISTRATOR || userID == Rettigheter.TEAMLEDER) && Global.CheckIP())
                    {
                        Parameter p = SqlDataSourceRegistreringer.SelectParameters["BrukerID"];
                        SqlDataSourceRegistreringer.SelectParameters.Remove(p);
                        SqlDataSourceRegistreringer.SelectParameters.Add("BrukerID", Session["BrukerID"].ToString());

                        p = SqlDataSource4.SelectParameters["BrukerID"];
                        SqlDataSource4.SelectParameters.Remove(p);
                        SqlDataSource4.SelectParameters.Add("BrukerID", Session["BrukerID"].ToString());
                    }
                    else
                    {
                        Response.Redirect("~/Default.aspx");
                    }
                }
                else
                {
                    Response.Redirect("~/Startside/BrukerForside.aspx");
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

            int OppgaveId = 0;
            dateStart = DateTime.Now;
            LabelStart.Text = "Du startet kl " + dateStart.TimeOfDay;

            Session["StartDato"] = dateStart;

            if (Session["OppgaveID"] != null)
            {
                OppgaveId = (int) Session["OppgaveID"];
            }

            var BrukerID = (int) Session["BrukerID"];
            SqlDataSourceTimer.InsertParameters.Add("Start", dateStart.ToString("u"));
            SqlDataSourceTimer.InsertParameters.Add("OppgaveID", OppgaveId.ToString());
            SqlDataSourceTimer.InsertParameters.Add("BrukerID", BrukerID.ToString());
            SqlDataSourceTimer.Insert();


            TimerGridView.DataBind();

            TimerGridView0.DataBind();
            GridView1.DataBind();
            GridView2.Dispose();
            GridView2.DataBind();
        }

        protected void ButtonPause_Click(object sender, EventArgs e)
        {
            ButtonStop.Enabled = false;
            ButtonPause.Text = "Unpause";


            string timerID = GridView1.DataKeys[0].Value.ToString();

            bool isPaused = ((CheckBox) GridView1.Rows[0].Cells[1].Controls[0]).Checked;


            if (!isPaused) //Brukeren tar en pause
            {
                datePauseStart = DateTime.Now;
                LabelPause.Text = "Du tok en pause kl: " + datePauseStart.TimeOfDay;
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
                catch
                {
                }

                GridView1.DataBind();
                
                GridView2.DataBind();
                TimerGridView.DataBind();
            }
            else //Brukeren er ferdig med pausen
            {
                ButtonStop.Enabled = true;
                ButtonPause.Text = "Pause";
                LabelPause.Text = "";


                datePauseStop = DateTime.Now;
                datePauseStart = Convert.ToDateTime(Session["PauseStartDato"]);
                TimeSpan pauseTS = datePauseStop.Subtract(datePauseStart);

                Session["PauseTS"] = pauseTS;
                string pauseID = "";
                // bool timeSpanIsValid=false;

                if (!String.IsNullOrEmpty(TimerGridView.Rows[0].Cells[1].Text))
                {
                    string pauseIDFromGV = TimerGridView.Rows[0].Cells[1].Text;
                    int pauseIDint;
                    //Sjekker etter injection samtidig som stringen blir parset og lagret i dt-referansen
                    if (int.TryParse(pauseIDFromGV, out pauseIDint))
                        pauseID = pauseIDFromGV;
                }

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
                GridView1.Visible = false;

                GridView2.DataBind();
                TimerGridView.DataBind();
            }
        }

        //@author Thea
        protected void ButtonStop_Click(object sender, EventArgs e)
        {
            ButtonStart.Enabled = true;
            dateStop = DateTime.Now;
            ButtonStop.Enabled = false;
            ButtonPause.Enabled = false;
            LabelStart.Text = "";
            LabelPause.Text = "";

            string pauseSumFromSelect = "";

            DataKey dataKey = GridView1.DataKeys[0];
            if (dataKey != null)
            {
                string timerID = dataKey.Value.ToString();
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
                    pauseSumFromSelect = stopDV[0][0].ToString();
                    SqlDataSourceStop.UpdateParameters.Add("Slutt", dateStop.ToString("u"));
                    SqlDataSourceStop.UpdateParameters.Add("Totaltid", pauseSumFromSelect);
                    SqlDataSourceStop.UpdateParameters.Add("ID", timerID);
                    SqlDataSourceStop.Update();
                }

                Parameter pderp = SqlDataSourceHenteArbeidstid.SelectParameters["ID"];
                SqlDataSourceHenteArbeidstid.SelectParameters.Remove(pderp);
                SqlDataSourceHenteArbeidstid.SelectParameters.Add("ID", timerID);
                var timerSelectArgs = new DataSourceSelectArguments();
                var timerDV = (DataView) SqlDataSourceHenteArbeidstid.Select(timerSelectArgs);

                if (timerDV.Count != 0)
                {
                    string totalArbeidsTidFromSelect = timerDV[0][0].ToString();

                    if (totalArbeidsTidFromSelect.Equals("00:00:00") || String.IsNullOrEmpty(totalArbeidsTidFromSelect))
                        totalArbeidsTidFromSelect = pauseSumFromSelect;

                    SqlDataSourceHenteArbeidstid.UpdateParameters.Add("TotalArbeidsTid", totalArbeidsTidFromSelect);
                    SqlDataSourceHenteArbeidstid.UpdateParameters.Add("ID", timerID);
                    SqlDataSourceHenteArbeidstid.Update();
                }
            }


            GridView2.DataBind();
            TimerGridView.DataBind();
            TimerGridView0.DataBind();
            GridView1.DataBind();
            GridView1.Visible = false;
        }
    }
}