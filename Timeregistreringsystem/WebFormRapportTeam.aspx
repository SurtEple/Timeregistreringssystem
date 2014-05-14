<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebFormRapportTeam.aspx.cs" Inherits="Timeregistreringssystem.WebFormRapportTeam" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:ScriptManager ID="ScriptManagerTeam" runat="server">
        </asp:ScriptManager>
        <rsweb:ReportViewer ID="ReportViewerTeam" runat="server" Height="100%" Width="100%" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
            <LocalReport ReportEmbeddedResource="Timeregistreringssystem.ReportTeam.rdlc" ReportPath="ReportTeam.rdlc">
                <DataSources>
                    <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="DataSetTeamGeneretAvWizard" />
                </DataSources>
            </LocalReport>
        </rsweb:ReportViewer>
    
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetData" TypeName="Timeregistreringssystem.DataSetRapportGenereringTableAdapters.TeamTableAdapter"></asp:ObjectDataSource>
    
    </div>
    </form>
</body>
</html>
