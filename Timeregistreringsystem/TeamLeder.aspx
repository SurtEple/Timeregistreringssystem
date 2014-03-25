<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TeamLeder.aspx.cs" Inherits="Timeregistreringssystem.TeamLeder" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 542px;
        }
        .auto-style2 {
            width: 542px;
            height: 268px;
        }
        .auto-style3 {
            height: 268px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="height: 278px; width: 1071px">
    
        <table style="width: 100%; height: 415px;">
            <tr>
                <td class="auto-style1">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <!--Henter ut brukere fra BRUKERE (Må endres på i fremtiden) og viser dem frem i en GridView-->
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" 
                        SelectCommand="SELECT  `ID` ,  `Brukernavn` ,  `Fornavn` ,  `Mellomnavn` ,  `Etternavn` ,  `Stilling_ID` 
                        FROM  `Bruker` " UpdateCommand="&quot;UPDATE `HLVDKN_DB1`.`Bruker` SET `Stilling_ID` = '4' WHERE `Bruker`.`ID` = &quot; + txtbxID.Text + &quot;;&quot;;"></asp:SqlDataSource>
                    <asp:GridView ID="grdvwBrukere" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSource1"
                         OnSelectedIndexChanged="grdvwBrukere_SelectedIndexChanged">
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                            <asp:BoundField DataField="Brukernavn" HeaderText="Brukernavn" SortExpression="Brukernavn" />
                            <asp:BoundField DataField="Fornavn" HeaderText="Fornavn" SortExpression="Fornavn" />
                            <asp:BoundField DataField="Mellomnavn" HeaderText="Mellomnavn" SortExpression="Mellomnavn" />
                            <asp:BoundField DataField="Etternavn" HeaderText="Etternavn" SortExpression="Etternavn" />
                            <asp:BoundField DataField="Stilling_ID" HeaderText="Stilling_ID" SortExpression="Stilling_ID" />
                            <asp:ButtonField Text="Select" CommandName="Select" ItemStyle-Width="150" />
                        </Columns>
                    </asp:GridView>
                    <!--Valgt person fra GridView select får sin StillingsID satt til å være teamleder-->
                    <br />
                    <u>Gjør denne personen til Team-leder?</u>
                    <br />
                    <asp:TextBox ID="txtbxValgt" runat="server" Text=""></asp:TextBox>
                    <asp:Button ID="btSetTeamLeder" runat="server" Text="Bekreft" OnClick="btnSetTeamLeder_Click"></asp:Button>

                    <!--nguorewgnroegnreo-->
                    
                    <br />
                    <asp:TextBox ID="txtbxID" runat="server"></asp:TextBox>
                    

                </td>
                <td class="auto-style3"></td>
                <td class="auto-style3"></td>
            </tr>

            <tr>
                <td class="auto-style1">
                    <asp:Label ID="lblDetaljer" runat="server" Text="Detaljer"></asp:Label>
                    <br />
                    <asp:TextBox ID="txtbxDetaljer" runat="server" ReadOnly="True" TextMode="MultiLine"></asp:TextBox>
                </td>
                <td>
                    <asp:Label ID="lblConnectionResults" runat="server" Text="Databasemeldinger"></asp:Label>
                    <br />
                    <asp:TextBox ID="txtbxConnectionResult" runat="server" ReadOnly="True" TextMode="MultiLine"></asp:TextBox>
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
