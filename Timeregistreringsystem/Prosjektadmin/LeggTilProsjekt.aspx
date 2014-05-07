﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LeggTilProsjekt.aspx.cs" Inherits="Timeregistreringssystem.Prosjektadmin.LeggTilProsjekt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Prosjekt</h1>
      <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" DataKeyNames="ID" CssClass="table" AllowPaging="True" AllowSorting="True">
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                <asp:BoundField DataField="Navn" HeaderText="Navn" SortExpression="Navn" />
                <asp:BoundField DataField="Ansvarlig" HeaderText="Ansvarlig" SortExpression="Ansvarlig" />
                <asp:BoundField DataField="Oppsummering" HeaderText="Oppsummering" SortExpression="Oppsummering" />
                <asp:BoundField DataField="Beskrivelse Aktiv Fase" HeaderText="Beskrivelse Aktiv Fase" SortExpression="Beskrivelse Aktiv Fase" />
                <asp:BoundField DataField="Beskrivelse neste milepæl" HeaderText="Beskrivelse neste milepæl" SortExpression="Beskrivelse neste milepæl" />
                <asp:BoundField DataField="Beskrivelse Neste Fase" HeaderText="Beskrivelse Neste Fase" SortExpression="Beskrivelse Neste Fase" />
            </Columns>
        </asp:GridView>
       

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Prosjekt.ID, Prosjekt.Navn, Bruker.Brukernavn AS Ansvarlig, Prosjekt.Oppsummering, 

(SELECT Beskrivelse FROM Fase WHERE aktiv=true AND Prosjekt_ID = Prosjekt.ID) AS &quot;Beskrivelse Aktiv Fase&quot;, 

Milepael.Beskrivelse AS &quot;Beskrivelse neste milepæl&quot;,
Fase.Beskrivelse AS &quot;Beskrivelse Neste Fase&quot;

FROM Prosjekt, Fase, Bruker, Milepael 
WHERE Prosjekt.Neste_Fase = Fase.ID 
AND Prosjekt.ID &gt; 0 
AND Bruker.ID=Prosjekt.ansvarligID 
AND Milepael.ID=Prosjekt.Neste_Milepæl
ORDER BY Prosjekt.ID"></asp:SqlDataSource>
<h1>&nbsp;</h1>
<h1>Nytt Prosjekt</h1>

    <br />

    <br />

        <table>
            <tr>
                <td class="auto-style4">Navn:</td>
                <td class="auto-style5">
                    <asp:TextBox ID="textBoxNavn" runat="server" Height="30px" Width="244px" CssClass="input-sm"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style4" style="height: 195px">Oppsummering:</td>
                <td class="auto-style5" style="height: 195px">
                    <asp:TextBox ID="textBoxOppsummering" runat="server" Height="151px"  TextMode="MultiLine" Width="239px" CssClass="input-lg"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style4">Prosjektansvarlig</td>
                <td class="auto-style5">
                    &nbsp;<asp:DropDownList ID="lederDropDownList" runat="server" DataSourceID="Lederdropdown" DataTextField="Brukernavn" DataValueField="ID" CssClass="dropdown">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="Lederdropdown" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Brukernavn FROM Bruker
ORDER BY ID"></asp:SqlDataSource>
                </td>
            </tr>
<asp:SqlDataSource ID="SqlDataSourceNyttProsjektNesteFaseDropDown" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Navn FROM Fase"></asp:SqlDataSource>
     

        </table>

    <br />

        <asp:Button ID="btnLagre" runat="server" Height="34px" OnClick="btnLagre_Click" Text="Lagre Nytt Prosjekt" Width="159px" CssClass="btn" />


      
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<asp:Label ID="resultLabel" runat="server"></asp:Label>
<br />
<br />


      
        <br />
    
</asp:Content>