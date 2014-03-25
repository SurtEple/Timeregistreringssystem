﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LeggTilProsjekt.aspx.cs" Inherits="Timeregistreringssystem.Prosjektadmin.LeggTilProsjekt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Prosjekt</h1>
      <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" DataKeyNames="ID" CssClass="table-bordered">
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                <asp:BoundField DataField="Navn" HeaderText="Navn" SortExpression="Navn" />
                <asp:BoundField DataField="Oppsummering" HeaderText="Oppsummering" SortExpression="Oppsummering" />
                <asp:BoundField DataField="Beskrivelse Aktiv Fase" HeaderText="Beskrivelse Aktiv Fase" SortExpression="Beskrivelse Aktiv Fase" />
                <asp:BoundField DataField="Beskrivelse Neste Fase" HeaderText="Beskrivelse Neste Fase" SortExpression="Beskrivelse Neste Fase" />
            </Columns>
        </asp:GridView>
       

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Prosjekt.ID, Prosjekt.Navn, Prosjekt.Oppsummering, (SELECT Beskrivelse FROM Fase WHERE aktiv=true AND Prosjekt_ID = Prosjekt.ID) AS &quot;Beskrivelse Aktiv Fase&quot;, Fase.Beskrivelse AS &quot;Beskrivelse Neste Fase&quot;

 FROM Prosjekt, Fase
 WHERE 
 Prosjekt.Neste_Fase = Fase.ID AND Prosjekt.ID &gt; 0 

ORDER BY Prosjekt.ID"></asp:SqlDataSource>
<h1>&nbsp;</h1>
<h1>Nytt Prosjekt</h1>

    <br />

    <br />

        <table>
            <tr>
                <td class="auto-style4">Navn:</td>
                <td class="auto-style5">
                    <asp:TextBox ID="textBoxNavn" runat="server" Height="22px" Width="203px" CssClass="input-sm"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style4">Oppsummering:</td>
                <td class="auto-style5">
                    <asp:TextBox ID="textBoxOppsummering" runat="server" Height="59px"  TextMode="MultiLine" Width="212px" CssClass="input-lg"></asp:TextBox>
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