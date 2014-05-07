<%@ Page Title="Legg Til Bruker" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LeggTilBruker.aspx.cs" Inherits="Timeregistreringssystem.BrukerAdministrasjon.LeggTilBruker" %>
<asp:Content ID="LeggTilBrukerContent" ContentPlaceHolderID="MainContent" runat="server">
    

    <h1><%: Title %></h1>

    <table>
        <tr>
            <td><asp:Label ID="lblBrukernavn" runat="server" Text="Brukernavn"></asp:Label></td>
            <td><asp:TextBox ID="tbBrukernavn" runat="server"></asp:TextBox></td>
            <td><asp:Image ID="imgStjerne1" runat="server" ImageUrl="~/Content/glyphicons/png/glyphicons_049_star.png" /></td>
        </tr>
        <tr>
            <td><asp:Label ID="lblPassord" runat="server" Text="Passord"></asp:Label></td>
            <td><asp:TextBox ID="tbPassord" runat="server" TextMode="Password"></asp:TextBox></td>
            <td><asp:Image ID="imgStjerne2" runat="server" ImageUrl="~/Content/glyphicons/png/glyphicons_049_star.png" /></td>
        </tr>
        <tr>
            <td><asp:Label ID="lblgjentaPassord" runat="server" Text="Gjenta Passord"></asp:Label></td>
            <td><asp:TextBox ID="tbPassord2" runat="server" TextMode="Password"></asp:TextBox></td>
            <td><asp:Image ID="imgStjerne3" runat="server" ImageUrl="~/Content/glyphicons/png/glyphicons_049_star.png" /></td>
        </tr>
        <tr>
            <td><asp:Label ID="lblFornavn" runat="server" Text="Fornavn"></asp:Label></td>
            <td><asp:TextBox ID="tbFornavn" runat="server"></asp:TextBox></td>
            <td><asp:Image ID="imgStjerne4" runat="server" ImageUrl="~/Content/glyphicons/png/glyphicons_049_star.png" /></td>
        </tr>
        <tr>
            <td><asp:Label ID="lblMellomnavn" runat="server" Text="Mellomnavn"></asp:Label></td>
            <td><asp:TextBox ID="tbMellomnavn" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td><asp:Label ID="lblEtternavn" runat="server" Text="Etternavn"></asp:Label></td>
            <td><asp:TextBox ID="tbEtternavn" runat="server"></asp:TextBox></td>
            <td><asp:Image ID="imgStjerne5" runat="server" ImageUrl="~/Content/glyphicons/png/glyphicons_049_star.png" /></td>
        </tr>
        <tr>
            <td><asp:Label ID="lblEpost" runat="server" Text="Epost"></asp:Label></td>
            <td><asp:TextBox ID="tbEpost" runat="server"></asp:TextBox></td>
            <td><asp:Image ID="imgStjerne6" runat="server" ImageUrl="~/Content/glyphicons/png/glyphicons_049_star.png" /></td>

            <td>
            <asp:RegularExpressionValidator ID="RegularExpressionValidatorEpost" runat="server" 
            ForeColor="Red"
            ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
            ControlToValidate="tbEpost" 
            ErrorMessage="Ugyldig epost format"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td><asp:Label ID="lblIm" runat="server" Text="Instant Messenger"></asp:Label></td>
            <td><asp:TextBox ID="tbIm" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td><asp:Label ID="lblAdresse" runat="server" Text="Adresse"></asp:Label></td>
            <td><asp:TextBox ID="tbAdresse" runat="server"></asp:TextBox></td>
            <td><asp:Image ID="imgStjerne7" runat="server" ImageUrl="~/Content/glyphicons/png/glyphicons_049_star.png" /></td>
        </tr>
        <tr>
            <td><asp:Label ID="lblPostnr" runat="server" Text="Postnummer"></asp:Label></td>
            <td><asp:TextBox ID="tbPostnr" runat="server"></asp:TextBox></td>
            <td><asp:Image ID="imgStjerne8" runat="server" ImageUrl="~/Content/glyphicons/png/glyphicons_049_star.png" /></td>

            <td>
                <asp:RegularExpressionValidator id="RegularExpressionValidatorPostnr" runat="server"
                     ForeColor="Red"
                     ControlToValidate="tbPostnr"
                     ValidationExpression="\d{4}"
                     ErrorMessage="Vennligst skriv inn et gyldig postnummer, 4 siffer">

                </asp:RegularExpressionValidator>

            </td>
        </tr>
        <tr>
            <td><asp:Label ID="lblTlfnr" runat="server" Text="Telefonnummer"></asp:Label></td>
            <td><asp:TextBox ID="tbTelefonnr" runat="server"></asp:TextBox></td>
            <td><asp:Image ID="imgStjerne9" runat="server" ImageUrl="~/Content/glyphicons/png/glyphicons_049_star.png" /></td>

            <td>
                <asp:RegularExpressionValidator id="RegularExpressionValidatorTlfnr" runat="server"
                     ForeColor="Red"
                     ControlToValidate="tbTelefonnr"
                     ValidationExpression="\d{8}"
                     ErrorMessage="Vennligst skriv inn et gyldig telefonnummer, 8 siffer">

                </asp:RegularExpressionValidator>

            </td>

        </tr>
        <tr>
            <td><asp:Label ID="lblBy" runat="server" Text="By"></asp:Label></td>
            <td><asp:TextBox ID="tbBy" runat="server"></asp:TextBox></td>
            <td><asp:Image ID="imgStjerne10" runat="server" ImageUrl="~/Content/glyphicons/png/glyphicons_049_star.png" /></td>
        </tr>
        <tr>
            <td><asp:Label ID="lblType" runat="server" Text="Type bruker"></asp:Label></td>
            <td>
                <asp:DropDownList ID="ddlBrukertype" runat="server">
                    <asp:ListItem Value="0">Vanlig bruker</asp:ListItem>
                    <asp:ListItem Value="1">Teamleder</asp:ListItem>
                    <asp:ListItem Value="2">Prosjektansvarlig</asp:ListItem>
                    <asp:ListItem Value="3">Administrator</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td><asp:Image ID="Image1" runat="server" ImageUrl="~/Content/glyphicons/png/glyphicons_049_star.png" /></td>
        </tr>
    </table>

    <br />

    <asp:Label ID="lblFeilmelding" runat="server" Text="Felter markert med "></asp:Label> 
    <asp:Image ID="imgStjerne0" runat="server" ImageUrl="~/Content/glyphicons/png/glyphicons_049_star.png" />
    <asp:Label ID="lblFeilmelding0" runat="server" Text="  må være fylt ut!"></asp:Label>
    
    <br />
    <br />
      
        <asp:Button ID="btnRegister" runat="server" OnClick="btnRegister_Click" Text="Registrer bruker" OnClientClick="Confirm()" />


    <script type = "text/javascript">
        function Confirm() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Er du sikker på at du vil legge til denne brukeren?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }
</script>


</asp:Content>
