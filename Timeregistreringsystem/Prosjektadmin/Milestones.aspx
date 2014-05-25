<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Milestones.aspx.cs" Inherits="Timeregistreringssystem.Prosjektadmin.Milestones" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    
    <h1>Ny milepæl</h1>
    <br />
    <table>
        <tr>
            <td class="auto-style4" style="height: 46px">Prosjekt: </td>
            <td class="auto-style5" style="height: 46px">
                <asp:DropDownList ID="DropDownListProsjekt" runat="server" AutoPostBack="True" CssClass="dropdown" DataSourceID="SqlDataSourceProsjekt" DataTextField="Navn" DataValueField="ID" OnSelectedIndexChanged="DropDownListProsjekt_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSourceProsjekt" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Navn FROM Prosjekt"></asp:SqlDataSource>
            </td>

        </tr>
        <tr>
            <td class="auto-style4" style="height: 46px">Fase: </td>
            <td class="auto-style5" style="height: 46px">
                <asp:DropDownList ID="DropDownListFase" runat="server" CssClass="dropdown" DataSourceID="SqlDataSourceFase" DataTextField="Navn" DataValueField="ID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSourceFase" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Navn FROM Fase WHERE (Prosjekt_ID = @Prosjekt_ID)"></asp:SqlDataSource>
            </td>

        </tr>
        <tr>
            <td class="auto-style4" style="height: 46px">Oppgave: </td>
            <td class="auto-style5" style="height: 46px">
                <asp:DropDownList ID="DropDownListOppgave" runat="server" DataSourceID="oppgaveDropDown" DataTextField="Tittel" DataValueField="ID" Width="154px" AutoPostBack="True" CssClass="dropdown" OnSelectedIndexChanged="DropDownListOppgave_SelectedIndexChanged">
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
    <asp:Button ID="btnLagre" runat="server" Height="34px" OnClick="btnLagre_Click" Text="Lagre Ny Milepæl" Width="159px" CssClass="btn" OnClientClick="Confirm()"/>


      
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

     <!-- Confirm dialogbox, Husk å legge til OnClientClick="Confirm()" på hvilken knapp denne skal benyttes-->
    <script type = "text/javascript">
        function Confirm() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Er du sikker på at du vil legge til denne milepælen?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }
    </script>
    

    <h1>Milepæler</h1>
    <br />

    

         <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" 
       
        InsertCommand="INSERT INTO Milepæl(Oppgave_ID, Dato_Ferdig, Fase_ID) VALUES(@OppgID, @Dato, @FaseID)" SelectCommand="SELECT * FROM Milepæl" >
      

    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="SqlDataSourceMilepael" runat="server" 
        ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>"
         SelectCommand="SELECT Milepæl.ID, Fase.Navn AS FaseNavn, Fase.Beskrivelse, Fase.Dato_startet, Fase.Dato_Sluttet, Fase.Aktiv, Prosjekt.Navn AS Prosjekt, Oppgave.Tittel AS Milepæl, Milepæl.Dato_Ferdig AS &quot;Milepæl nådd&quot; FROM Milepæl INNER JOIN Oppgave ON Milepæl.Oppgave_ID = Oppgave.ID LEFT OUTER JOIN Fase ON Milepæl.Fase_ID = Fase.ID LEFT OUTER JOIN Prosjekt ON Prosjekt.ID = Oppgave.Prosjekt_ID
ORDER BY Fase.ID" DeleteCommand="DELETE FROM Milepæl WHERE (ID = @ID)" UpdateCommand="UPDATE Milepæl, Oppgave
SET Milepæl.Dato_Ferdig= @DatoFerdig,
Oppgave.Beskrivelse=@Beskrivelse
WHERE Milepæl.ID=@ID
AND Milepæl.Oppgave_ID = Oppgave.ID 
" InsertCommand="INSERT INTO Milepæl(Oppgave_ID,Dato_Ferdig) 
VALUES (@OppgID, NOW())"></asp:SqlDataSource>


    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSourceMilepael" AllowPaging="True" AllowSorting="True" CssClass="table" OnRowUpdated="GridView1_RowUpdated" Width="70%" OnRowEditing="GridView1_RowEditing" ValidateRequestMode="Enabled" DataKeyNames="ID" 
         >
        <Columns>
            <asp:CommandField DeleteText="Slett milepæl" ShowDeleteButton="True" />
            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
            <asp:BoundField DataField="FaseNavn" HeaderText="FaseNavn" SortExpression="FaseNavn" />

            <asp:BoundField DataField="Beskrivelse" HeaderText="Beskrivelse" SortExpression="Beskrivelse" />

            <asp:BoundField DataField="Dato_startet" HeaderText="Dato_startet" SortExpression="Dato_startet" />
              <asp:BoundField DataField="Dato_Sluttet" HeaderText="Dato_Sluttet" SortExpression="Dato_Sluttet" />
              <asp:CheckBoxField DataField="Aktiv" HeaderText="Aktiv" SortExpression="Aktiv" />

            <asp:BoundField DataField="Prosjekt" HeaderText="Prosjekt" SortExpression="Prosjekt" />

              <asp:BoundField DataField="Milepæl" HeaderText="Milepæl" SortExpression="Milepæl" />
              <asp:BoundField DataField="Milepæl nådd" HeaderText="Milepæl nådd" SortExpression="Milepæl nådd" />

        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="oppgaveDropDown" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Tittel FROM Oppgave WHERE (Prosjekt_ID = @Prosjekt_ID) AND (ID NOT IN (SELECT Oppgave_ID FROM Milepæl `Milepæl_1`)) AND (Foreldreoppgave_ID = 0)"></asp:SqlDataSource>
    <br />
    </asp:Content>
