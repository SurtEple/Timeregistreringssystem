﻿using System;
using System.Collections.Generic;
using System.Linq;
using MySql.Data.MySqlClient;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.ComponentModel;
using System.Diagnostics;
using System.IO;
using System.Security.Cryptography;
using System.Text.RegularExpressions;

namespace Timeregistreringssystem
{


    class DBConnect
    {
        //variabler
        private MySqlConnection connection;
        private string server;
        private string database;
        private string uid;
        private string password;

        //Konstruktør
        public DBConnect()
        {
            Initialize();
        }


        #region connection
        //Initialiserer verdier og setter opp en kobling til databasen
        private void Initialize()
        {
            server = "kark.hin.no";
            database = "HLVDKN_DB1";
            uid = "halvardk";
            password = "halvardk123";
            string connectionString;
            connectionString = "SERVER=" + server + ";" + "DATABASE=" +
            database + ";" + "UID=" + uid + ";" + "PASSWORD=" + password + ";";

            connection = new MySqlConnection(connectionString);
        }

        //Metode som åpner tilkoblingen til databasen
        private bool OpenConnection()
        {
            try
            {
                connection.Open();
                return true;
            }
            catch (MySqlException ex)
            {
                //When handling errors, you can your application's response based 
                //on the error number.
                //The two most common error numbers when connecting are as follows:
                //0: Cannot connect to server.
                //1045: Invalid user name and/or password.
                switch (ex.Number)
                {
                    case 0:
                        MessageBox.Show("Cannot connect to server.  Contact administrator");
                        break;

                    case 1045:
                        MessageBox.Show("Invalid username/password, please try again");
                        break;
                }
                return false;
            }
        }

        //Metode som lukker tilkoblingen til databasen
        private bool CloseConnection()
        {
            try
            {
                connection.Close();
                return true;
            }
            catch (MySqlException ex)
            {
                MessageBox.Show(ex.Message);
                return false;
            }
        }
        
    

#endregion connection

        #region Prosjekt
        /**
        * Nytt prosjekt
        * @author Thomas & Thea
       */
        public void InsertProject(string navn, string oppsummering, int ansvarligID)
        {


            if (this.OpenConnection())
            {

                //Create Command
                String insertString = String.Format("INSERT INTO Prosjekt(Navn, Oppsummering, ansvarligID) VALUES ('{0}','{1}',{2})", navn, oppsummering, ansvarligID);
                MySqlCommand insertCommand = new MySqlCommand(insertString, connection);

                try
                {
                    insertCommand.ExecuteNonQuery();

                }
                catch (Exception e)
                {
                    Debug.WriteLine(e.Message);
                }
                finally
                {
                    //close Connection
                    this.CloseConnection();
                }

            }
        }

        /**
      * Slett prosjekt
      * @author Thomas & Thea
     */
        public bool delProject(int id)
        {
            String deleteString = String.Format("DELETE FROM Prosjekt WHERE ID = {0}", id);
            bool check = false;
            int result = 0;

            MySqlCommand deleteCommand = new MySqlCommand(deleteString, connection);

            if (this.OpenConnection())
            {
                try
                {
                    deleteCommand.Prepare(); //??
                    result = deleteCommand.ExecuteNonQuery();

                    check = true;
                }
                catch (Exception e)
                {
                    Debug.WriteLine(e.Message);
                    check = false;
                }
                finally
                {
                    if (result == 0)
                    {
                        deleteCommand.Cancel();
                        check = false;

                    }

                    //close Connection
                    this.CloseConnection();
                }

            }
            return check;
        }//Delete project



       /// <author>Thomas og Thea, Surt Eple</author> 
       /// <referenced inCode="EndreProsjekt.aspx.cs"></referenced>
       /// <referenced inSite="/Prosjektadmin/EndreProsjekt.aspx"></referenced>
       /// <summary>
       /// Redigere prosjekt, oppdaterer tabell Prosjekt
       /// </summary>
       /// <param name="id"></param>
       /// <param name="nyttNavn"></param>
       /// <param name="nyOppsummering"></param>
       /// <param name="nyNesteFase"></param>
       /// <param name="prosjektAnsvarlig"></param>
       /// <param name="nyMilepael"></param>
        public void EditProject(int id, string nyttNavn, string nyOppsummering, int nyNesteFase, int prosjektAnsvarlig, int nyMilepael)
        {
          
            if (this.OpenConnection())
            {
                //Create Command
                string editString = String.Format("UPDATE Prosjekt SET Navn = '{0}', Oppsummering = '{1}', Neste_Fase={2}, ansvarligID = {3}, Neste_Milepæl={4} WHERE ID = {5}",
                    nyttNavn, nyOppsummering, nyNesteFase, prosjektAnsvarlig, nyMilepael, id);

                MySqlCommand editCommand = new MySqlCommand(editString, connection);

                try
                {
                    editCommand.ExecuteNonQuery();
                }
                catch (Exception e)
                {
                    Debug.WriteLine(e.Message);
                }
                finally
                {
                    this.CloseConnection();
                }

            }
        }

