<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LeggTilFase.aspx.cs" Inherits="Timeregistreringssystem.Prosjektadmin.LeggTilFase" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2> Faser</h2>
      <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSourceFaser" AutoGenerateColumns="False" DataKeyNames="ID,ProsjektID" CssClass="table">
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                <asp:BoundField DataField="Navn" HeaderText="Navn" SortExpression="Navn" />
                <asp:BoundField DataField="Dato_startet" HeaderText="Dato_startet" SortExpression="Dato_startet" />
                <asp:BoundField DataField="Dato_sluttet" HeaderText="Dato_sluttet" SortExpression="Dato_sluttet" />
                <asp:CheckBoxField DataField="Aktiv" HeaderText="Aktiv" SortExpression="Aktiv" />
                <asp:BoundField DataField="Beskrivelse" HeaderText="Beskrivelse" SortExpression="Beskrivelse" />
                <asp:BoundField DataField="ProsjektNavn" HeaderText="ProsjektNavn" SortExpression="ProsjektNavn" />
                <asp:BoundField DataField="ProsjektID" HeaderText="ProsjektID" SortExpression="ProsjektID" InsertVisible="False" ReadOnly="True" />
            </Columns>
        </asp:GridView>
       
    <asp:SqlDataSource ID="SqlDataSourceFaser" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Fase.ID, Fase.Navn, Fase.Dato_startet, Fase.Dato_sluttet, Fase.Aktiv, Fase.Beskrivelse, Prosjekt.Navn AS ProsjektNavn, Prosjekt.ID AS ProsjektID FROM Fase INNER JOIN Prosjekt ON Fase.Prosjekt_ID = Prosjekt.ID"></asp:SqlDataSource>
       
    <br />
    <br />

    <h2> Opprett en ny fase</h2>
    <asp:SqlDataSource ID="SqlDataSourceProsjektIDDropDown" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Navn FROM Prosjekt"></asp:SqlDataSource>
<br />


  <table>
            <tr>
                <td class="auto-style7" style="width: 161px; height: 35px">Velg ditt prosjekt:&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td class="modal-sm" style="width: 290px; height: 35px">
                    <asp:DropDownList ID="prosjektDropDownList" runat="server" DataSourceID="SqlDataSourceProsjektIDDropDown" DataTextField="Navn" DataValueField="ID" Height="30px" CssClass="dropdown">
        </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style7" style="width: 161px; height: 58px">Fasenavn:</td>
                <td class="modal-sm" style="width: 290px; height: 58px">
                <asp:TextBox ID="faseNavnTextBox" runat="server" Height="28px" CssClass="input-sm"></asp:TextBox>
                </td>
            </tr>
              <tr>
                <td class="auto-style7" style="width: 161px; height: 53px">Dato Start</td>
                <td class="modal-sm" style="width: 290px; height: 53px">
                    <asp:TextBox ID="dateStartTextBox" runat="server" Height="28px" CssClass="input-sm">Klikk her</asp:TextBox>
                 
                    <asp:Image ID="startCal" runat="server" ImageUrl="~/Content/glyphicons/png/glyphicons_045_calendar.png" />
                 
                </td>
            </tr>
        <tr>
                <td class="auto-style7" style="width: 161px; height: 57px">Dato Slutt</td>
                <td class="modal-sm" style="width: 290px; height: 57px">
                    <asp:TextBox ID="dateStopTextBox" runat="server" Height="28px" CssClass="input-sm">Klikk her</asp:TextBox>
                    <asp:Image ID="Image3" runat="server" ImageUrl="~/Content/glyphicons/png/glyphicons_045_calendar.png" />
                </td>
            </tr>
        <tr>
                <td class="auto-style7" style="width: 161px; height: 40px">Status:</td>
                <td class="modal-sm" style="width: 290px; height: 40px">
                    <asp:DropDownList ID="statusDropDownList" runat="server" Height="30px" CssClass="dropdown">
                        <asp:ListItem Selected="True" Value="Aktiv">Aktiv</asp:ListItem>
                        <asp:ListItem Value="Inaktiv">Inaktiv</asp:ListItem>
                        <asp:ListItem>Utsatt</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>

          <tr>
                <td class="auto-style7" style="width: 161px; height: 91px">Beskrivelse: 
                    <br />
                </td>
                <td class="modal-sm" style="width: 290px; height: 91px">
                <asp:TextBox ID="beskrivelseTextBox" runat="server" Height="68px" TextMode="MultiLine" CssClass="input-lg"></asp:TextBox>
                    <br />
                </td>
            </tr>

        </table>
    <br /><asp:Button ID="btnLagre" runat="server" CssClass="btn"  Text="Lagre" Width="119px" OnClick="btnLagre_Click" />
    
    <br />

    

    <script src="../Scripts/bootstrap-datepicker.js" type="text/javascript"></script>
    
 <script type="text/javascript">
     $(document).ready(function ()
     {
         var dpStart = $('#<%=dateStartTextBox.ClientID%>');
         var dpStop = $('#<%=dateStopTextBox.ClientID%>');

         dpStart.datepicker({
            changeMonth: true,
            changeYear: true,
            format: "dd.mm.yyyy",
            language: "tr"
        }).on('changeDate', function (ev) {
            $(this).blur();
            $(this).datepicker('hide');
        });

        dpStop.datepicker({
            changeMonth: true,
            changeYear: true,
            format: "dd.mm.yyyy",
            language: "tr"
        }).on('changeDate', function (ev) {
            $(this).blur();
            $(this).datepicker('hide');
        });

     }

    );
</script>

    

</asp:Content>
