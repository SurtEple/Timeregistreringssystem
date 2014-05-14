<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WebFormRapportBruker.aspx.cs" Inherits="Timeregistreringssystem.WebFormRapportBruker" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="OpprettTeamContent" ContentPlaceHolderID="MainContent" runat="server">
    
    
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" Height="100%" SizeToReportContent="True">
            <LocalReport ReportEmbeddedResource="Timeregistreringssystem.ReportBruker.rdlc" ReportPath="ReportBruker.rdlc">
                <DataSources>
                    <rsweb:ReportDataSource DataSourceId="ObjectDataSource2" Name="DataSetGenerertAvWizard" />
                </DataSources>
            </LocalReport>
        </rsweb:ReportViewer>
        <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="GetData" TypeName="Timeregistreringssystem.DataSetRapportGenereringTableAdapters.BrukerTableAdapter"></asp:ObjectDataSource> 
    

</asp:Content>
