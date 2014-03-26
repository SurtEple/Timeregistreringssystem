<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OpprettTeam.aspx.cs" Inherits="Timeregistreringssystem.TeamAdministrasjon.OpprettTeam" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h1> Opprett nytt team </h1>
        <p> &nbsp;</p>
        <p> Navn&nbsp; </p>
        <asp:TextBox ID="tbNavn" runat="server" Height="20px" Width="200px"></asp:TextBox>
        &nbsp;&nbsp;
        <br />
        <br />
        Teamleder<br />
        <br />

    </div>
        <asp:DropDownList ID="ddlTeamleder" runat="server" Height="20px" Width="200px" DataSourceID="SqlDataSource1" DataTextField="Navn" DataValueField="ID">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, CONCAT(Fornavn, &quot; &quot;, Mellomnavn, &quot; &quot;, Etternavn) &quot;Navn&quot; FROM Bruker"></asp:SqlDataSource>
        <br />
        <br />
        <asp:Button ID="btnAvbryt" runat="server" OnClick="btnAvbryt_Click" Text="Avbryt" Width="80px" Height="28px" />
&nbsp;
        <asp:Button ID="btnLagreNyttTeam" runat="server" Text="Lagre" OnClick="btnLagreNyttTeam_Click" Width="80px" Height="29px" />
        &nbsp;&nbsp;&nbsp; <asp:Label ID="labelTilbakemelding" runat="server" ForeColor="#CC0000"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <br />
    </form>
</body>
</html>
