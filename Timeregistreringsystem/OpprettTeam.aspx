<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OpprettTeam.aspx.cs" Inherits="Timeregistreringssystem.OpprettTeam" %>

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
        <asp:DropDownList ID="ddlTeamleder" runat="server" Height="20px" Width="200px">
        </asp:DropDownList>
        <br />
        <br />
        <asp:Button ID="btnAvbryt" runat="server" OnClick="btnAvbryt_Click" style="height: 26px" Text="Avbryt" Width="80px" />
&nbsp;
        <asp:Button ID="btnLagreNyttTeam" runat="server" Text="Lagre" OnClick="btnLagreNyttTeam_Click" Width="80px" />
        &nbsp;&nbsp;&nbsp; <asp:Label ID="labelTilbakemelding" runat="server" ForeColor="#CC0000"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <br />
    </form>
</body>
</html>
