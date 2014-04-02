﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Milestones.aspx.cs" Inherits="Timeregistreringssystem.Prosjektadmin.Milestones" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Milepæler</h1>
    <br />
    <asp:SqlDataSource ID="SqlDataSourceMilepael" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Milepæl.Dato_Ferdig, Milepæl.ID, Oppgave.Tittel, Oppgave.Beskrivelse, Prosjekt.Navn AS Prosjektnavn FROM Milepæl INNER JOIN Oppgave ON Milepæl.Oppgave_ID = Oppgave.ID INNER JOIN Prosjekt ON Oppgave.Prosjekt_ID = Prosjekt.ID" DeleteCommand="DELETE FROM Milepæl WHERE ID=@ID" UpdateCommand="UPDATE Milepæl SET Dato_Ferdig=@DatoFerdig WHERE ID=@ID"></asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSourceMilepael" AllowPaging="True" AllowSorting="True" CssClass="table" OnRowDeleting="GridView1_RowDeleting" OnRowUpdating="GridView1_RowUpdating" OnRowUpdated="GridView1_RowUpdated" Height="384px" Width="16px">
        <Columns>
            <asp:CommandField DeleteText="Slett" EditText="Endre" ShowDeleteButton="True" ShowEditButton="True" UpdateText="Lagre" />
            <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" />
            <asp:BoundField DataField="Dato_Ferdig" HeaderText="Dato_Ferdig" SortExpression="Dato_Ferdig" />
            <asp:BoundField DataField="Tittel" HeaderText="Tittel" SortExpression="Tittel" />
            <asp:BoundField DataField="Beskrivelse" HeaderText="Beskrivelse" SortExpression="Beskrivelse" />
            <asp:BoundField DataField="Prosjektnavn" HeaderText="Prosjektnavn" SortExpression="Prosjektnavn" ReadOnly="True" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="oppgaveDropDown" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Tittel FROM Oppgave WHERE (Foreldreoppgave_ID = 0) "></asp:SqlDataSource>
    <br />
    <h1>Ny milepæl</h1>
    <br />
    <br />
    <table>
        <tr>
            <td class="auto-style4">Oppgave: </td>
            <td class="auto-style5">
                <asp:DropDownList ID="DropDownListOppgave" runat="server" DataSourceID="oppgaveDropDown" DataTextField="Tittel" DataValueField="ID">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="auto-style4"">Dato Ferdig:</td>
            <td class="auto-style5"">
                    <asp:TextBox ID="dateFerdigTextBox" runat="server" Height="19px" CssClass="input-sm">Klikk her</asp:TextBox>
                 
                    <asp:Image ID="startCal" runat="server" ImageUrl="~/Content/glyphicons/png/glyphicons_045_calendar.png" />
                 
            </td>
        </tr>
    </table>
    <br />
    <asp:Button ID="btnLagre" runat="server" Height="34px" OnClick="btnLagre_Click" Text="Lagre Ny Milepæl" Width="159px" CssClass="btn" />


      
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="resultLabel" runat="server"></asp:Label>


     <script src="../Scripts/bootstrap-datepicker.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function ()
        {
           var dpFerdig = $('#<%=dateFerdigTextBox.ClientID%>');

         dpFerdig.datepicker({
             changeMonth: true,
             changeYear: true,
             format: "yyyy-mm-dd",
             language: "tr"
         }).on('changeDate', function (ev) {
             $(this).blur();
             $(this).datepicker('hide');
         });

        }

    );
        </script>
</asp:Content>