        /**
       * Koble Team til Prosjekt
       * @author Thomas & Thea
       */
        public bool connectTeamToProject(int teamID, int prosjektID)
        {
            bool check = false;
            int result = 0;

            if (this.OpenConnection() == true)
            {

                //Create Command
                String connectString = String.Format("INSERT INTO KoblingTeamProsjekt(Team_ID, Prosjekt_ID) VALUES ({0}, {1}); ", teamID, prosjektID);

                MySqlCommand connectCommand = new MySqlCommand(connectString, connection);

                try
                {
                    connectCommand.Prepare(); //??
                    result = connectCommand.ExecuteNonQuery();
                    check = true;
                }
                catch (Exception e)
                {
                    Debug.WriteLine(e.Message);
                    check = false;
                }
                finally
                {
                    if (result == 0)
                    {
                        connectCommand.Cancel();
                        check = false;
                    }

                    //close Connection
                    this.CloseConnection();
                }

            }

            return check;
        }


        #endregion Prosjekt

        #region Milepæl


        /// <author>Thomas, Surt Eple</author> 
        /// <referenced inCode="LeggTilMilepael.aspx.cs"></referenced>
        /// <referenced inSite="/Prosjektadmin/LeggTilMilepael.aspx"></referenced>
        /// <summary>
        /// Legger til ny milepæl, setter inn i tabellen Milepael
        /// </summary>
        /// <param name="beskrivelse"></param>
        /// <param name="prosjektID"></param>
        internal void InsertMilepæl(string datoFerdig, int oppgaveID)
        {
            if (this.OpenConnection())
            {
                //Create Command
                string insertString = String.Format("INSERT INTO Milepæl (Dato_Ferdig, Oppgave_ID)" +
               " VALUES ('{0}', {1})", datoFerdig, oppgaveID);
                MySqlCommand insertCommand = new MySqlCommand(insertString, connection);

                try
                {
                    insertCommand.ExecuteNonQuery();
                }
                catch (System.ArgumentException ae) { Debug.WriteLine("Argument exception while trying to format the command string! " + ae.Message); }
                catch (System.FormatException fe) { Debug.WriteLine("Format exception while trying to format the command string!" + fe.Message); }
                catch (Exception e) { Debug.WriteLine("Undefined exception! " + e.Message); }

                finally
                {
                    //close Connection
                    this.CloseConnection();
                }
            }
        }


        /// <author>Thomas, Surt Eple</author> 
        /// <referenced inCode="LeggTilMilepael.aspx.cs"></referenced>
        /// <referenced inSite="/Prosjektadmin/LeggTilMilepael.aspx"></referenced>
        /// <summary>
        /// Legger til ny milepæl, setter inn i tabellen Milepael
        /// </summary>
        /// <param name="beskrivelse"></param>
        /// <param name="prosjektID"></param>
        public void InsertMilepael(string beskrivelse, int prosjektID)
        {
            if (this.OpenConnection())
            {
                //Create Command
                string insertString = String.Format("INSERT INTO Milepael (Beskrivelse, ProsjektID)" +
               " VALUES ('{0}', {1})", beskrivelse, prosjektID);
                MySqlCommand insertCommand = new MySqlCommand(insertString, connection);

                try
                {
                    insertCommand.ExecuteNonQuery();
                }
                catch (System.ArgumentException ae) { Debug.WriteLine("Argument exception while trying to format the command string! "+ ae.Message); }
                catch (System.FormatException fe) { Debug.WriteLine("Format exception while trying to format the command string!" + fe.Message); }
                catch (Exception e){Debug.WriteLine("Undefined exception! " + e.Message);}

                finally
                {
                    //close Connection
                    this.CloseConnection();
                }
            }

        }
        #endregion Milepæl

        #region Fase


        /// <author>Thea, Surt Eple</author> 
        /// <referenced inCode="LeggTilFase.aspx.cs"></referenced>
        /// <referenced inSite="/Prosjektadmin/LeggTilFase.aspx"></referenced>
        /// <summary>
        /// Setter inn en ny fase, oppdaterer tabellen Fase
        /// </summary>
        /// <param name="_navn"></param>
        /// <param name="_startDato"></param>
        /// <param name="_sluttDato"></param>
        /// <param name="_beskrivelse"></param>
        /// <param name="_prosjektID"></param>
        public void InsertFase(string _navn, string _startDato, string _sluttDato, string _beskrivelse, int _prosjektID)
        {

            if (this.OpenConnection())
            {
                //Create Command
                string insertString = String.Format("INSERT INTO Fase (Navn, Dato_Startet, Dato_sluttet,Prosjekt_ID, Beskrivelse)" +
               " VALUES ('{0}', '{1}', '{2}', {3}, '{4}'  )", _navn, _startDato, _sluttDato,  _prosjektID, _beskrivelse);
                MySqlCommand insertCommand = new MySqlCommand(insertString, connection);

                try
                {
                    insertCommand.ExecuteNonQuery();
                }
                catch (Exception e)
                {
                    Debug.WriteLine(e.Message);
                }
                finally
                {
                    //close Connection
                    this.CloseConnection();
                }
            }

        }
     
