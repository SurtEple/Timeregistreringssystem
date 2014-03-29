<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LeggTilMilepael.aspx.cs" Inherits="Timeregistreringssystem.Prosjektadmin.LeggTilMilepael" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Milepæler</h1>
    <br />


    <asp:SqlDataSource ID="SqlDataSourceMilepael" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Milepael.ID AS ID, Milepael.Beskrivelse AS &quot;Oppgave&quot;, Møtt, Milepael.ProsjektID, Prosjekt.Navn AS ProsjektNavn
FROM Milepael INNER JOIN Prosjekt ON Milepael.ProsjektID = Prosjekt.ID
WHERE Milepael.ID &gt; 0" DeleteCommand="DELETE FROM Milepael WHERE ID=@ID" UpdateCommand="UPDATE Milepael SET Beskrivelse = @Beskrivelse, Møtt = @Møtt WHERE ID = @ID"></asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSourceMilepael" AllowPaging="True" AllowSorting="True" CssClass="table" OnRowDeleting="GridView1_RowDeleting" OnRowUpdating="GridView1_RowUpdating" OnRowUpdated="GridView1_RowUpdated">
        <Columns>
            <asp:CommandField CancelText="Avbryt" DeleteText="Slett" EditText="Endre" SelectText="Velg" ShowDeleteButton="True" ShowEditButton="True" UpdateText="Lagre" />
            <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" />
            <asp:BoundField DataField="Oppgave" HeaderText="Oppgave" SortExpression="Oppgave" />
            <asp:CheckBoxField DataField="Møtt" HeaderText="Møtt" SortExpression="Møtt" />
            <asp:BoundField DataField="ProsjektID" HeaderText="ProsjektID" SortExpression="ProsjektID" ReadOnly="True" />
            <asp:BoundField DataField="ProsjektNavn" HeaderText="ProsjektNavn" SortExpression="ProsjektNavn" ReadOnly="True" />
        </Columns>
</asp:GridView>
    <asp:SqlDataSource ID="prosjektDropDown" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Navn FROM Prosjekt"></asp:SqlDataSource>



    <br />
<h1>Ny milepæl</h1>

    <br />

    <br />

        <table>
            <tr>
                <td class="auto-style4">Oppgave: </td>
                <td class="auto-style5">
                    <asp:TextBox ID="textBoxBeskrivelse" runat="server" Height="30px" Width="244px" CssClass="input-sm"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style4"">Tilknyttet prosjekt: </td>
                <td class="auto-style5"">
    <asp:DropDownList ID="DropDownListProsjekt" runat="server" DataSourceID="prosjektDropDown" DataTextField="Navn" DataValueField="ID" CssClass="dropdown">
    </asp:DropDownList>
                    </td>
            </tr>


     

        </table>

    <br />

        <asp:Button ID="btnLagre" runat="server" Height="34px" OnClick="btnLagre_Click" Text="Lagre Ny Milepæl" Width="159px" CssClass="btn" />


      
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<asp:Label ID="resultLabel" runat="server"></asp:Label>



</asp:Content>
