<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EndreProsjekt.aspx.cs" Inherits="Timeregistreringssystem.Prosjektadmin.EndreProsjekt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Endre/Slette Prosjekt</h1>

    <h3>Velg et prosjekt fra listen</h3>

    <div>
        <asp:GridView ID="GridViewEditProject" runat="server" DataSourceID="SqlDataSource1" CssClass="table" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ID" OnSelectedIndexChanged="GridViewEditProject_SelectedIndexChanged">
            <Columns>
                <asp:CommandField DeleteText="Slett" SelectText="Velg" ShowDeleteButton="True" ShowSelectButton="True" />
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                <asp:BoundField DataField="ProsjektNavn" HeaderText="ProsjektNavn" SortExpression="ProsjektNavn" />
                <asp:BoundField DataField="Prosjektansvarlig" HeaderText="Prosjektansvarlig" SortExpression="Prosjektansvarlig" />
                <asp:BoundField DataField="Oppsummering" HeaderText="Oppsummering" SortExpression="Oppsummering" />
                <asp:BoundField DataField="Aktiv Fase" HeaderText="Aktiv Fase" SortExpression="Aktiv Fase" />
                <asp:BoundField DataField="Neste milepæl" HeaderText="Neste milepæl" SortExpression="Neste milepæl" />
                <asp:BoundField DataField="Neste Fase " HeaderText="Neste Fase " SortExpression="Neste Fase " />
            </Columns>
        </asp:GridView>
       

        <h1>&nbsp;</h1>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" 
                        SelectCommand="SELECT Prosjekt.ID, Prosjekt.Navn AS ProsjektNavn, Bruker.Brukernavn AS Prosjektansvarlig, Prosjekt.Oppsummering, (SELECT Beskrivelse FROM Fase WHERE aktiv=1 AND Prosjekt_ID = Prosjekt.ID) AS &quot;Aktiv Fase&quot;, Oppgave.Tittel AS &quot;Neste milepæl&quot;, Fase.Beskrivelse AS &quot; Neste Fase &quot; FROM Prosjekt LEFT OUTER JOIN Milepæl ON Prosjekt.`Neste_Milepæl` = Milepæl.ID LEFT OUTER JOIN Oppgave ON Milepæl.Oppgave_ID = Oppgave.ID LEFT OUTER JOIN Fase ON Prosjekt.Neste_Fase = Fase.ID LEFT OUTER JOIN Bruker ON Bruker.ID=Prosjekt.ansvarligID WHERE Prosjekt.ID&gt;0 ORDER BY Prosjekt.ID DESC" DeleteCommand="DELETE FROM Prosjekt WHERE (ID = @ID)" UpdateCommand="UPDATE Prosjekt SET Navn = @ProsjektNavn, Oppsummering =@ProsjektOppsummering, ansvarligID =@AnsvarligID, Neste_Fase =@NesteFase, `Neste_Milepæl` = @NesteMil
WHERE ID=@ID"></asp:SqlDataSource>

        <br />

        

    </div>
        <div>
            <h1>Redigere Prosjekt</h1>
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
                <td class="auto-style6" style="height: 102px; width: 110px;">Ny oppsummering: </td>
                <td class="auto-style5" style="height: 102px">
                    <asp:TextBox ID="textBoxNewOppsummering" runat="server" TextMode="MultiLine" CssClass="input-group-lg" Height="68px" Width="168px"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td class="auto-style6" style="width: 110px; height: 103px;">Ny neste fase: </td>
                <td class="auto-style5" style="height: 103px">
                    <asp:DropDownList ID="DropDownListNyNesteFase" runat="server" DataSourceID="SqlDataSourceNyNesteFase" DataTextField="Navn" DataValueField="ID" Height="34px" Width="138px" CssClass="dropdown">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceNyNesteFase" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Navn FROM Fase WHERE Prosjekt_ID=@Prosjekt_ID"></asp:SqlDataSource>
                </td>
            </tr>
             
             <tr>
                <td class="auto-style6" style="width: 110px">Ny Neste milepæl: </td>
                <td class="auto-style5">
                    <asp:DropDownList ID="DropDownListMilestone" runat="server" DataSourceID="SqlDataSourceNyMilestone" DataTextField="Tittel" DataValueField="ID" Height="34px" Width="138px" CssClass="dropdown">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceNyMilestone" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Oppgave.ID, Oppgave.Tittel FROM Prosjekt INNER JOIN Oppgave ON Prosjekt.ID = Oppgave.Prosjekt_ID WHERE (Prosjekt.ID = @Prosjekt_ID) AND (Oppgave.Foreldreoppgave_ID = 0) AND (Oppgave.Ferdig = 0)"></asp:SqlDataSource>
                &nbsp;</td>
            </tr>


            </table>



            <br />
            <asp:Button ID="btnLagreNewProject" runat="server" OnClick="btnLagreNewProject_Click" OnClientClick="Confirm()" Text="Lagre" Width="103px" Height="36px" CssClass="btn" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
        
            <asp:Label ID="resultLabel" runat="server"></asp:Label>

       
        

            <br />

        </div>

        <br />
        <br />


    <!-- Confirm dialogbox, Husk å legge til OnClientClick="Confirm()" på hvilken knapp denne skal benyttes-->
    <script type = "text/javascript">
        function Confirm() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Er du sikker på at du vil endre dette prosjektet?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }
    </script>


</asp:Content>