        /**
      * Slett fase
      * @author Thomas 
     */
        public bool delFase(int id)
        {
            String deleteString = String.Format("DELETE FROM Fase WHERE ID = {0}", id);
            bool check = false;
            int result = 0;

            MySqlCommand deleteCommand = new MySqlCommand(deleteString, connection);

            if (this.OpenConnection())
            {
                try
                {
                    deleteCommand.Prepare(); 
                    result = deleteCommand.ExecuteNonQuery();

                    check = true;
                }
                catch (Exception e)
                {
                    Debug.WriteLine(e.Message);
                    check = false;
                }
                finally
                {
                    if (result == 0)
                    {
                        deleteCommand.Cancel();
                        check = false;

                    }

                    //close Connection
                    this.CloseConnection();
                }

            }
            return check;
        }//Delete fase

       
        /**
      * Edit fase
      * @author Thomas
      */
        public void EditFase(int id, String nyttNavn, String nyBeskrivelse,bool isActive)
        {
            if (this.OpenConnection())
            {
                //Create Command
                String editString = String.Format(
                    "UPDATE Fase SET Navn = '{0}', Beskrivelse = '{1}', Aktiv = '{2}' WHERE ID = {3}"
                    , nyttNavn, nyBeskrivelse, isActive ? 1 : 0, id);

                MySqlCommand editCommand = new MySqlCommand(editString, connection);
                try
                {
                    editCommand.ExecuteNonQuery();
                   
                }
                catch (Exception e)
                {

                    Debug.WriteLine(e.Message);
                  
                }
                finally
                {
                    //close Connection
                    this.CloseConnection();
                }
            }
        }  //edit fase

        /**
         * Edit fase hente verdi til "Aktiv
         * author Thea
         */
        internal bool EditFaseHentAktiv(int id)
        {
            bool aktiv=false;

            if (this.OpenConnection())
            {
                //Create Command
                String editString = "SELECT Aktiv FROM Fase WHERE ID = " + id;

                MySqlCommand command = new MySqlCommand(editString, connection);
                try
                {
                   
                    MySqlDataReader dataReader = command.ExecuteReader();
                    while (dataReader.Read())
                    {
                        aktiv = Convert.ToBoolean(dataReader["Aktiv"]);
                    }
                    dataReader.Close();

                }
                catch (Exception e) { Debug.WriteLine(e.Message);}
                finally
                {
                    //close Connection  
                    this.CloseConnection();
                     
                }
               
            }
            return aktiv;
        }
        /**
      * Edit fase henting av Beskrivelse fra id
      * @author Thomas 
      */
        public string editFaseHentBeskrivelse(int id)
        {
            string beskrivelse ="ingen info";

            if (this.OpenConnection())
            {
                //Create Command
                string queryString = string.Format(
                    "SELECT Beskrivelse FROM Fase WHERE id = '{0}'"
                    , id);
                
                MySqlCommand command = new MySqlCommand(queryString, connection);
                try
                {
                   MySqlDataReader dataReader = command.ExecuteReader();
                    while (dataReader.Read())
                    {
                      beskrivelse = dataReader["Beskrivelse"] + "";
                    }
                    dataReader.Close();
                }
                catch (Exception e)
                {
                    Debug.WriteLine(e.Message);                  
                }
                finally
                {                  
                    //close Connection
                    this.CloseConnection();
                }
            }
            return beskrivelse;
        }  //edit fase hente beksrivelse fra id


        /**
    * Edit fase henting av Navn fra id
    * @author Thomas 
    */
        public string editFaseHentNavn(int id)
        {
            string navn = "ingen info";

            if (this.OpenConnection())
            {
                //Create Command
                string queryString = string.Format(
                    "SELECT Navn FROM Fase WHERE id = '{0}'"
                    , id);

                MySqlCommand command = new MySqlCommand(queryString, connection);
                try
                {
                    MySqlDataReader dataReader = command.ExecuteReader();
                    while (dataReader.Read())
                    {
                        navn = dataReader["Navn"] + "";
                    }
                }
                catch (Exception e)
                {
                    Debug.WriteLine(e.Message);
                }
                finally
                {
                    //close Connection
                    this.CloseConnection();
                }
            }
            return navn;
        }  //edit fase hente Navn fra id


#endregion Fase

