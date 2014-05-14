<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebFormRapportProsjekt.aspx.cs" Inherits="Timeregistreringssystem.WebFormRapportProsjekt" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Height="100%" Width="100%">
            <LocalReport ReportEmbeddedResource="Timeregistreringssystem.ReportProsjekt.rdlc" ReportPath="ReportProsjekt.rdlc">
                <DataSources>
                    <rsweb:ReportDataSource DataSourceId="ObjectDataSource2" Name="DataSetGenerertAvWizard3" />
                </DataSources>
            </LocalReport>
        </rsweb:ReportViewer>
        <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="GetData" TypeName="Timeregistreringssystem.DataSetRapportGenereringTableAdapters.ProsjektTableAdapter"></asp:ObjectDataSource>
    
    </div>
    </form>
</body>
</html>
