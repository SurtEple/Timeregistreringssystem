﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LeggTilFase.aspx.cs" Inherits="Timeregistreringssystem.Prosjektadmin.LeggTilFase" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2> Faser</h2>
      <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSourceFaser" AutoGenerateColumns="False" DataKeyNames="ID,ProsjektID" CssClass="table">
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                <asp:BoundField DataField="Navn" HeaderText="Navn" SortExpression="Navn" />
                <asp:BoundField DataField="ProsjektID" HeaderText="ProsjektID" SortExpression="ProsjektID" InsertVisible="False" ReadOnly="True" />
                <asp:BoundField DataField="ProsjektNavn" HeaderText="ProsjektNavn" SortExpression="ProsjektNavn" />
                <asp:BoundField DataField="StartDato" HeaderText="StartDato" SortExpression="StartDato" />
                <asp:BoundField DataField="SluttDato" HeaderText="SluttDato" SortExpression="SluttDato" />
                <asp:CheckBoxField DataField="Aktiv" HeaderText="Aktiv" SortExpression="Aktiv" />
                <asp:BoundField DataField="Beskrivelse" HeaderText="Beskrivelse" SortExpression="Beskrivelse" />
            </Columns>
        </asp:GridView>
       
    <asp:SqlDataSource ID="SqlDataSourceFaser" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Fase.ID, Fase.Navn, Prosjekt.ID AS ProsjektID, Prosjekt.Navn AS ProsjektNavn, DATE_FORMAT(Fase.Dato_startet , '%d.%m.%Y') AS &quot;StartDato&quot;, DATE_FORMAT(Fase.Dato_sluttet , '%d.%m.%Y') AS &quot;SluttDato&quot;, Fase.Aktiv, Fase.Beskrivelse FROM Fase

 INNER JOIN Prosjekt ON Fase.Prosjekt_ID = Prosjekt.ID
WHERE Fase.Prosjekt_ID &gt; 0
ORDER BY Prosjekt.ID
"></asp:SqlDataSource>
       
    <br />
    <br />

    <h2> Opprett en ny fase</h2>
    <asp:SqlDataSource ID="SqlDataSourceProsjektIDDropDown" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Navn FROM Prosjekt
WHERE ID &gt; 0"></asp:SqlDataSource>
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