        #region Oppgave

        /**
         * Legge til ny oppgave
         * @author Bjørn
         */
        public void InsertOppgave(int _foreldreProsjekt, int _foreldreOppgave, int _estimertTid, string _tittel, string _beskrivelse, string _startDato, string _sluttDato)
        {

            if (this.OpenConnection())
            {
                //Create Command
                string insertString = String.Format("INSERT INTO Oppgave (Prosjekt_ID, Foreldreoppgave_ID, EstimertTid, Tittel, Beskrivelse, Dato_begynt, Dato_ferdig)" +
               " VALUES ({0}, {1}, {2}, '{3}', '{4}', '{5}', '{6}'  )", _foreldreProsjekt, _foreldreOppgave, _estimertTid, _tittel, _beskrivelse, _startDato, _sluttDato);
                MySqlCommand insertCommand = new MySqlCommand(insertString, connection);

                try
                {
                    insertCommand.ExecuteNonQuery();
                }
                catch (Exception e)
                {
                    Debug.WriteLine(e.Message);
                }
                finally
                {
                    //close Connection
                    this.CloseConnection();
                }
            }

        }

        /**
        * Henter estimert sluttdato for den ferdige oppgaven fra databasen ved hjelp av id
        * @author Bjørn
        */
        public string ferdigOppgaveHentSluttDato(int id)
        {
            string navn = "ingen info";

            if (this.OpenConnection())
            {
                //Create Command
                string queryString = string.Format(
                    "SELECT Dato_ferdig FROM Oppgave WHERE id = '{0}'"
                    , id);

                MySqlCommand command = new MySqlCommand(queryString, connection);
                try
                {
                    MySqlDataReader dataReader = command.ExecuteReader();
                    while (dataReader.Read())
                    {
                        navn = dataReader["Dato_ferdig"] + "";
                    }
                }
                catch (Exception e)
                {
                    Debug.WriteLine(e.Message);
                }
                finally
                {
                    //close Connection
                    this.CloseConnection();
                }
            }
            return navn;
        }

        /**
        * Henter brukt tid for den ferdige oppgaven fra databasen ved hjelp av id
        * @author Bjørn
        */
        public string ferdigOppgaveHentBruktTid(int id)
        {
            string navn = "ingen info";

            if (this.OpenConnection())
            {
                //Create Command
                string queryString = string.Format(
                    "SELECT Brukt_tid FROM Oppgave WHERE id = '{0}'"
                    , id);

                MySqlCommand command = new MySqlCommand(queryString, connection);
                try
                {
                    MySqlDataReader dataReader = command.ExecuteReader();
                    while (dataReader.Read())
                    {
                        navn = dataReader["Brukt_tid"] + "";
                    }
                }
                catch (Exception e)
                {
                    Debug.WriteLine(e.Message);
                }
                finally
                {
                    //close Connection
                    this.CloseConnection();
                }
            }
            return navn;
        }

        /**
         * Sette oppgave til å være ferdig
         * @author Bjørn
         */
        public void OppgaveFerdig(int id, int _bruktTid, string _sluttDato)
        {

            if (this.OpenConnection())
            {
                //Create Command
                string editString = String.Format("UPDATE Oppgave SET Ferdig = 1, Brukt_tid = {0}, Dato_ferdig = '{1}' WHERE ID = {2}",
                   _bruktTid, _sluttDato, id);

                MySqlCommand editCommand = new MySqlCommand(editString, connection);


                try
                {
                    editCommand.ExecuteNonQuery();
                }
                catch (Exception e)
                {
                    Debug.WriteLine(e.Message);
                }
                finally
                {
                    //close Connection
                    this.CloseConnection();
                }
            }

        }

         /**
         * Slett oppgave
         * @author Bjørn
        */
        public bool slettOppgave(int id)
        {
            String deleteString = String.Format("DELETE FROM Oppgave WHERE ID = {0}", id);
            bool check = false;
            int result = 0;

            MySqlCommand deleteCommand = new MySqlCommand(deleteString, connection);

            if (this.OpenConnection())
            {
                try
                {
                    deleteCommand.Prepare();
                    result = deleteCommand.ExecuteNonQuery();

                    check = true;
                }
                catch (Exception e)
                {
                    Debug.WriteLine(e.Message);
                    check = false;
                }
                finally
                {
                    //close Connection
                    this.CloseConnection();
                }

            }
            return check;
        }

