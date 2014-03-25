<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Faser.aspx.cs" Inherits="Timeregistreringssystem.Prosjektadmin.Faser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        &nbsp;</p>
    <p>
       <h2>Oversikt prosjekter og faser</h2> <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ProsjektID,FaseID" DataSourceID="SqlDataSourceProjectPhaseOverview">
            <Columns>
                <asp:BoundField DataField="ProsjektID" HeaderText="ProsjektID" InsertVisible="False" ReadOnly="True" SortExpression="ProsjektID" />
                <asp:BoundField DataField="ProsjektNavn" HeaderText="ProsjektNavn" SortExpression="ProsjektNavn" />
                <asp:BoundField DataField="FaseID" HeaderText="FaseID" InsertVisible="False" ReadOnly="True" SortExpression="FaseID" />
                <asp:BoundField DataField="FaseNavn" HeaderText="FaseNavn" SortExpression="FaseNavn" />
                <asp:BoundField DataField="Dato_startet" HeaderText="Dato_startet" SortExpression="Dato_startet" />
                <asp:BoundField DataField="Dato_sluttet" HeaderText="Dato_sluttet" SortExpression="Dato_sluttet" />
                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                <asp:BoundField DataField="Beskrivelse" HeaderText="Beskrivelse" SortExpression="Beskrivelse" />
                <asp:BoundField DataField="Oppsummering" HeaderText="Oppsummering" SortExpression="Oppsummering" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceProjectPhaseOverview" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Prosjekt.ID AS ProsjektID, Prosjekt.Navn AS ProsjektNavn, Fase.ID AS FaseID, Fase.Navn AS FaseNavn, Fase.Dato_startet, Fase.Dato_sluttet, Fase.Status, Fase.Beskrivelse, Prosjekt.Oppsummering FROM Fase, Prosjekt WHERE Fase.Prosjekt_ID = Prosjekt.ID"></asp:SqlDataSource>
    </p>
</asp:Content>
