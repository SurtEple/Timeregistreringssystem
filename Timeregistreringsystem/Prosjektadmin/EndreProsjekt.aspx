<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EndreProsjekt.aspx.cs" Inherits="Timeregistreringssystem.Prosjektadmin.EndreProsjekt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Endre/Slette Prosjekt</h1>

    <h3>Velg et prosjekt fra listen</h3>

    <div>
        <asp:GridView ID="GridViewEditProject" runat="server" DataSourceID="SqlDataSource1" CssClass="table" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ID" OnSelectedIndexChanged="GridViewEditProject_SelectedIndexChanged" OnRowDeleting="GridViewEditProject_RowDeleting">
            <Columns>
                <asp:CommandField DeleteText="Slett" SelectText="Velg" ShowDeleteButton="True" ShowSelectButton="True" />
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                <asp:BoundField DataField="Navn" HeaderText="Navn" SortExpression="Navn" />
                <asp:BoundField DataField="Ansvarlig" HeaderText="Ansvarlig" SortExpression="Ansvarlig" />
                <asp:BoundField DataField="Oppsummering" HeaderText="Oppsummering" SortExpression="Oppsummering" />
                <asp:BoundField DataField="Beskrivelse Aktiv Fase" HeaderText="Beskrivelse Aktiv Fase" SortExpression="Beskrivelse Aktiv Fase" />
                <asp:BoundField DataField="Beskrivelse neste milepæl" HeaderText="Beskrivelse neste milepæl" SortExpression="Beskrivelse neste milepæl" />
                <asp:BoundField DataField="Beskrivelse Neste Fase" HeaderText="Beskrivelse Neste Fase" SortExpression="Beskrivelse Neste Fase" />
            </Columns>
        </asp:GridView>
       

        <h1>&nbsp;</h1>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" 
                        SelectCommand="SELECT Prosjekt.ID, Prosjekt.Navn, Bruker.Brukernavn AS Ansvarlig, Prosjekt.Oppsummering, 

(SELECT Beskrivelse FROM Fase WHERE aktiv=true AND Prosjekt_ID = Prosjekt.ID) AS &quot;Beskrivelse Aktiv Fase&quot;, 

Milepael.Beskrivelse AS &quot;Beskrivelse neste milepæl&quot;,
Fase.Beskrivelse AS &quot;Beskrivelse Neste Fase&quot;

FROM Prosjekt, Fase, Bruker, Milepael 
WHERE Prosjekt.Neste_Fase = Fase.ID 
AND Prosjekt.ID &gt; 0 
AND Bruker.ID=Prosjekt.ansvarligID 
AND Milepael.ID=Prosjekt.Neste_Milepæl
ORDER BY Prosjekt.ID" DeleteCommand="DELETE FROM Prosjekt WHERE (ID = @ID)" UpdateCommand="UPDATE Prosjekt SET Navn = @Prosjekt.Navn, Oppsummering = @Prosjekt.Oppsummering"></asp:SqlDataSource>

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
                <td class="auto-style6" style="width: 110px">Ny neste fase: </td>
                <td class="auto-style5">
                    <asp:DropDownList ID="DropDownListNyNesteFase" runat="server" DataSourceID="SqlDataSourceNyNesteFase" DataTextField="Navn" DataValueField="ID" Height="34px" Width="138px" CssClass="dropdown">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceNyNesteFase" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Navn FROM Fase WHERE Prosjekt_ID=@Prosjekt_ID"></asp:SqlDataSource>
                </td>
            </tr>

             <tr>
                <td class="auto-style6" style="width: 110px">Ny Neste milepæl: </td>
                <td class="auto-style5">
                    <asp:DropDownList ID="DropDownListMilestone" runat="server" DataSourceID="SqlDataSourceNyMilestone" DataTextField="Beskrivelse" DataValueField="ID" Height="34px" Width="138px" CssClass="dropdown">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceNyMilestone" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Beskrivelse FROM Milepael WHERE ProsjektID=@Prosjekt_ID"></asp:SqlDataSource>
                &nbsp;</td>
            </tr>


            </table>



            <br />
            <asp:Button ID="btnLagreNewProject" runat="server" OnClick="btnLagreNewProject_Click" Text="Lagre" Width="103px" Height="36px" CssClass="btn" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
        
            <asp:Label ID="resultLabel" runat="server"></asp:Label>

       
        

            <br />

        </div>

        <br />
        <br />
</asp:Content>