        /**
        * Henter beskrivelse av oppgave fra databasen ved hjelp av id
        * @author Bjørn
        */
        public string editOppgaveHentBeskrivelse(int id)
        {
            string beskrivelse = "ingen info";

            if (this.OpenConnection())
            {
                //Create Command
                string queryString = string.Format(
                    "SELECT Beskrivelse FROM Oppgave WHERE id = '{0}'"
                    , id);

                MySqlCommand command = new MySqlCommand(queryString, connection);
                try
                {
                    MySqlDataReader dataReader = command.ExecuteReader();
                    while (dataReader.Read())
                    {
                        beskrivelse = dataReader["Beskrivelse"] + "";
                    }
                }
                catch (Exception e)
                {
                    Debug.WriteLine(e.Message);
                }
                finally
                {
                    //close Connection
                    this.CloseConnection();
                }
            }
            return beskrivelse;
        }

        /**
       * Henter tittel fra databasen ved hjelp av id
       * @author Bjørn
       */
        public string editOppgaveHentTittel(int id)
        {
            string navn = "ingen info";

            if (this.OpenConnection())
            {
                //Create Command
                string queryString = string.Format(
                    "SELECT Tittel FROM Oppgave WHERE id = '{0}'"
                    , id);

                MySqlCommand command = new MySqlCommand(queryString, connection);
                try
                {
                    MySqlDataReader dataReader = command.ExecuteReader();
                    while (dataReader.Read())
                    {
                        navn = dataReader["Tittel"] + "";
                    }
                }
                catch (Exception e)
                {
                    Debug.WriteLine(e.Message);
                }
                finally
                {
                    //close Connection
                    this.CloseConnection();
                }
            }
            return navn;
        }

        /**
       * Henter estimert tid fra databasen ved hjelp av id
       * @author Bjørn
       */
        public string editOppgaveHentEstimertTid(int id)
        {
            string navn = "ingen info";

            if (this.OpenConnection())
            {
                //Create Command
                string queryString = string.Format(
                    "SELECT EstimertTid FROM Oppgave WHERE id = '{0}'"
                    , id);

                MySqlCommand command = new MySqlCommand(queryString, connection);
                try
                {
                    MySqlDataReader dataReader = command.ExecuteReader();
                    while (dataReader.Read())
                    {
                        navn = dataReader["EstimertTid"] + "";
                    }
                }
                catch (Exception e)
                {
                    Debug.WriteLine(e.Message);
                }
                finally
                {
                    //close Connection
                    this.CloseConnection();
                }
            }
            return navn;
        }

        /**
       * Henter brukt tid fra databasen ved hjelp av id
       * @author Bjørn
       */
        public string editOppgaveHentBruktTid(int id)
        {
            string navn = "ingen info";

            if (this.OpenConnection())
            {
                //Create Command
                string queryString = string.Format(
                    "SELECT Brukt_tid FROM Oppgave WHERE id = '{0}'"
                    , id);

                MySqlCommand command = new MySqlCommand(queryString, connection);
                try
                {
                    MySqlDataReader dataReader = command.ExecuteReader();
                    while (dataReader.Read())
                    {
                        navn = dataReader["Brukt_tid"] + "";
                    }
                }
                catch (Exception e)
                {
                    Debug.WriteLine(e.Message);
                }
                finally
                {
                    //close Connection
                    this.CloseConnection();
                }
            }
            return navn;
        }

        /**
        * Henter sluttdato fra databasen ved hjelp av id
        * @author Bjørn
        */
        public string editOppgaveHentSluttDato(int id)
        {
            string navn = "ingen info";

            if (this.OpenConnection())
            {
                //Create Command
                string queryString = string.Format(
                    "SELECT Dato_ferdig FROM Oppgave WHERE id = '{0}'"
                    , id);

                MySqlCommand command = new MySqlCommand(queryString, connection);
                try
                {
                    MySqlDataReader dataReader = command.ExecuteReader();
                    while (dataReader.Read())
                    {
                        navn = dataReader["Dato_ferdig"] + "";
                    }
                }
                catch (Exception e)
                {
                    Debug.WriteLine(e.Message);
                }
                finally
                {
                    //close Connection
                    this.CloseConnection();
                }
            }
            return navn;
        }

        /**
     * Oppdater Oppgave
     * @author Bjørn
     */
        public bool OppdaterOppgave(int _id, string _nyTittel, string _nyBeskrivelse, string _nySluttDato, int _nyEstimertTid, int _nyBruktTid)
        {
            bool check = false;
            int result = 0;

            if (this.OpenConnection())
            {
                //Create Command
                String editString = String.Format(
                    "UPDATE Oppgave SET Tittel = '{0}', Beskrivelse = '{1}', Dato_ferdig = '{2}', EstimertTid = {3}, Brukt_tid = {4} WHERE ID = {5}"
                    , _nyTittel, _nyBeskrivelse, _nySluttDato, _nyEstimertTid, _nyBruktTid, _id);

                MySqlCommand editCommand = new MySqlCommand(editString, connection);
                try
                {
                    editCommand.Prepare();
                    result = editCommand.ExecuteNonQuery();
                    check = true;
                }
                catch (Exception e)
                {

                    Debug.WriteLine(e.Message);
                    check = false;
                }
                finally
                {

                    //close Connection
                    this.CloseConnection();
                }
            }
            return check;
        } 
        #endregion Oppgave

