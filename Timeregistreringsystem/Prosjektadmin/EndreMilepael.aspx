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
            <h1>Redigere Milepæl</h1>
            <table>

                
                <tr>
                    <td class="auto-style6" style="width: 110px; height: 58px;">ID: </td>
                <td class="auto-style5" style="height: 58px">
                           <asp:Label ID="idLabel" runat="server"> </asp:Label>
                </td>
            </tr>

                    <tr>
                <td class="auto-style6" style="width: 110px">Ny prosjektansvarlig </td>
                <td class="auto-style5">
                    <asp:DropDownList ID="DropDownListAnsvarlig" runat="server" DataSourceID="SqlDataSourceProsjektAnsvarlig" DataTextField="Brukernavn" DataValueField="ID" Height="34px" Width="138px" CssClass="dropdown">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceProsjektAnsvarlig" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Brukernavn FROM Bruker

ORDER BY ID;"></asp:SqlDataSource>
                </td>
            </tr>

                <tr>
                    <td class="auto-style6" style="width: 110px">Nytt navn:  </td>
                <td class="auto-style5">
                    <asp:TextBox ID="textBoxNewNavn" runat="server" Width="128px" CssClass="input-sm"></asp:TextBox>
                </td>
            </tr>

                 <tr>
                <td class="auto-style6" style="height: 102px; width: 110px;">&nbsp;</td>
                <td class="auto-style5" style="height: 102px">
                    &nbsp;</td>
            </tr>

            <tr>
                <td class="auto-style6" style="width: 110px">Ny neste fase: </td>
                <td class="auto-style5">
                    <asp:DropDownList ID="DropDownListNyNesteFase" runat="server" DataSourceID="SqlDataSourceNyNesteFase" DataTextField="Navn" DataValueField="ID" Height="34px" Width="138px" CssClass="dropdown">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceNyNesteFase" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Navn FROM Fase WHERE Prosjekt_ID=@Prosjekt_ID"></asp:SqlDataSource>
                </td>
            </tr>

             <tr>
                <td class="auto-style6" style="width: 110px">Ny Neste milepæl: </td>
                <td class="auto-style5">
                    <asp:DropDownList ID="DropDownListMilestone" runat="server" DataSourceID="SqlDataSourceNyMilestone" DataTextField="Beskrivelse" DataValueField="ID" Height="34px" Width="138px" CssClass="dropdown">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceNyMilestone" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Beskrivelse FROM Milepael WHERE ProsjektID=@Prosjekt_ID"></asp:SqlDataSource>
                &nbsp;</td>
            </tr>


            </table>



        <br />
        <asp:Button ID="btnLagreNewMilestone" runat="server" Text="Lagre" Width="103px" Height="36px" CssClass="btn" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <asp:Label ID="resultLabel0" runat="server"></asp:Label>
    </div>
</asp:Content>
