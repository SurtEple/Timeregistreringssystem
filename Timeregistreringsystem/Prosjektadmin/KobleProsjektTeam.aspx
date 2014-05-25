<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="KobleProsjektTeam.aspx.cs" Inherits="Timeregistreringssystem.Prosjektadmin.KobleProsjektTeam" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
       

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM Prosjekt"></asp:SqlDataSource>
        </h2>
<h1>Koble Team til Prosjekt</h1>
        <table>
            <tr>
                <td class="auto-style7">Prosjekt:</td>
                <td class="auto-style2">
                    <asp:DropDownList ID="DropDownListKobleProsjekt" runat="server" DataSourceID="ProsjektIDSqlDataSource" DataTextField="Navn" DataValueField="ID" CssClass="dropdown">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="ProsjektIDSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Navn FROM Prosjekt"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="auto-style7">Team: </td>
                <td class="auto-style2">
                    <asp:DropDownList ID="DropDownListKobleTeam" runat="server" DataSourceID="teamIDSqlDataSource" DataTextField="Beskrivelse" DataValueField="ID" CssClass="dropdown">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="teamIDSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Beskrivelse FROM Team"></asp:SqlDataSource>
                </td>
            </tr>
        </table>
        <br />
        <asp:Button ID="btnConnectTeamProject" runat="server" Text="Lagre Kobling" Width="128px" OnClick="btnConnectTeamProject_Click" CssClass="btn" />
    
    &nbsp;<asp:Label ID="resultLabel" runat="server"></asp:Label>
    <h2>
       

        Team og Prosjekter</h2>
        <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" CssClass="table" DataSourceID="SqlDataSourceOverview">
            <Columns>
                <asp:CommandField DeleteText="Slett Kobling" ShowDeleteButton="True" />
                <asp:BoundField DataField="Kobling" HeaderText="Kobling" SortExpression="Kobling" InsertVisible="False" />
                <asp:BoundField DataField="Team" HeaderText="Team" SortExpression="Team" />
                <asp:BoundField DataField="Prosjekt" HeaderText="Prosjekt" SortExpression="Prosjekt" />
                <asp:BoundField DataField="ProsjektAnsvarlig" HeaderText="ProsjektAnsvarlig" SortExpression="ProsjektAnsvarlig" />
            </Columns>
</asp:GridView>
<asp:SqlDataSource ID="SqlDataSourceOverview" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT KoblingTeamProsjekt.ID AS Kobling, Team.Beskrivelse AS Team, Prosjekt.Navn AS Prosjekt, Bruker.Brukernavn AS ProsjektAnsvarlig FROM Prosjekt INNER JOIN KoblingTeamProsjekt ON Prosjekt.ID = KoblingTeamProsjekt.Prosjekt_ID INNER JOIN Bruker ON Prosjekt.ansvarligID = Bruker.ID RIGHT OUTER JOIN Team ON KoblingTeamProsjekt.Team_ID = Team.ID" DeleteCommand="DELETE FROM KoblingTeamProsjekt WHERE ID=@Kobling"></asp:SqlDataSource>
    <br />
&nbsp;<p>
        &nbsp;</p>
        
</asp:Content>