        #region hashOgSalt
        /**
         * Salt-generator
         * @author Halvard
         */
        public static string GenerateSalt()
        {
            string salt = Path.GetRandomFileName();
            salt = salt.Replace(".", ""); //Fjerner punktum
            return salt;
        }

        /**
         * Hash-generering
         * @author Martin
         */
        public static byte[] GetHash(string inputString)
        {
            HashAlgorithm algorithm = MD5.Create();  // SHA1.Create()
            return algorithm.ComputeHash(Encoding.UTF8.GetBytes(inputString));
        }

        /**
         * Hash-generering
         * @author Martin
         */
        public static string GetHashString(string inputString)
        {
            StringBuilder sb = new StringBuilder();
            foreach (byte b in GetHash(inputString))
                sb.Append(b.ToString("x2"));

            return sb.ToString();
        }

        #endregion hashOgSalt


        #region BrukerAdmin

        /**
        * Legge inn ny bruker
        * @author Halvard
        */
        public void InsertBruker(string _brukernavn, string _passord, string _fornavn, string _mellomnavn, string _etternavn, string _epost, string _im, string _adresse, string _postnr, string _telefonnr, string _by)
        {
            int result = 0;
            string _salt = GenerateSalt();
            string passord = GetHashString(_salt + _passord);

            if (this.OpenConnection() == true)
            {
                string insertBrukerQuery = String.Format("INSERT INTO Bruker (`ID`, `Brukernavn`, `Passord`, `Salt`, `Fornavn`, `Mellomnavn`, `Etternavn`, `Epost`, `IM`, `Telefonnr`, `Adresse`, `Postnummer`, `By`, `Stilling_ID`, `Administrator`) VALUES (NULL, '{0}', '{1}', '{2}', '{3}', '{4}', '{5}', '{6}', '{7}', '{8}', '{9}', '{10}', '{11}', NULL, '0')", _brukernavn, passord, _salt, _fornavn, _mellomnavn, _etternavn, _epost, _im, _telefonnr, _adresse, _postnr, _by);
                // string insertBrukerQuery = String.Format("INSERT INTO `HLVDKN_DB1`.`Bruker` (`ID`, `Brukernavn`, `Passord`, `Salt`, `Fornavn`, `Mellomnavn`, `Etternavn`, `Epost`, `IM`, `Telefonnr`, `Adresse`, `Postnummer`, `By`, `Stilling_ID`, `Administrator`) VALUES (NULL, '{0}', '{1}', '{2}', 'salt', '{3}', '{4}', '{5}', '{6}', '{7}', '{8}', '{9}', '{10}', NULL, NULL)", _brukernavn, _passord,  _fornavn, _mellomnavn, _etternavn, _epost, _im, _adresse, _postnr, _telefonnr, _by);

                MySqlCommand insertBrukerCommand = new MySqlCommand(insertBrukerQuery, connection);

                try
                {
                    insertBrukerCommand.Prepare();
                    result = insertBrukerCommand.ExecuteNonQuery();
                }
                catch (Exception e)
                {

                    Debug.WriteLine(e.Message);
                }
                finally
                {
                    if (result == 0)
                    {
                        insertBrukerCommand.Cancel();

                    }

                    //close Connection
                    this.CloseConnection();
                }

            }
        }

        /**
         * Redigere bruker
         * @author Halvard
         */
        public void updateBruker(int _id, string _passord, string _epost, string _im, string _adresse, string _postnr, string _telefonnr, string _by)
        {
            int result = 0;

            if (this.OpenConnection() == true)
            {
                String editBrukerQuery = String.Format("UPDATE Bruker SET Passord = '{0}', Epost = '{1}', IM = '{2}', Adresse = '{3}', Postnummer = '{4}', Telefonnr = '{5}', By = '{6}' WHERE ID = '{7}'", _passord, _epost, _im, _adresse, _postnr, _telefonnr, _by, _id);

                //String editBrukerQuery = String.Format("UPDATE Bruker SET Brukernavn = '{0}', Passord = '{1}', Salt = '" + GenerateSalt() + "', Fornavn ='{2}', Mellomnavn = '{3}', Etternavn = '{4}', Epost = '{5}', IM = '{6}', Telefonnr = '{7}', Adresse = '{8}', Postnummer = '{9}', By = '{10}'  WHERE ID = {11}",
                //  _brukernavn, _passord, _fornavn, _mellomnavn, _etternavn, _epost, _im, _telefonnr, _adresse, _postnr, _by, _id);

                MySqlCommand editBrukerCommand = new MySqlCommand(editBrukerQuery, connection);

                try
                {

                    editBrukerCommand.Prepare();
                    result = editBrukerCommand.ExecuteNonQuery();
                }
                catch (Exception e)
                {

                    Debug.WriteLine(e.Message);
                }
                finally
                {
                    if (result == 0)
                    {
                        editBrukerCommand.Cancel();
                    }

                    //close Connection
                    this.CloseConnection();
                }

            }

        }

