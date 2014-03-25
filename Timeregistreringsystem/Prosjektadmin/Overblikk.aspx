<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Overblikk.aspx.cs" Inherits="Timeregistreringssystem.Prosjektadmin.Overblikk" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Prosjekt_ID,Team_ID" DataSourceID="SqlDataSourceOverview">
        <Columns>
            <asp:BoundField DataField="ProsjektNavn" HeaderText="ProsjektNavn" SortExpression="ProsjektNavn" />
            <asp:BoundField DataField="Prosjekt_ID" HeaderText="Prosjekt_ID" InsertVisible="False" ReadOnly="True" SortExpression="Prosjekt_ID" />
            <asp:BoundField DataField="Oppsummering" HeaderText="Oppsummering" SortExpression="Oppsummering" />
            <asp:BoundField DataField="Team_ID" HeaderText="Team_ID" InsertVisible="False" ReadOnly="True" SortExpression="Team_ID" />
            <asp:BoundField DataField="Teamleder_Fornavn" HeaderText="Teamleder_Fornavn" SortExpression="Teamleder_Fornavn" />
            <asp:BoundField DataField="Teamleder_Etternavn" HeaderText="Teamleder_Etternavn" SortExpression="Teamleder_Etternavn" />
            <asp:BoundField DataField="TeamNavn" HeaderText="TeamNavn" SortExpression="TeamNavn" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceOverview" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Prosjekt.Navn AS ProsjektNavn, Prosjekt.ID AS Prosjekt_ID, Prosjekt.Oppsummering, Team.ID AS Team_ID,  Bruker.Fornavn AS Teamleder_Fornavn, Bruker.Etternavn AS Teamleder_Etternavn, Team.Beskrivelse AS TeamNavn FROM Prosjekt 

INNER JOIN KoblingTeamProsjekt ON Prosjekt.ID = KoblingTeamProsjekt.Prosjekt_ID 
INNER JOIN Team ON KoblingTeamProsjekt.Team_ID = Team.ID 
INNER JOIN Bruker ON Team.Teamleder = Bruker.ID"></asp:SqlDataSource>
</asp:Content>
