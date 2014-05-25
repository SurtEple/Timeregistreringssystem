<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LeggTilProsjekt.aspx.cs" Inherits="Timeregistreringssystem.Prosjektadmin.LeggTilProsjekt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Prosjekt</h1>
      <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" CssClass="table" AllowPaging="True" AllowSorting="True">
            <Columns>
                <asp:BoundField DataField="ProsjektNavn" HeaderText="ProsjektNavn" SortExpression="ProsjektNavn" />
                <asp:BoundField DataField="Prosjektansvarlig" HeaderText="Prosjektansvarlig" SortExpression="Prosjektansvarlig" />
                <asp:BoundField DataField="Oppsummering" HeaderText="Oppsummering" SortExpression="Oppsummering" />
                <asp:BoundField DataField="Aktiv Fase" HeaderText="Aktiv Fase" SortExpression="Aktiv Fase" />
                <asp:BoundField DataField="Neste milepæl" HeaderText="Neste milepæl" SortExpression="Neste milepæl" />
                <asp:BoundField DataField="Neste Fase " HeaderText="Neste Fase " SortExpression="Neste Fase " />
            </Columns>
        </asp:GridView>
       

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Prosjekt.Navn AS ProsjektNavn, Bruker.Brukernavn AS Prosjektansvarlig, Prosjekt.Oppsummering, (SELECT Beskrivelse FROM Fase WHERE aktiv=1 AND Prosjekt_ID = Prosjekt.ID) AS &quot;Aktiv Fase&quot;, Oppgave.Tittel AS &quot;Neste milepæl&quot;, Fase.Beskrivelse AS &quot; Neste Fase &quot; FROM Prosjekt LEFT OUTER JOIN Milepæl ON Prosjekt.`Neste_Milepæl` = Milepæl.ID LEFT OUTER JOIN Oppgave ON Milepæl.Oppgave_ID = Oppgave.ID LEFT OUTER JOIN Fase ON Prosjekt.Neste_Fase = Fase.ID LEFT OUTER JOIN Bruker ON Bruker.ID=Prosjekt.ansvarligID WHERE Prosjekt.ID&gt;0 ORDER BY Prosjekt.ID DESC"></asp:SqlDataSource>
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