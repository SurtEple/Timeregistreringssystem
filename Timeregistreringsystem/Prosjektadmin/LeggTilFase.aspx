<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LeggTilFase.aspx.cs" Inherits="Timeregistreringssystem.Prosjektadmin.LeggTilFase" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2> Faser</h2>
      <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSourceFaser" AutoGenerateColumns="False" 
          DataKeyNames="ID" CssClass="table" AllowPaging="True" AllowSorting="True" OnRowUpdating="GridView1_RowUpdating" Width="80%" OnRowDeleting="GridView1_RowDeleting">
            <Columns>
                <asp:CommandField CancelText="Avbryt" DeleteText="Slett" EditText="Endre" ShowDeleteButton="True" ShowEditButton="True" UpdateText="Lagre" />
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" Visible="False" />
                <asp:BoundField DataField="Navn" HeaderText="Fasenavn" SortExpression="Navn" />
                <asp:BoundField DataField="ProsjektID" HeaderText="ProsjektID" SortExpression="ProsjektID" ReadOnly="True" Visible="False" />
                <asp:BoundField DataField="ProsjektNavn" HeaderText="Prosjektnavn" SortExpression="ProsjektNavn" ReadOnly="True" />
                <asp:BoundField DataField="StartDato" HeaderText="StartDato" SortExpression="StartDato"/>
                <asp:BoundField DataField="SluttDato" HeaderText="SluttDato" SortExpression="SluttDato" />
                <asp:CheckBoxField DataField="Aktiv" HeaderText="Aktiv" SortExpression="Aktiv" />
                <asp:BoundField DataField="Beskrivelse" HeaderText="Beskrivelse" SortExpression="Beskrivelse" />
            </Columns>
        </asp:GridView>
       
    <asp:SqlDataSource ID="SqlDataSourceFaser" runat="server" 
        ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" 
        SelectCommand="SELECT Fase.ID, Fase.Navn, Fase.Prosjekt_ID AS ProsjektID, Prosjekt.Navn AS ProsjektNavn, 
        DATE_FORMAT(Fase.Dato_startet , '%Y-%m-%d') AS &quot;StartDato&quot;, DATE_FORMAT(Fase.Dato_sluttet , '%Y-%m-%d') 
        AS &quot;SluttDato&quot;, Fase.Aktiv, Fase.Beskrivelse FROM Fase
         INNER JOIN Prosjekt ON Fase.Prosjekt_ID = Prosjekt.ID
        WHERE Fase.Prosjekt_ID &gt; 0
        ORDER BY Prosjekt.ID" 
        
        UpdateCommand="UPDATE Fase SET Navn = @Navn, Dato_startet = @StartDato, 
        Dato_sluttet = @SluttDato, Aktiv = @Aktiv, Beskrivelse = @Beskrivelse  WHERE ID = @ID" DeleteCommand="DELETE FROM Fase WHERE ID=@ID" InsertCommand="INSERT INTO Fase (Navn, Dato_Startet, Dato_sluttet,Prosjekt_ID, Beskrivelse) 
VALUES (@Navn, @StartDato, @SluttDato, @ProsjektID, @Beskrivelse)">


    </asp:SqlDataSource>
       
    <br />
    <br />

    <h2> Opprett en ny fase</h2>
    <asp:SqlDataSource ID="SqlDataSourceProsjektIDDropDown" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Navn FROM Prosjekt
WHERE ID &gt; 0"></asp:SqlDataSource>
<br />


  <table>
            <tr>
                <td class="auto-style7" style="width: 661px; height: 35px">Velg prosjektet som denne fasen skal tilhøre: </td>
                <td class="modal-sm" style="width: 290px; height: 35px">
                    <asp:DropDownList ID="prosjektDropDownList" runat="server" DataSourceID="SqlDataSourceProsjektIDDropDown" DataTextField="Navn" DataValueField="ID" Height="30px" CssClass="dropdown">
        </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style7" style="width: 661px; height: 58px">Fasenavn:</td>
                <td class="modal-sm" style="width: 290px; height: 58px">
                <asp:TextBox ID="faseNavnTextBox" runat="server" Height="28px" CssClass="input-sm"></asp:TextBox>
                </td>
            </tr>
              <tr>
                <td class="auto-style7" style="width: 661px; height: 53px">Dato Start</td>
                <td class="modal-sm" style="width: 290px; height: 53px">
                    <asp:TextBox ID="dateStartTextBox" runat="server" Height="28px" CssClass="input-sm">Klikk her</asp:TextBox>
                 
                    <asp:Image ID="startCal" runat="server" ImageUrl="~/Content/glyphicons/png/glyphicons_045_calendar.png" />
                 
                </td>
            </tr>
        <tr>
                <td class="auto-style7" style="width: 661px; height: 57px">Dato Slutt</td>
                <td class="modal-sm" style="width: 290px; height: 57px">
                    <asp:TextBox ID="dateStopTextBox" runat="server" Height="28px" CssClass="input-sm">Klikk her</asp:TextBox>
                    <asp:Image ID="Image3" runat="server" ImageUrl="~/Content/glyphicons/png/glyphicons_045_calendar.png" />
                </td>
            </tr>

          <tr>
                <td class="auto-style7" style="width: 661px; height: 91px">Beskrivelse: 
                    <br />
                </td>
                <td class="modal-sm" style="width: 290px; height: 91px">
                <asp:TextBox ID="beskrivelseTextBox" runat="server" Height="181px" TextMode="MultiLine" CssClass="input-lg" Width="174px"></asp:TextBox>
                    <br />
                </td>
            </tr>

        </table>
    <br /><asp:Button ID="btnLagre" runat="server" CssClass="btn"  Text="Lagre" Width="119px" OnClick="btnLagre_Click" OnClientClick = "Confirm()" />
    
    <asp:Label ID="resultLabel" runat="server"></asp:Label>
    
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
            format: "yyyy-mm-dd",
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

<script type = "text/javascript">
    function Confirm() {
        var confirm_value = document.createElement("INPUT");
        confirm_value.type = "hidden";
        confirm_value.name = "confirm_value";
        if (confirm("Er du sikker på at du vil legge til denne fasen?")) {
            confirm_value.value = "Yes";
        } else {
            confirm_value.value = "No";
        }
        document.forms[0].appendChild(confirm_value);
    }
</script>

    

</asp:Content>