        /**
         * Slette bruker
         * @author Halvard
         */
        public void DelBruker(int _id)
        {
            String deleteString = String.Format("DELETE FROM Bruker WHERE ID = {0}", _id);
            int result = 0;

            MySqlCommand deleteBrukerCommand = new MySqlCommand(deleteString, connection);

            if (this.OpenConnection() == true)
            {
                try
                {
                    deleteBrukerCommand.Prepare();
                    result = deleteBrukerCommand.ExecuteNonQuery();

                }
                catch (Exception e)
                {
                    Debug.WriteLine(e.Message);
                }
                finally
                {
                    if (result == 0)
                    {
                        deleteBrukerCommand.Cancel();

                    }

                    //close Connection
                    this.CloseConnection();
                }

            }
        }

        #endregion BrukerAdmin

        #region TeamAdmin

        /**
         * Sette team-leder
         * @author Bjørn
         */
        public bool setTeamLeder(int id)
        {
            bool check = false;
            int result = 0;

            // Åpner tilkoblingen til databasen
            if (this.OpenConnection() == true)
            {

                // Kommando for å oppdatere valgt bruker til Stilling_ID 4 - leder
                String oppdatering = String.Format("UPDATE Bruker SET Stilling_ID = 4 WHERE ID = {0}",
                    id);

                MySqlCommand oppdateringsCommand = new MySqlCommand(oppdatering, connection);

                try
                {
                    oppdateringsCommand.Prepare();
                    result = oppdateringsCommand.ExecuteNonQuery();
                    check = true;
                }
                catch (Exception e)
                {
                    Debug.WriteLine(e.Message);
                    check = false;
                }
                finally
                {
                    if (result == 0)
                    {
                        oppdateringsCommand.Cancel();
                        check = false;
                    }

                    // Lukker tilkoblingen
                    this.CloseConnection();
                }
            }
            return check;
        }



        /**
        * Legger til nytt team
        * @author Kristina
        */
        public bool InsertTeam(Team t)
        {
            bool check = false;

            if (this.OpenConnection() == true)
            {
                try
                {
                    MySqlCommand command = new MySqlCommand(null, connection);

                    // Create and prepare an SQL statement
                    command.CommandText =
                        "INSERT INTO Team (ID, Teamleder, Beskrivelse) " +
                        "VALUES (@id, @teamleder, @beskrivelse)";

                    MySqlParameter idParam = new MySqlParameter("@id", MySqlDbType.Int32, 11);
                    MySqlParameter teamlederParam = new MySqlParameter("@teamleder", MySqlDbType.Int32, 11);
                    MySqlParameter beskrivelseParam = new MySqlParameter("@beskrivelse", MySqlDbType.Text);

                    idParam.Value = t.Id;
                    beskrivelseParam.Value = t.Beskrivelse;
                    teamlederParam.Value = t.TeamLederId;

                    command.Parameters.Add(idParam);
                    command.Parameters.Add(teamlederParam);
                    command.Parameters.Add(beskrivelseParam);

                    command.Prepare();
                    command.ExecuteNonQuery();
                    check = true;
                }
                catch
                {
                    check = false;
                }
                finally
                {
                    this.CloseConnection();
                }
            }

            return check;
        }

        /**
        * Kobler en bruker til et team
        * @author Kristina
        */
        public bool KoblingBrukerTeam(int teamId, int brukerId)
        {
            bool check = false;

            if (this.OpenConnection() == true)
            {
                try
                {
                    MySqlCommand command = new MySqlCommand(null, connection);

                    // Create and prepare an SQL statement
                    command.CommandText =
                        "INSERT INTO KoblingBrukerTeam (Bruker_ID, Team_ID) " +
                        "VALUES (@bruker, @team)";

                    MySqlParameter brukerParam = new MySqlParameter("@bruker", MySqlDbType.Int32, 11);
                    MySqlParameter teamParam = new MySqlParameter("@team", MySqlDbType.Int32, 11);

                    brukerParam.Value = brukerId;
                    teamParam.Value = teamId;

                    command.Parameters.Add(brukerParam);
                    command.Parameters.Add(teamParam);

                    command.Prepare();
                    command.ExecuteNonQuery();
                    check = true;
                }
                catch
                {
                    check = false;
                }
                finally
                {
                    this.CloseConnection();
                }
            }

            return check;
        }

