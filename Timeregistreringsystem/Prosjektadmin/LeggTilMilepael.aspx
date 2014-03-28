<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LeggTilMilepael.aspx.cs" Inherits="Timeregistreringssystem.Prosjektadmin.LeggTilMilepael" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SqlDataSourceMilepael" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Milepael.* FROM Milepael"></asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSourceMilepael">
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" />
            <asp:BoundField DataField="Beskrivelse" HeaderText="Beskrivelse" SortExpression="Beskrivelse" />
            <asp:BoundField DataField="ProsjektID" HeaderText="ProsjektID" SortExpression="ProsjektID" />
        </Columns>
</asp:GridView>
    <asp:Button ID="Button1" runat="server" Text="Button" />
    <asp:TextBox ID="TextBoxMilepaelBeskrivelse" runat="server" Height="22px" Width="128px"></asp:TextBox>
    <asp:DropDownList ID="DropDownListLeggTilMilepaelVisProsjekt" runat="server" DataSourceID="prosjektDropDown" DataTextField="Navn" DataValueField="ID">
    </asp:DropDownList>
    <asp:SqlDataSource ID="prosjektDropDown" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Navn FROM Prosjekt"></asp:SqlDataSource>
</asp:Content>
