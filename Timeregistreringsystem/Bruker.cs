//Dette er halvard som tester

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

// Testy testy, give us smooth, give us silky.

namespace Timeregistreringssystem
{
    class Bruker
    {
        //Variabler
        private int id;
        private string brukernavn;
        private string passord;
        private string fornavn;
        private string mellomnavn;
        private string etternavn;
        private string epost;
        private string im;
        private string adresse;
        private string postnr;
        private string telefonnr;
        private string by;
        private int rettigheter;

        //Konstruktør
        public Bruker(int _id, string _brukernavn, string _fornavn, string _mellomnavn, string _etternavn, string _epost, string _im, string _adresse, string _postnr, string _telefonnr, string _by, int _rettigheter)
        {
            id = _id;
            brukernavn = _brukernavn;
            fornavn = _fornavn;
            mellomnavn = _mellomnavn;
            etternavn = _etternavn;
            epost = _epost;
            im = _im;
            adresse = _adresse;
            postnr = _postnr;
            telefonnr = _telefonnr;
            by = _by;
            rettigheter = _rettigheter;
        }

        public int Id
        {
            get { return id; }
            set { id = value; }
        }

        public string Brukernavn
        {
            get { return brukernavn; }
            set { brukernavn = value; }
        }
        public string Fornavn
        {
            get { return fornavn; }
            set { fornavn = value; }
        }

        public string Mellomnavn
        {
            get { return mellomnavn; }
            set { mellomnavn = value; }
        }

        public string Etternavn
        {
            get { return etternavn; }
            set { etternavn = value; }
        }

        public string Epost
        {
            get { return epost; }
            set { epost = value; }
        }

        public string Im
        {
            get { return im; }
            set { im = value; }
        }

        public string Adresse
        {
            get { return adresse; }
            set { adresse = value; }
        }

        public string Postnr
        {
            get { return postnr; }
            set { postnr = value; }
        }

        public string Telefonnr
        {
            get { return telefonnr; }
            set { telefonnr = value; }
        }
        public int Rettigheter
        {
            get { return rettigheter; }
            set { rettigheter = value; }
        }

    }
}
