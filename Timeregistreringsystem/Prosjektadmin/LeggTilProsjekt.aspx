<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LeggTilProsjekt.aspx.cs" Inherits="Timeregistreringssystem.Prosjektadmin.LeggTilProsjekt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Prosjekt</h1>
      <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" DataKeyNames="ID">
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                <asp:BoundField DataField="Navn" HeaderText="Navn" SortExpression="Navn" />
                <asp:BoundField DataField="Oppsummering" HeaderText="Oppsummering" SortExpression="Oppsummering" />
                <asp:BoundField DataField="Neste_Fase" HeaderText="Neste_Fase" SortExpression="Neste_Fase" />
            </Columns>
        </asp:GridView>
       

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Navn, Oppsummering, Neste_Fase FROM Prosjekt"></asp:SqlDataSource>
<h1>&nbsp;</h1>
<h1>Nytt Prosjekt</h1>
        <table>
            <tr>
                <td class="auto-style4">Navn:</td>
                <td class="auto-style5">
                    <asp:TextBox ID="textBoxNavn" runat="server" Height="22px" Width="203px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style4">Oppsummering:</td>
                <td class="auto-style5">
                    <asp:TextBox ID="textBoxOppsummering" runat="server" Height="59px"  TextMode="MultiLine" Width="212px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style4">Neste Fase:</td>
                <td class="auto-style5">
                    <asp:DropDownList ID="DropDownListNyttProsjektNesteFase" runat="server" DataSourceID="SqlDataSourceNyttProsjektNesteFaseDropDown" DataTextField="Navn" DataValueField="ID" Height="34px" Width="211px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceNyttProsjektNesteFaseDropDown" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Navn FROM Fase"></asp:SqlDataSource>
                </td>
            </tr>

        </table>

        <asp:Button ID="btnLagre" runat="server" Height="34px" OnClick="btnLagre_Click" Text="Lagre Nytt Prosjekt" Width="159px" />


      
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<asp:Label ID="resultLabel" runat="server"></asp:Label>
<br />
<br />


      
        <br />
    
</asp:Content>