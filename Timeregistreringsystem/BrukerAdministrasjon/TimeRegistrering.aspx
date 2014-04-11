<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TimeRegistrering.aspx.cs" Inherits="Timeregistreringssystem.BrukerAdministrasjon.TimeRegistrering" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
    <asp:Button ID="ButtonStart" runat="server" OnClick="Button1_Click" Text="Start" Width="96px" />
    <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
    <asp:Button ID="ButtonPause" runat="server" Height="26px" OnClick="Button2_Click" Text="Pause" Width="111px" />
    <asp:Label ID="LabelPause" runat="server" Text="Label"></asp:Label>
    <asp:Button ID="ButtonStop" runat="server" OnClick="Button3_Click" Text="Stop" Width="104px" />
    <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" InsertCommand="INSERT INTO Timer(Start) VALUES (@Start)" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Start, Pause, Slutt FROM Timer"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" InsertCommand="INSERT INTO Timer(Pause) VALUES (@Pause)" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Pause FROM Timer"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" InsertCommand="INSERT INTO Timer(Slutt) VALUES (@Slutt)" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Slutt FROM Timer"></asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:BoundField DataField="Start" HeaderText="Start" SortExpression="Start" />
            <asp:BoundField DataField="Pause" HeaderText="Pause" SortExpression="Pause" />
            <asp:BoundField DataField="Slutt" HeaderText="Slutt" SortExpression="Slutt" />
        </Columns>
    </asp:GridView>
</asp:Content>
