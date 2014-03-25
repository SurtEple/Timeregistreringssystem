using System;


namespace Timeregistreringssystem
{
    class Fase
    {
        public Fase(int id, String navn,String datoStartet, String datoSluttet, String status,
            String beskrivelse, String prosjekt)
        {
            Id = id;
            Navn = navn;
            DatoSluttet = datoSluttet;
            DatoStartet = datoStartet;
            Status = status;
            Beskrivelse = beskrivelse;
            Prosjekt = prosjekt;
        }

        public int Id { get; set; }

        public string Navn { get; set; }

        public string DatoStartet { get; set; }

        public string DatoSluttet { get; set; }

        public string Status { get; set; }

        public string Beskrivelse { get; set; }

        public string Prosjekt { get; set; }
    }
}
