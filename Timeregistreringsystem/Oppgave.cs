using System;


namespace Timeregistreringssystem
{
    class Oppgave
    {
        public Oppgave(int id, String prosjekt, String foreldreOppgave, double estimertTid,
            String tittel, String beskrivelse, String ferdig, double bruktTid, String datoBegynt,
            String datoFerdig)
        {
            Id = id;
            Prosjekt = prosjekt;
            ForeldreOppgave = foreldreOppgave;
            EstimertTid = estimertTid;
            Tittel = tittel;
            Beskrivelse = beskrivelse;
            Ferdig = ferdig;
            BruktTid = bruktTid;
            DatoBegynt = datoBegynt;
            DatoFerdig = datoFerdig;
        }
        public int Id { get; set; }
        public String Prosjekt { get; set; }
        public String ForeldreOppgave { get; set; }
        public double EstimertTid { get; set; }
        public String Tittel { get; set; }
        public String Beskrivelse { get; set; }
        public String Ferdig { get; set; }
        public double BruktTid { get; set; }
        public String DatoBegynt { get; set; }
        public String DatoFerdig { get; set; }
    }
}
