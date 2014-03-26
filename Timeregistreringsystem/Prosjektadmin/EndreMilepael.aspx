<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EndreMilepael.aspx.cs" Inherits="Timeregistreringssystem.Prosjektadmin.EndreMilepael" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Milepæler</h1>
    <div>
        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" CssClass="table" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ID,ProsjektID1">
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                <asp:BoundField DataField="Beskrivelse" HeaderText="Beskrivelse" SortExpression="Beskrivelse" />
                <asp:BoundField DataField="ProsjektID" HeaderText="ProsjektID" SortExpression="ProsjektID" />
                <asp:BoundField DataField="ProsjektID1" HeaderText="ProsjektID1" SortExpression="ProsjektID1" InsertVisible="False" ReadOnly="True" />
                <asp:BoundField DataField="ProsjektNavn" HeaderText="ProsjektNavn" SortExpression="ProsjektNavn" />
                <asp:BoundField DataField="ansvarligID" HeaderText="ansvarligID" SortExpression="ansvarligID" />
                <asp:BoundField DataField="Neste_Milepæl" HeaderText="Neste_Milepæl" SortExpression="Neste_Milepæl" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" 
                        SelectCommand="SELECT Milepael.ID, Milepael.Beskrivelse, Milepael.ProsjektID, Prosjekt.ID AS ProsjektID, Prosjekt.Navn AS ProsjektNavn, Prosjekt.ansvarligID, Prosjekt.`Neste_Milepæl` FROM Milepael INNER JOIN Prosjekt ON Milepael.ProsjektID = Prosjekt.ID AND Milepael.ID = Prosjekt.`Neste_Milepæl`" DeleteCommand="DELETE FROM Prosjekt WHERE (ID = @ID)"></asp:SqlDataSource>
        <br />
        <br />
    </div>
    <div>
        <h1>Redigere Prosjekt</h1>
        <p>
            <asp:DropDownList ID="DropDownListEditProsjekt" runat="server" DataSourceID="SqlDataSourceDropDownDelProject" DataTextField="Navn" DataValueField="ID" Height="34px" Width="157px" AutoPostBack="True" CssClass="dropdown">
            </asp:DropDownList>
        </p>
        <table>
            <tr>
                <td class="auto-style6">Nytt navn:  </td>
                <td class="auto-style5">
                    <asp:TextBox ID="textBoxNewNavn" runat="server" Width="128px" CssClass="input-sm"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style6" style="height: 102px">Ny oppsummering: </td>
                <td class="auto-style5" style="height: 102px">
                    <asp:TextBox ID="textBoxNewOppsummering" runat="server" TextMode="MultiLine" CssClass="input-group-lg" Height="68px" Width="168px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style6">Ny neste fase: </td>
                <td class="auto-style5">
                    <asp:DropDownList ID="DropDownListNyNesteFase" runat="server" DataSourceID="SqlDataSourceNyNesteFase" DataTextField="Navn" DataValueField="ID" Height="34px" Width="138px" CssClass="dropdown">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceNyNesteFase" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Navn, ID FROM Fase"></asp:SqlDataSource>
                </td>
            </tr>
        </table>
        <br />
        <asp:Button ID="btnLagreNewMilestone" runat="server" Text="Lagre" Width="103px" Height="36px" CssClass="btn" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <asp:Label ID="resultLabel0" runat="server"></asp:Label>
    </div>
</asp:Content>
