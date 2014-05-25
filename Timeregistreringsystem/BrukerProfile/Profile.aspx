<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Timeregistreringssystem.BrukerProfile.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!--Datasource som sender spørring til databasen om team til bruker-->
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT concat(b.Fornavn,space(1), b.Etternavn) Teamleder, Beskrivelse TeamNavn, group_concat(DISTINCT b.Fornavn,space(1), b.Etternavn ORDER BY b.Fornavn DESC SEPARATOR ', ') TeamMedlemmer
FROM Team t
INNER JOIN KoblingBrukerTeam bt on t.ID = bt.Team_ID
INNER JOIN Bruker b ON bt.Bruker_ID = b.ID
WHERE t.ID IN (SELECT Team_ID FROM KoblingBrukerTeam Where Bruker_ID = @brukerID)
GROUP BY t.id, t.Beskrivelse">
  <SelectParameters>
    <asp:Parameter Name="@brukerID" Type="Int32" DefaultValue="0" />
  </SelectParameters>
    </asp:SqlDataSource>

    <!--Gridview som viser team brukeren er i-->
    <p>&nbsp;</p>
    <h2>Team</h2>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Height="129px" Width="1037px">
        <Columns>
            <asp:BoundField DataField="Teamleder" HeaderText="Teamleder" SortExpression="Teamleder" />
            <asp:BoundField DataField="TeamNavn" HeaderText="Team Navn" SortExpression="TeamNavn" />
            <asp:BoundField DataField="TeamMedlemmer" HeaderText="Team Medlemmer" SortExpression="TeamMedlemmer" />
        </Columns>
    </asp:GridView>
    
    <br />
    <!--Datasource som henter prosjekter til team brukeren er med i-->
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT p.Navn, p.Oppsummering, group_concat(DISTINCT t.Beskrivelse ORDER BY t.Beskrivelse DESC SEPARATOR ', ') Team
FROM Prosjekt p
INNER JOIN KoblingTeamProsjekt tp on p.ID = tp.Prosjekt_ID
INNER JOIN Team t ON tp.Team_ID = t.ID
WHERE p.ID IN (SELECT Prosjekt_ID FROM KoblingTeamProsjekt tp Where tp.Team_ID IN (SELECT bt.Team_ID FROM KoblingBrukerTeam bt WHERE Bruker_ID = @brukerID))
GROUP BY p.id">
   <SelectParameters>
    <asp:Parameter Name="@brukerID" Type="Int32" DefaultValue="0" />
  </SelectParameters>
    </asp:SqlDataSource>
    <p>&nbsp;</p>
    <h2>Prosjekter</h2>
    <!--GridView somviser prosjekter brukeren har tilknyttning til-->
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" Height="129px" Width="1037px">
        <Columns>
            <asp:BoundField DataField="Navn" HeaderText="Navn" SortExpression="Navn" />
            <asp:BoundField DataField="Oppsummering" HeaderText="Oppsummering" SortExpression="Oppsummering" />
            <asp:BoundField DataField="Team" HeaderText="Team" SortExpression="Team" />
        </Columns>
    </asp:GridView>
    
    <br />
    <!--Datasource som henter ut oppgaver som er knyttet til prosjektet-->
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT p.Navn, co.Tittel, o.EstimertTid, o.Tittel, o.Beskrivelse,o.Ferdig, o.Brukt_tid, o.Dato_begynt, o.Dato_ferdig
FROM Oppgave o, Prosjekt p, Oppgave co 
WHERE o.Prosjekt_ID = p.ID and co.ID = o.Foreldreoppgave_ID and p.ID 
IN (SELECT Prosjekt_ID FROM KoblingTeamProsjekt tp Where tp.Team_ID
IN (SELECT bt.Team_ID FROM KoblingBrukerTeam bt WHERE Bruker_ID = @brukerID))">
        <SelectParameters>
            <asp:Parameter Name ="@brukerID" Type="Int32" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
    <p>&nbsp;</p>
    <h2>Oppgaver</h2>
    <!--Gridview som viser prosjektene-->
    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3" Height="129px" Width="1037px">
        <Columns>
            <asp:BoundField DataField="Navn" HeaderText="Prosjekt" SortExpression="Navn" />
            <asp:BoundField DataField="Tittel" HeaderText="Foreldre Oppgave" SortExpression="Tittel" />
            <asp:BoundField DataField="EstimertTid" HeaderText="EstimertTid" SortExpression="EstimertTid" />
            <asp:BoundField DataField="Tittel1" HeaderText="Oppgave Tittel" SortExpression="Tittel1" />
            <asp:BoundField DataField="Beskrivelse" HeaderText="Beskrivelse" SortExpression="Beskrivelse" />
            <asp:CheckBoxField DataField="Ferdig" HeaderText="Ferdig" SortExpression="Ferdig" />
            <asp:BoundField DataField="Brukt_tid" HeaderText="Brukt_tid" SortExpression="Brukt_tid" />
            <asp:BoundField DataField="Dato_begynt" HeaderText="Dato_begynt" SortExpression="Dato_begynt" />
            <asp:BoundField DataField="Dato_ferdig" HeaderText="Dato_ferdig" SortExpression="Dato_ferdig" />
        </Columns>
    </asp:GridView>
    
<br />
    
</asp:Content>
