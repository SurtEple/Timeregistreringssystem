<%@ Page Title="Opprett nytt team" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OpprettTeam.aspx.cs" Inherits="Timeregistreringssystem.TeamAdministrasjon.OpprettTeam" %>

<asp:Content ID="OpprettTeamContent" ContentPlaceHolderID="MainContent" runat="server">

        <h1><%: Title %></h1>

        <p> Navn&nbsp; </p>
        <asp:TextBox ID="tbNavn" runat="server" Height="20px" Width="200px"></asp:TextBox>
        
        <br />
        <br />
        Teamleder<br />
        <br />

        <asp:DropDownList ID="ddlTeamleder" runat="server" Height="20px" Width="200px" DataSourceID="SqlDataSource1" DataTextField="Navn" DataValueField="ID">
        </asp:DropDownList>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" 
            SelectCommand="SELECT ID, CONCAT(Fornavn, &quot; &quot;, Mellomnavn, &quot; &quot;, Etternavn) &quot;Navn&quot; FROM Bruker"></asp:SqlDataSource>
        
        <br />
        <br />

        <asp:Button ID="btnAvbryt" runat="server" OnClick="btnAvbryt_Click" Text="Avbryt" Width="80px" Height="28px" />

        <asp:Button ID="btnLagreNyttTeam" runat="server" Text="Lagre" OnClick="btnLagreNyttTeam_Click" Width="80px" Height="29px" />

        <asp:Label ID="labelTilbakemelding" runat="server" ForeColor="#CC0000"></asp:Label>

        <br />

</asp:Content>
