using System;


namespace Timeregistreringssystem
{
    class Time
    {
        public Time(int id, String tidFra, String tidTil, String pause, String dato, String bruker,
            String oppgave, String kommentar, String sted, String aktiv)
        {
            Id = id;
            TidFra = tidFra;
            TidTil = tidTil;
            Pause = pause;
            Dato = dato;
            Bruker = bruker;
            Oppgave = oppgave;
            Kommentar = kommentar;
            Sted = sted;
            Aktiv = aktiv;
        }
        public int Id { get; set; }
        public String TidFra { get; set; }
        public String TidTil { get; set; }
        public String Pause { get; set; }
        public String Dato { get; set; }
        public String Bruker { get; set; }
        public String Oppgave { get; set; }
        public String Kommentar { get; set; }
        public String Sted { get; set; }
        public String Aktiv { get; set; }
    }
}
