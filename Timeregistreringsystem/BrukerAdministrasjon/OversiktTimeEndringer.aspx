<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OversiktTimeEndringer.aspx.cs" Inherits="Timeregistreringssystem.BrukerAdministrasjon.OversiktTimeEndringer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <h3> Logg over endringer i timeregistrering</h3>
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" />
                <asp:BoundField DataField="StartOld" HeaderText="StartOld" SortExpression="StartOld" />
                <asp:BoundField DataField="StartNew" HeaderText="StartNew" SortExpression="StartNew" />
                <asp:BoundField DataField="SluttNew" HeaderText="SluttNew" SortExpression="SluttNew" />
                <asp:BoundField DataField="SluttOld" HeaderText="SluttOld" SortExpression="SluttOld" />
                <asp:BoundField DataField="TotalArbeidstidOld" HeaderText="TotalArbeidstidOld" SortExpression="TotalArbeidstidOld" />
                <asp:BoundField DataField="TotalArbeidstidNew" HeaderText="TotalArbeidstidNew" SortExpression="TotalArbeidstidNew" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT TimerEndringLogg.ID, TimerEndringLogg.StartOld, TimerEndringLogg.StartNew, TimerEndringLogg.SluttNew, TimerEndringLogg.SluttOld, TimerEndringLogg.TotalArbeidstidOld, TimerEndringLogg.TotalArbeidstidNew FROM TimerEndringLogg INNER JOIN Timer ON TimerEndringLogg.ID = Timer.ID"></asp:SqlDataSource>
    </p>
</asp:Content>
