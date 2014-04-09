<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TeamRapport.aspx.cs" Inherits="Timeregistreringssystem.RapportGenerering.ProsjektRapport" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:DropDownList ID="TeamDDL" runat="server">
        </asp:DropDownList>
        <asp:SqlDataSource ID="TeamSDS" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Beskrivelse FROM Team"></asp:SqlDataSource>
        <br />
    
    </div>
        <rsweb:ReportViewer ID="TeamRV" runat="server">
        </rsweb:ReportViewer>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    </form>
</body>
</html>
