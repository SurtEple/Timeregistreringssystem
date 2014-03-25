using System;


namespace Timeregistreringssystem
{
    class Prosjekt
    {
        public Prosjekt(int id, String navn, String oppsummering, String nesteFase)
        {
            Id = id;
            Navn = navn;
            Oppsummering = oppsummering;
            NesteFase = nesteFase;
        }
        public int Id { get; set; }
        public String Navn { get; set; }
        public String Oppsummering { get; set; }
        public String NesteFase { get; set; }

    }
}