        /**
        * Sletter team med gitt id
        * @author Kristina
        */
        public bool DeleteTeam(int id)
        {
            String deleteString = String.Format("DELETE FROM Team WHERE ID = {0}", id);
            bool check = false;
            int result = 0;

            MySqlCommand deleteCommand = new MySqlCommand(deleteString, connection);

            if (this.OpenConnection() == true)
            {
                try
                {
                    deleteCommand.Prepare();
                    deleteCommand.ExecuteNonQuery();
                    check = true;
                }
                catch (Exception e)
                {
                    Debug.WriteLine(e.Message);
                    check = false;
                }
                finally
                {
                    if (result == 0)
                    {
                        deleteCommand.Cancel();
                        check = false;
                    }
                    //close Connection
                    this.CloseConnection();
                }
            }
            return check;
        }




        /**
         * SelectTeam 
         * @author Martin
         */
        public List<Team> selectTeam()
        {
            List<Team> list = new List<Team>();
            string query = "SELECT `Team`.`ID` `Team_ID`, `Bruker`.`ID` `Bruker_ID`, `Bruker`.`Fornavn`, `Bruker`.`Mellomnavn`, `Bruker`.`Etternavn`, `Team`.`Beskrivelse` FROM Team, Bruker "
                    + "WHERE Team.Teamleder = Bruker.ID";
            if (this.OpenConnection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, connection);
                MySqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    int id = Convert.ToInt32(dr["Team_ID"]);
                    int teamLedId = Convert.ToInt32(dr["Bruker_ID"]);
                    string teamLeder = dr["Fornavn"] + " " + dr["Mellomnavn"] + " " + dr["Etternavn"];
                    teamLeder = Regex.Replace(teamLeder, @"\s+", " ");
                    string beskrivelse = dr["Beskrivelse"] + "";
                    list.Add(new Team(id, teamLedId, teamLeder, beskrivelse));

                }
                dr.Close();
                this.CloseConnection();
                return list;
            }
            else
                return list;
        }

        #endregion TeamAdmin

        #region Innlogging

        /**
         * Sjekk innlogging
         * @author Martin
         */
        public int[] CheckInnlogging(String brukernavn, String passord)
        {
            //bool check = false;
            int[] i = new int[2];
            i[0] = -1;
            string salt = null;
            if (this.OpenConnection() == true)
            {
                string query1 = "SELECT Salt FROM Bruker WHERE Brukernavn like " + "'" + brukernavn + "'";
                MySqlCommand cmd = new MySqlCommand(query1, connection);
                MySqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    salt = dr["Salt"] + "";
                }
                dr.Close();

                string passWord = GetHashString(salt + passord);

                string query2 = "SELECT * FROM Bruker WHERE Passord = " + "'" + passWord + "'";
                MySqlCommand cmd2 = new MySqlCommand(query2, connection);
                MySqlDataReader dr2 = cmd2.ExecuteReader();
                while (dr2.Read())
                {
                    i[0] = Convert.ToInt32(dr2["Administrator"]);
                    i[1] = Convert.ToInt32(dr2["ID"]);

                }
                dr2.Close();
                this.CloseConnection();
                return i;

            }
            else
                return i;
        }

//Metode for å hente ut alle brukerene og legge de til en bindinglist
        public BindingList<Bruker> brukerSelect()
        {
            string query = "SELECT * FROM Bruker";

            BindingList<Bruker> blBrukerListe = new BindingList<Bruker>();

            //Open connection
            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();

                //Read the data and store them in the list
                while (dataReader.Read())
                {

                    int bruker_id = (int)dataReader["ID"];
                    string bruker_brukernavn = (string)dataReader["Brukernavn"];
                    string bruker_passord = (string)dataReader["Passord"];
                    string bruker_fornavn = (string)dataReader["Fornavn"];
                    string bruker_mellomnavn = (string)dataReader["Mellomnavn"];
                    string bruker_etternavn = (string)dataReader["Etternavn"];
                    string bruker_epost = (string)dataReader["Epost"];
                    string bruker_im = (string)dataReader["IM"];
                    int tmp_telefonnr = (int)dataReader["Telefonnr"];
                    string bruker_telefonnr = Convert.ToString(tmp_telefonnr);
                    string bruker_adresse = (string)dataReader["Adresse"];
                    int tmp_postnr = (int)dataReader["Postnummer"];
                    string bruker_postnr = Convert.ToString(tmp_postnr);
                    string bruker_by = (string)dataReader["By"];


                    Bruker bruker = new Bruker(bruker_id, bruker_brukernavn, bruker_passord, bruker_fornavn, bruker_mellomnavn, bruker_etternavn, bruker_epost, bruker_im, bruker_adresse, bruker_postnr, bruker_telefonnr, bruker_by);
                    blBrukerListe.Add(bruker);
                }

                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();

                //return list to be displayed
                return blBrukerListe;
            }
            else
            {
                return blBrukerListe;
            }


        #endregion Innlogging




        }

       
    }
}
