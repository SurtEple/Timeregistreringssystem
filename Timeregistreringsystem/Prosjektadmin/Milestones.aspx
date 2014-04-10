<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Milestones.aspx.cs" Inherits="Timeregistreringssystem.Prosjektadmin.Milestones" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    
    <h1>Milepæler</h1>
    <br />

    

         <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" 
       
        InsertCommand="INSERT INTO Milepæl(Oppgave_ID, Dato_Ferdig) VALUES(@OppgID, @Dato)" SelectCommand="SELECT * FROM Milepæl" >
      

    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="SqlDataSourceMilepael" runat="server" 
        ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>"
         SelectCommand="SELECT Milepæl.ID, Milepæl.Dato_Ferdig AS &quot;Dato Ferdig&quot;, Oppgave.Tittel, Oppgave.Beskrivelse, Prosjekt.Navn AS Prosjektnavn
 FROM Milepæl
 INNER JOIN Oppgave ON Milepæl.Oppgave_ID = Oppgave.ID 
INNER JOIN Prosjekt ON Oppgave.Prosjekt_ID = Prosjekt.ID

ORDER BY Milepæl.ID DESC" DeleteCommand="DELETE FROM Milepæl WHERE ID=@ID" UpdateCommand="UPDATE Milepæl, Oppgave
SET Milepæl.Dato_Ferdig= @DatoFerdig,
Oppgave.Beskrivelse=@Beskrivelse

WHERE Milepæl.ID=@ID
AND Milepæl.Oppgave_ID = Oppgave.ID 
" InsertCommand="INSERT INTO Milepæl(Oppgave_ID,Dato_Ferdig) 
VALUES (@OppgID, NOW())"></asp:SqlDataSource>


    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" 
        DataSourceID="SqlDataSourceMilepael" AllowPaging="True" AllowSorting="True" CssClass="table"
         OnRowDeleting="GridView1_RowDeleting" OnRowUpdating="GridView1_RowUpdating" OnRowUpdated="GridView1_RowUpdated" Width="70%" OnRowEditing="GridView1_RowEditing" ValidateRequestMode="Enabled" 
         >
        <Columns>
              <asp:CommandField CancelText="Avbryt" DeleteText="Slett" EditText="Endre" ShowDeleteButton="True" ShowEditButton="True" UpdateText="Lagre" />
              <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" />       

            <asp:BoundField DataField="Dato Ferdig" HeaderText="Dato Ferdig" SortExpression="Dato Ferdig" />

            <asp:BoundField DataField="Tittel" HeaderText="Tittel" SortExpression="Tittel" ReadOnly="True" />
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
            <td class="auto-style4" style="height: 46px">Oppgave: </td>
            <td class="auto-style5" style="height: 46px">
                <asp:DropDownList ID="DropDownListOppgave" runat="server" DataSourceID="oppgaveDropDown" DataTextField="Tittel" DataValueField="ID" Width="154px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="auto-style4"">Dato Ferdig:</td>
            <td class="datepicker1"">
                <asp:TextBox ID="dateFerdigTextBox" runat="server" Height="41px" CssClass="input-group-sm" Width="151px"></asp:TextBox>
                 
               <asp:Image ID="startCal" runat="server" ImageUrl="~/Content/glyphicons/png/glyphicons_045_calendar.png" CssClass="glyphicon-calendar" />


            </td>
        </tr>
    </table>
    <br />
    <asp:Button ID="btnLagre" runat="server" Height="34px" OnClick="btnLagre_Click" Text="Lagre Ny Milepæl" Width="159px" CssClass="btn" />


      
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="resultLabel" runat="server"></asp:Label>


     <link rel="stylesheet" type="text/css" href="../Content/jquery.datetimepicker.css"/ >
        <script src="../Scripts/jquery-2.1.0.js"></script>
        <script src="../Scripts/jquery.datetimepicker.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#<%= dateFerdigTextBox.ClientID %>").datetimepicker();
       });
        </script>
</asp:Content>
