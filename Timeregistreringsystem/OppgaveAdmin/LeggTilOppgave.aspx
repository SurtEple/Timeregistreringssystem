<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LeggTilOppgave.aspx.cs" Inherits="Timeregistreringssystem.OppgaveAdmin.LeggTilOppgave" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Oppgaver</h1>

    <asp:SqlDataSource ID="SqlDataSourceOppgave" runat="server" ConnectionString="server=kark.hin.no;user id=halvardk;password=halvardk123;database=HLVDKN_DB1" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Prosjekt_ID, Foreldreoppgave_ID, EstimertTid, Tittel, Beskrivelse, Ferdig, Brukt_tid, Dato_begynt, Dato_ferdig FROM Oppgave"></asp:SqlDataSource>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSourceOppgave">
        <Columns>
            <asp:BoundField DataField="Tittel" HeaderText="Tittel" SortExpression="Tittel" />
            <asp:BoundField DataField="Beskrivelse" HeaderText="Beskrivelse" SortExpression="Beskrivelse" />
            <asp:BoundField DataField="EstimertTid" HeaderText="Estimert tid" SortExpression="EstimertTid" />
            <asp:BoundField DataField="Dato_begynt" dataformatstring="{0:d}" htmlencode="false" HeaderText="Dato begynt" SortExpression="Dato_begynt" />
            <asp:BoundField DataField="Dato_ferdig" dataformatstring="{0:d}" htmlencode="false" HeaderText="Dato ferdig" SortExpression="Dato_ferdig" />
            <asp:BoundField DataField="Brukt_tid" HeaderText="Brukt tid" SortExpression="Brukt_tid" />
            <asp:CheckBoxField DataField="Ferdig" HeaderText="Ferdig" SortExpression="Ferdig" />
            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" Visible="False" />
            <asp:BoundField DataField="Prosjekt_ID" HeaderText="Prosjekt_ID" SortExpression="Prosjekt_ID" Visible="False" />
            <asp:BoundField DataField="Foreldreoppgave_ID" HeaderText="Foreldreoppgave_ID" SortExpression="Foreldreoppgave_ID" Visible="False" />
        </Columns>
    </asp:GridView>

    <h1></h1>
    <h1>Ny Oppgave</h1>
        
     <asp:SqlDataSource ID="SqlDataSourceHovedOppgaveDropDown" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Prosjekt_ID, Tittel FROM Oppgave"></asp:SqlDataSource>
        
    <br />
         <asp:Label ID="lblProsjekt" Text="* Velg prosjektet denne oppgaven tilhører" runat="server"></asp:Label>
    <br />
    <asp:DropDownList ID="ddlForeldreProsjekt" runat="server" DataSourceID="SqlDataSourceForeldreProsjekt" DataTextField="Navn" DataValueField="ID" Height="26px" Width="323px">
                    </asp:DropDownList>

     <br />

    <br />

        <asp:Label ID="lblForeldreOppgave" Text="Velg Hovedoppgaven denne oppgaven skal tilhøre" runat="server"></asp:Label>
        <br />
        <asp:DropDownList ID="ddlForeldreOppgave" runat="server" DataSourceID="SqlDataSourceHovedOppgaveDropDown" DataTextField="Tittel" DataValueField="ID" AppendDataBoundItems="True" Height="26px" Width="323px">
                    </asp:DropDownList>
        <br />

   


    <asp:SqlDataSource ID="SqlDataSourceForeldreProsjekt" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Navn FROM Prosjekt"></asp:SqlDataSource>


    <br />


    <table>
        <tr>
            <td>Tittel: </td>
            <td> <asp:TextBox ID="tbxOppgaveTittel" runat="server" Width="190px"></asp:TextBox></td>
        </tr>
        <tr>
            <td>Beskrivelse: </td>
            <td><asp:TextBox ID="tbxOppgaveBeskrivelse" runat="server" TextMode="MultiLine" Width="190px"></asp:TextBox></td>
        </tr>
        <tr>
            <td>Estimert tid: </td>
            <td><asp:TextBox ID="tbxOppgaveEstimertTid" runat="server" TextMode="Number" Width="190px"></asp:TextBox> Timer</td>
        </tr>
        <tr>
            <td class="auto-style7" style="width: 161px; height: 53px">Dato Start</td>
                <td class="modal-sm" style="width: 290px; height: 53px">
                    <asp:TextBox ID="dateStartTextBox" runat="server" Height="28px" CssClass="bootstrap.css" Width="125px">Klikk her</asp:TextBox>
                 
                    <asp:Image ID="startCal" runat="server" ImageUrl="~/Content/glyphicons/png/glyphicons_045_calendar.png" />
                 
                </td>
        </tr> 
        <tr>
                <td class="auto-style7" style="width: 161px; height: 57px"> Estimert Slutt dato</td>
                <td class="modal-sm" style="width: 290px; height: 57px">
                    <asp:TextBox ID="dateStopTextBox" runat="server" Height="28px" CssClass="bootstrap.css" Width="125px">Klikk her</asp:TextBox>
                    <asp:Image ID="Image3" runat="server" ImageUrl="~/Content/glyphicons/png/glyphicons_045_calendar.png" />
                </td>

                <td>
                  <asp:CompareValidator id="CompareValidatorSluttDatoOppgaver" runat="server"
                    ForeColor="Red"
                    ControlToValidate="dateStopTextBox"
                    ControlToCompare="dateStartTextBox"
                    Type="Date"       
                    Operator="GreaterThanEqual"      
                    ErrorMessage="Sluttdato kan ikke være før startdatoen.">
                  </asp:CompareValidator >
                </td>

            </tr>
    </table>

    <br />
    <asp:Button ID="btnLagre" runat="server" CssClass="bootstrap.css"  Text="Lagre" Width="119px" OnClick="btnLagre_Click" />
    <br />
    <asp:Label ID="lblTilbakemelding" Text="" runat="server"></asp:Label>


        

    <script src="../Scripts/bootstrap-datepicker.js" type="text/javascript"></script>
    
 <script type="text/javascript">
     $(document).ready(function () {
         var dpStart = $('#<%=dateStartTextBox.ClientID%>');
         var dpStop = $('#<%=dateStopTextBox.ClientID%>');

         dpStart.datepicker({
             changeMonth: true,
             changeYear: true,
             format: "yyyy-mm-dd",
             startDate: '+0d',
             language: "tr"
         }).on('changeDate', function (ev) {
             $(this).blur();
             $(this).datepicker('hide');
         });

         dpStop.datepicker({
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
