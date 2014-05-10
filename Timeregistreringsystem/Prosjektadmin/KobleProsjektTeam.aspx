<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="KobleProsjektTeam.aspx.cs" Inherits="Timeregistreringssystem.Prosjektadmin.KobleProsjektTeam" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
       

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM Prosjekt"></asp:SqlDataSource>
        Prosjekt</h2>
        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" DataKeyNames="ID" CssClass="table">
          
                   
              <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                <asp:BoundField DataField="Navn" HeaderText="Navn" SortExpression="Navn" />
                <asp:BoundField DataField="Oppsummering" HeaderText="Oppsummering" SortExpression="Oppsummering" />
                <asp:BoundField DataField="Neste_Fase" HeaderText="Neste_Fase" SortExpression="Neste_Fase" />
            </Columns>
        </asp:GridView>

            <h2>Team</h2>
        <asp:GridView ID="GridView2" runat="server" DataSourceID="SqlDataSource2" AutoGenerateColumns="False" DataKeyNames="ID">
          
                   
              <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                <asp:BoundField DataField="Teamleder" HeaderText="Teamleder" SortExpression="Teamleder" />
                <asp:BoundField DataField="Beskrivelse" HeaderText="Beskrivelse" SortExpression="Beskrivelse" />
            </Columns>
        </asp:GridView>

            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM Team"></asp:SqlDataSource>
    <br />
  <h2>Team og prosjekter</h2>  <br />
        <asp:GridView ID="GridView3" runat="server" DataSourceID="SqlDataSource3" AutoGenerateColumns="False" DataKeyNames="ID,ID1">
          
                   
              <Columns>
                <asp:BoundField DataField="Team_ID" HeaderText="Team_ID" SortExpression="Team_ID" />
                <asp:BoundField DataField="Prosjekt_ID" HeaderText="Prosjekt_ID" SortExpression="Prosjekt_ID" />
                <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" />
                  <asp:BoundField DataField="Teamleder" HeaderText="Teamleder" SortExpression="Teamleder" />
                  <asp:BoundField DataField="Beskrivelse" HeaderText="Beskrivelse" SortExpression="Beskrivelse" />
                  <asp:BoundField DataField="ID1" HeaderText="ID1" InsertVisible="False" ReadOnly="True" SortExpression="ID1" />
                  <asp:BoundField DataField="Navn" HeaderText="Navn" SortExpression="Navn" />
                  <asp:BoundField DataField="Oppsummering" HeaderText="Oppsummering" SortExpression="Oppsummering" />
                  <asp:BoundField DataField="Neste_Fase" HeaderText="Neste_Fase" SortExpression="Neste_Fase" />
            </Columns>
        </asp:GridView>

            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT KoblingTeamProsjekt.*, Team.*, Prosjekt.* FROM KoblingTeamProsjekt INNER JOIN Team ON KoblingTeamProsjekt.Team_ID = Team.ID INNER JOIN Prosjekt ON KoblingTeamProsjekt.Prosjekt_ID = Prosjekt.ID"></asp:SqlDataSource>
        <h1>Koble Team til Prosjekt</h1>
        <table>
            <tr>
                <td class="auto-style7">Prosjekt:</td>
                <td class="auto-style2">
                    <asp:DropDownList ID="DropDownListKobleProsjekt" runat="server" DataSourceID="ProsjektIDSqlDataSource" DataTextField="Navn" DataValueField="ID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="ProsjektIDSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Navn FROM Prosjekt"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="auto-style7">Team: </td>
                <td class="auto-style2">
                    <asp:DropDownList ID="DropDownListKobleTeam" runat="server" DataSourceID="teamIDSqlDataSource" DataTextField="Beskrivelse" DataValueField="ID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="teamIDSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Beskrivelse FROM Team"></asp:SqlDataSource>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <asp:Button ID="btnConnectTeamProject" runat="server" Text="Lagre Kobling" Width="128px" OnClick="btnConnectTeamProject_Click" />
    
    &nbsp;<asp:Label ID="resultLabel" runat="server"></asp:Label>
    <br />
&nbsp;<p>
        &nbsp;</p>
        
</asp:Content>
