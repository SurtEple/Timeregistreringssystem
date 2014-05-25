<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BrukerForside.aspx.cs" Inherits="Timeregistreringssystem.BrukerForside" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Velkommen, <%= (string)Session["Brukernavn"] %> </h1>
    <h2>Velg din oppgave.</h2>

    <table>
    
         <!-- Hvis du er med i flere team, velg ett -->
        <tr>
            <td style="width: 352px" class="modal-sm">
                <asp:Label ID="lblVelgTeam" runat="server" Text="Velg den gruppen du vil jobbe med"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlVelgTeam" runat="server" DataSourceID="SqlDataSourceDDLVelgTeam" DataTextField="Beskrivelse" DataValueField="ID" AppendDataBoundItems="true" CssClass="dropdown">
                    <asp:ListItem Text="-- Velg et Team --" Value=""></asp:ListItem>
                </asp:DropDownList>

                <asp:SqlDataSource ID="SqlDataSourceDDLVelgTeam" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM Team WHERE Team.ID in (SELECT Team_ID FROM KoblingBrukerTeam WHERE Bruker_ID = @ID)"></asp:SqlDataSource>

            </td>
            <td>
                <asp:Button ID="btnTeamBekreft" runat="server" Text="Bekreft" OnClick="btnTeamBekreft_Click" CssClass="btn" />
            </td>
        </tr>

        <tr>
            <td>
                <asp:Label ID="lblIkkeValgtTeam" runat="server" Text="Velg et Team fra listen" Visible="False" ForeColor="Red"></asp:Label>
            </td>
        </tr>

         <!-- Velg Prosjekt -->
         <tr>
             <td style="height: 100px; width: 352px;">
                 <asp:Label ID="lblVelgProsjekt" runat="server" Text="Velg Prosjektet du vil jobbe med i dag"></asp:Label>
             </td>
             <td style="height: 100px">
                <asp:DropDownList ID="ddlVelgProsjekt" runat="server" DataSourceID="SqlDataSourceDDLVelgProsjekt" DataTextField="Navn" DataValueField="ID" AppendDataBoundItems="true" CssClass="dropdown">
                    <asp:ListItem Text="-- Velg Prosjekt --" Value="" ></asp:ListItem>
                </asp:DropDownList>
                 <asp:SqlDataSource ID="SqlDataSourceDDLVelgProsjekt" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT * FROM Prosjekt WHERE Prosjekt.ID in (SELECT Prosjekt_ID FROM KoblingTeamProsjekt WHERE Team_ID = @TeamID)"></asp:SqlDataSource>
             </td>
             <td style="height: 100px">
                 <asp:Button ID="btnProsjektBekreft" runat="server" Text="Bekreft" OnClick="btnProsjektBekreft_Click" CssClass="btn"  />
             </td>
        </tr>

        <!-- Valgte ikke et Prosjekt -->  
        <tr>
            <td>
                <asp:Label ID="lblIkkeValgtProsjekt" runat="server" Text="Velg et Prosjekt fra listen" Visible="False" ForeColor="Red"></asp:Label>
            </td>
        </tr>


        <!-- Velg Hovedoppgave -->
        <tr>
            <td style="width: 352px" class="modal-sm">
                <asp:Label ID="lblVelgHovedoppgave" runat="server" Text="Velg hovedoppgaven du vil jobbe med i dag"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlVelgHovedoppgave" runat="server" DataSourceID="SqlDataSourceVelgHovedoppgave" DataTextField="Tittel" DataValueField="ID" AppendDataBoundItems="true" CssClass="dropdown">
                    <asp:ListItem Text="-- Velg Oppgave -- " Value ="" ></asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSourceVelgHovedoppgave" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Foreldreoppgave_ID, Prosjekt_ID, Tittel, Beskrivelse, Ferdig, Brukt_tid AS &quot;Brukt tid&quot;, DATE_FORMAT(Dato_begynt, '%Y-%m-%d') AS &quot;Startdato&quot;, DATE_FORMAT(Dato_ferdig, '%Y-%m-%d') AS &quot;Sluttdato&quot; FROM `Oppgave` WHERE `Foreldreoppgave_ID` LIKE 0 AND Prosjekt_ID = @Prosjekt_ID"></asp:SqlDataSource>
            </td>
            <td>
                <asp:Button ID="btnHovedoppgaveBekreft" runat="server" Text="Bekreft" OnClick="btnHovedoppgaveBekreft_Click" CssClass="btn" />
            </td>
        </tr> 

    </table>

    <!-- Valgt Prosjekt har ingen Oppgaver tilordnet -->
    <asp:Label ID="lblIngenOppgaver" runat="server" Text="Velg en oppgave fra listen. (Hvis listen er tom så har ikke dette prosjektet noen oppgaver)" Visible="False" ForeColor="Red"></asp:Label>
          
    <br /> 

    <!-- Velg Oppgave -->
 
            <asp:GridView ID="GridViewVelgOppgave" runat="server" AutoGenerateColumns="False"
        CssClass="table" AllowPaging="True" AllowSorting="True" Width="80%" OnSelectedIndexChanged="GridViewVelgHovedppgave_SelectedIndexChanged" DataSourceID="SqlDataSourceVelgOppgave" DataKeyNames="ID">
                <Columns>
                    <asp:CommandField SelectText="Velg" ShowSelectButton="True" />
                    <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" />
                    <asp:BoundField DataField="Oppgave" HeaderText="Oppgave" SortExpression="Oppgave" />
                    <asp:BoundField DataField="Beskrivelse" HeaderText="Beskrivelse" SortExpression="Beskrivelse" />
                    <asp:BoundField DataField="Brukt_tid" HeaderText="Brukt_tid" SortExpression="Brukt_tid" />
                    <asp:CheckBoxField DataField="Ferdig" HeaderText="Ferdig" SortExpression="Ferdig" />
                    <asp:BoundField DataField="Startdato" HeaderText="Startdato" SortExpression="Startdato" />
                    <asp:BoundField DataField="Sluttdato" HeaderText="Sluttdato" SortExpression="Sluttdato" />
                </Columns>
        </asp:GridView>

        <asp:SqlDataSource ID="SqlDataSourceVelgOppgave" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Tittel AS Oppgave, Beskrivelse, Brukt_tid, Ferdig, DATE_FORMAT(Dato_begynt, '%Y-%m-%d') AS Startdato, DATE_FORMAT(Dato_ferdig, '%Y-%m-%d') AS Sluttdato FROM Oppgave
 WHERE (Foreldreoppgave_ID = @Foreldreoppgave_ID)"></asp:SqlDataSource>

    <br />

    <asp:Button ID="btnTilbakeTilTeam" runat="server" Text="Tilbake" OnClick="btnTilbakeTilTeam_Click" />

    </asp:Content>
