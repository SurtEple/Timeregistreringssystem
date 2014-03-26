<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LeggTilBruker.aspx.cs" Inherits="Timeregistreringssystem.LeggTilBruker" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="lblLeggTilBruker" runat="server" Text="Legg til bruker"></asp:Label>
        <br />
        <br />
        <asp:Label ID="lblBrukernavn" runat="server" Text="Brukernavn"></asp:Label>
        <asp:TextBox ID="tbBrukernavn" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="lblPassord" runat="server" Text="Passord"></asp:Label>
        <asp:TextBox ID="tbPassord" runat="server"></asp:TextBox>
        <br />
        Gjenta Passord<asp:TextBox ID="tbPassord2" runat="server" OnTextChanged="tbPassord2_TextChanged"></asp:TextBox>
        <br />
        <asp:Label ID="lblFornavn" runat="server" Text="Fornavn"></asp:Label>
        <asp:TextBox ID="tbFornavn" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="lblMellomnavn" runat="server" Text="Mellomnavn"></asp:Label>
        <asp:TextBox ID="tbMellomnavn" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="lblEtternavn" runat="server" Text="Etternavn"></asp:Label>
        <asp:TextBox ID="tbEtternavn" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="lblEpost" runat="server" Text="Epost"></asp:Label>
        <asp:TextBox ID="tbEpost" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="lblIm" runat="server" Text="Instant Messenger"></asp:Label>
        <asp:TextBox ID="tbIm" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="lblAdresse" runat="server" Text="Adresse"></asp:Label>
        <asp:TextBox ID="tbAdresse" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="lblPostnr" runat="server" Text="Postnummer"></asp:Label>
        <asp:TextBox ID="tbPostnr" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="lblTlfnr" runat="server" Text="Telefonnummer"></asp:Label>
        <asp:TextBox ID="tbTelefonnr" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="lblBy" runat="server" Text="By"></asp:Label>
        <asp:TextBox ID="tbBy" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btnRegister" runat="server" OnClick="btnRegister_Click" Text="Registrer bruker" />
        <br />
    </form>
</body>
</html>
