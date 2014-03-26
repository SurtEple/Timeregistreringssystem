using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace Timeregistreringssystem
{
    public partial class LeggTilBruker : System.Web.UI.Page
    {
        private DBConnect db;

        protected void Page_Load(object sender, EventArgs e)
        {
            db = new DBConnect();
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            //if (tbPassord.Equals(tbPassord2))
           // {
                db = new DBConnect();
                string brukernavn = tbBrukernavn.Text;
                string passord = tbPassord.Text;
                string passord2 = tbPassord2.Text;
                string fornavn = tbFornavn.Text;
                string mellomnavn = tbMellomnavn.Text;
                string etternavn = tbEtternavn.Text;
                string epost = tbEpost.Text;
                string im = tbIm.Text;
                string adresse = tbAdresse.Text;
                string postnr = tbPostnr.Text;
                string telefonnr = tbTelefonnr.Text;
                string by = tbBy.Text;

                db.InsertBruker(brukernavn, passord, fornavn, mellomnavn, etternavn, epost, im, adresse, postnr, telefonnr, by);
                //MessageBox.Show("Bruker lagt til");
           // }
        }

        protected void tbPassord2_TextChanged(object sender, EventArgs e)
        {
            if (!tbPassord.Equals(tbPassord2))
            {
                //MessageBox.Show("Passordene matcher ikke");
            }
        }




    }
}