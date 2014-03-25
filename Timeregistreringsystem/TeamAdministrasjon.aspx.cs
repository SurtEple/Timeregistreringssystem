using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Timeregistreringssystem
{
    public partial class TeamAdministrasjon : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DBConnect database = new DBConnect();
                List<Team> team = database.selectTeam();

                gridViewTeam.DataSource = team;
                gridViewTeam.DataBind();
            }
        }

        protected void gridViewTeam_SelectedIndexChanged(object sender, EventArgs e) { }

        protected void btnNyttTeam_Click(object sender, EventArgs e)
        {
            Response.Redirect("OpprettTeam.aspx", true);
        }

        protected void gridViewTeam_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                /* IKKE IMPLEMENTERT
                DBConnect database = new DBConnect();
                TableCell cell = gridViewTeam.Rows[e.RowIndex].Cells[1];
                int id = Convert.ToInt32(cell.Text.ToString());
                database.DeleteTeam(id);

                team.RemoveAt(e.RowIndex);
                gridViewTeam.DataSource = team;
                gridViewTeam.DataBind();  */
            }
            catch
            {
                e.Cancel = true;

            }
        }

        protected void gridViewTeam_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }
    }
}