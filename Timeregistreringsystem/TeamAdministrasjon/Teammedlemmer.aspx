<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Teammedlemmer.aspx.cs" Inherits="Timeregistreringsystem.Teammedlemmer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False"
            BackColor="White" BorderColor="Black" BorderStyle="Solid" CellPadding="5" 
            DataKeyNames="ID">

            <HeaderStyle BackColor="#CCCCFF" ForeColor="Black" />

            <Columns>
                <asp:CommandField ShowSelectButton="false" ShowDeleteButton="true" />
                <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" ReadOnly="true"/>
                <asp:BoundField DataField="Fornavn" HeaderText="Fornavn" SortExpression="Fornavn" ReadOnly="true"/>
                <asp:BoundField DataField="Mellomnavn" HeaderText="Mellomnavn" SortExpression="Mellomnavn" ReadOnly="true"/>
                <asp:BoundField DataField="Etternavn" HeaderText="Etternavn" SortExpression="Etternavn" ReadOnly="true"/>
            </Columns>

        </asp:GridView>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" 
            SelectCommand="
            SELECT * 
            FROM Bruker 
            WHERE ID IN
            (SELECT Bruker_ID
            FROM KoblingBrukerTeam
            WHERE Team_ID = @TeamId)">

            <SelectParameters>
                <asp:Parameter Name="TeamId" Type="Int32" />
            </SelectParameters>

        </asp:SqlDataSource>
    
        <br />
&nbsp;Legg til nytt medlem<br />
    
    </div>
        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="Navn" DataValueField="ID">
        </asp:DropDownList>
        &nbsp;
        <asp:Button ID="btnLeggTil" runat="server" OnClick="btnLeggTil_Click" Text="OK" />
        <br />
        <br />
        <br />
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, CONCAT(Fornavn, &quot; &quot;, Mellomnavn, &quot; &quot;, Etternavn) &quot;Navn&quot; FROM Bruker"></asp:SqlDataSource>
        
        <br /><a href="TeamAdministrasjon.aspx">Tilbake</a><br />
    </form>
</body>
</html>
