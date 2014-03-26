﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TeamAdministrasjon.aspx.cs" Inherits="Timeregistreringssystem.TeamAdministrasjon.TeamAdministrasjon" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h1>Team administrasjon</h1><br />

        <asp:GridView ID="gridViewTeam" runat="server" OnSelectedIndexChanged="gridViewTeam_SelectedIndexChanged"
             AutoGenerateEditButton="True" AutoGenerateDeleteButton="True" AutoGenerateColumns="False"
             BackColor="White" BorderColor="Black" BorderStyle="Solid" CellPadding="5" 
             OnRowEditing="gridViewTeam_RowEditing" OnRowDeleting="gridViewTeam_RowDeleting"
             DataKeyNames="ID" DataSourceID="SqlDataSource1" >

            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" ReadOnly="true"/>
                <asp:BoundField DataField="Beskrivelse" HeaderText="Beskrivelse" SortExpression="Beskrivelse"/>
                <asp:BoundField DataField="Teamleder" HeaderText="Teamleder" SortExpression="Teamleder"/>
                <asp:BoundField DataField="Fornavn" HeaderText="Fornavn" SortExpression="Fornavn" ReadOnly="true"/>
                <asp:BoundField DataField="Mellomnavn" HeaderText="Mellomnavn" SortExpression="Mellomnavn" ReadOnly="true"/>
                <asp:BoundField DataField="Etternavn" HeaderText="Etternavn" SortExpression="Etternavn" ReadOnly="true"/>
            </Columns>

         <HeaderStyle BackColor="#CCCCFF" ForeColor="Black" />
         <selectedrowstyle backcolor="White" forecolor="Black"
         font-bold="True" BorderColor="Black"/> 
        </asp:GridView>

        <br /><a href="OpprettTeam.aspx">Nytt team</a>
        <br /><a href="Default.aspx">Tilbake</a><br />

        &nbsp;
            
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" 
            DeleteCommand="DELETE FROM Team WHERE ID = @ID"
            SelectCommand="SELECT Team.ID, Team.Beskrivelse, Team.Teamleder, Bruker.Fornavn, Bruker.Mellomnavn, Bruker.Etternavn FROM Team, Bruker Where Team.Teamleder = Bruker.ID"
            UpdateCommand="UPDATE Team SET Beskrivelse = @Beskrivelse, Teamleder = @Teamleder WHERE ID = @ID"
            >
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32" />
            <asp:Parameter Name="Beskrivelse" Type="String" />
            <asp:Parameter Name="Teamleder" Type="Int32" />
        </UpdateParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
