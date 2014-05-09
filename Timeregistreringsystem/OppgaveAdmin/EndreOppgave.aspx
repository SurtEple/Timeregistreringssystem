<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EndreOppgave.aspx.cs" Inherits="Timeregistreringssystem.OppgaveAdmin.EndreOppgave" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Oppgaver</h1>


    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSourceEndreOppgaver">
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" Visible="False" />
            <asp:BoundField DataField="Tittel" HeaderText="Oppgavenavn" SortExpression="Tittel" />
            <asp:BoundField DataField="Beskrivelse" HeaderText="Beskrivelse" SortExpression="Beskrivelse" />
            <asp:BoundField DataField="Hovedoppgave" HeaderText="Hovedoppgave" SortExpression="Hovedoppgave" />
            <asp:BoundField DataField="Prosjekt" HeaderText="Prosjekt" SortExpression="Prosjekt" />
            <asp:BoundField DataField="Estimert tid" HeaderText="Estimert tid" SortExpression="Estimert tid" />
            <asp:BoundField DataField="Brukt tid" HeaderText="Brukt tid" SortExpression="Brukt tid" />
            <asp:CheckBoxField DataField="Ferdig" HeaderText="Ferdig" SortExpression="Ferdig" />
            <asp:BoundField DataField="Startdato" HeaderText="Startdato" SortExpression="Startdato" DataFormatString="{0:d}" HtmlEncode="False" />
            <asp:BoundField DataField="Sluttdato" HeaderText="Sluttdato" SortExpression="Sluttdato" DataFormatString="{0:d}" HtmlEncode="False" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceEndreOppgaver" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Oppgave.ID, Oppgave.Tittel, Oppgave.Beskrivelse, Oppgave.Foreldreoppgave_ID AS Hovedoppgave, Prosjekt.Navn AS Prosjekt, Oppgave.EstimertTid AS `Estimert tid`, Oppgave.Brukt_tid AS `Brukt tid`, Oppgave.Ferdig, Oppgave.Dato_begynt AS Startdato, Oppgave.Dato_ferdig AS Sluttdato FROM Oppgave INNER JOIN Prosjekt ON Oppgave.Prosjekt_ID = Prosjekt.ID"></asp:SqlDataSource>

    <h1>Ferdig med Oppgave</h1>

    <asp:Label ID="lblVelgFerdigOppgave" runat="server" Text="Velg oppgave"></asp:Label>
    <br />
    <asp:DropDownList ID="ddlFerdigeOppgaver" runat="server" DataSourceID="SqlDataSourceFerdigeOppgaver" DataTextField="Tittel" DataValueField="ID" Width="230px" AutoPostBack="True" OnSelectedIndexChanged="ddlFerdigeOppgaver_SelectedIndexChanged"></asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSourceFerdigeOppgaver" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Tittel FROM Oppgave"></asp:SqlDataSource>

    <br />

    <table>
        <tr>
            <td>* Brukt tid: </td>
            <td><asp:TextBox ID="tbxBruktTid" runat="server" TextMode="Number"></asp:TextBox></td>
        </tr>
        <tr>
                <td class="auto-style7" style="width: 161px; height: 57px">* Slutt dato: </td>
                <td class="modal-sm" style="width: 290px; height: 57px">
                    <asp:TextBox ID="dateStopTextBox2" runat="server" Height="28px" CssClass="input-sm" Width="245px">Klikk her</asp:TextBox>
                    <asp:Image ID="Image3" runat="server" ImageUrl="~/Content/glyphicons/png/glyphicons_045_calendar.png" />
                </td>
            </tr>
    </table>

    <br />
    <asp:Button ID="btnFerdigOppgave" runat="server" Text="Ferdig" OnClick="btnFerdigOppgave_Click" />
    <br />
    <asp:Label ID="lblFerdigTilbakemelding" runat="server" Text=""></asp:Label>


    <h1>Slette oppgave</h1>

    <asp:Label ID="lblSlettOppgave" runat="server" Text="Velg oppgave"></asp:Label>
    <br />
    <asp:DropDownList ID="ddlSlettOppgave" runat="server" DataSourceID="SqlDataSourceSlettOppgave" DataTextField="Tittel" DataValueField="ID" Width="230px" AutoPostBack="True" OnSelectedIndexChanged="ddlSlettOppgave_SelectedIndexChanged"></asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSourceSlettOppgave" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Tittel FROM Oppgave"></asp:SqlDataSource>

    <asp:Button ID="btnSlettOppgave" runat="server" Text="Slett" OnClick="btnSlettOppgave_Click" OnClientClick="ConfirmDelete()"/>
    <br />
    <asp:Label ID="lblSlettOppgaveTilbakemelding" runat="server" Text=""></asp:Label>

    <h1>Redigere oppgave</h1>

    <table>
        <tr>
            <td>* Velg oppgave: </td>
            <td><asp:DropDownList ID="ddlRedigereOppgave" runat="server" DataSourceID="SqlDataSourceRedigereOppgave" DataTextField="Tittel" DataValueField="ID" AutoPostBack="True" OnSelectedIndexChanged="ddlRedigereOppgave_SelectedIndexChanged" Width="245px"></asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSourceRedigereOppgave" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Tittel FROM Oppgave"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>* Velg ny tittel: </td>
            <td><asp:TextBox ID="tbxNyTittel" runat="server" Width="245px"></asp:TextBox></td>
        </tr>
        <tr>
            <td>* Velg ny beskrivelse: </td>
            <td><asp:TextBox ID="tbxNyBeskrivelse" runat="server" TextMode="MultiLine" Width="245px" ></asp:TextBox></td>
        </tr>
        <tr>
            <td>* Nytt tidsestimat: </td>
            <td><asp:TextBox ID="tbxNyEstimertTid" runat="server" TextMode="Number" Width="100px"></asp:TextBox></td>
        </tr>
        <tr>
            <td>* Brukt tid: </td>
            <td><asp:TextBox ID="tbxNyBruktTid" runat="server" TextMode="Number" Width="100px"></asp:TextBox></td>
        </tr>
        <tr>
                <td class="auto-style7" style="width: 161px; height: 57px">* Ny slutt dato: </td>
                <td class="modal-sm" style="width: 290px; height: 57px">
                    <asp:TextBox ID="tbxNySluttDato" runat="server" Height="28px" CssClass="input-sm" Width="245px">Klikk her</asp:TextBox>
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Content/glyphicons/png/glyphicons_045_calendar.png" />
                </td>
        </tr>
    </table>

    <asp:Button ID="btnEndreOppgave" runat="server" Text="Endre" OnClick="btnEndreOppgave_Click" OnClientClick="ConfirmEdit()"/>
    <br />
    <asp:Label ID="lblEndreOppgave" runat="server" Text=""></asp:Label>





    <script src="../Scripts/bootstrap-datepicker.js" type="text/javascript"></script>
    
 <script type="text/javascript">
     $(document).ready(function () {
         var dpStop = $('#<%=dateStopTextBox2.ClientID%>');
         var dpNyStop = $('#<%=tbxNySluttDato.ClientID%>');

         dpStop.datepicker({
             changeMonth: true,
             changeYear: true,
             format: "yyyy-mm-dd",
             startDate: '+0d',
             language: "tr"
         }).on('changeDate', function (ev) {
             $(this).blur();
             $(this).datepicker('hide');
         });

         dpNyStop.datepicker({
             changeMonth: true,
             changeYear: true,
             format: "yyyy-mm-dd",
             dateStart: '+0d',
             language: "tr"
         }).on('changeDate', function (ev) {
             $(this).blur();
             $(this).datepicker('hide');
         });

     }

    );
</script>

    <!-- Confirm dialogbox, Husk å legge til OnClientClick="ConfirmDelete()" på hvilken knapp denne skal benyttes-->
    <script type = "text/javascript">
        function ConfirmDelete() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Er du sikker på at du vil slette denne oppgaven?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }
    </script>

    <!-- Confirm dialogbox, Husk å legge til OnClientClick="ConfirmEdit()" på hvilken knapp denne skal benyttes-->
    <script type = "text/javascript">
        function ConfirmEdit() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Er du sikker på at du vil endre denne oppgaven?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }
    </script>


</asp:Content>
