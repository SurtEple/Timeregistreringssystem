<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EndreFase.aspx.cs" Inherits="Timeregistreringssystem.Prosjektadmin.EndreFase" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Fase</h1>
    <div>
        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" DataKeyNames="ID">
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                <asp:BoundField DataField="Navn" HeaderText="Navn" SortExpression="Navn" />
                <asp:BoundField DataField="Dato_startet" HeaderText="Dato_startet" SortExpression="Dato_startet" />
                <asp:BoundField DataField="Dato_sluttet" HeaderText="Dato_sluttet" SortExpression="Dato_sluttet" />
                <asp:CheckBoxField DataField="Aktiv" HeaderText="Aktiv" SortExpression="Aktiv" />
                <asp:BoundField DataField="Beskrivelse" HeaderText="Beskrivelse" SortExpression="Beskrivelse" />
                <asp:BoundField DataField="Prosjekt_ID" HeaderText="Prosjekt_ID" SortExpression="Prosjekt_ID" />
            </Columns>
        </asp:GridView>
        <h1>Slett Fase</h1>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" 
                        SelectCommand="SELECT * FROM Fase" UpdateCommand="&quot;UPDATE `HLVDKN_DB1`.`Bruker` SET `Stilling_ID` = '4' WHERE `Bruker`.`ID` = &quot; + txtbxID.Text + &quot;;&quot;;"></asp:SqlDataSource>
        <asp:DropDownList ID="DropDownListSlettFase" runat="server" DataSourceID="SqlDataSourceDropDownDelFase" DataTextField="Navn" DataValueField="ID" Height="34px" Width="263px" Font-Size="Medium">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSourceDropDownDelFase" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Navn, ID FROM Fase"></asp:SqlDataSource>
        <br />&nbsp; &nbsp;<asp:Label ID="resultLabel" runat="server"></asp:Label>
        <br />
        <asp:Button ID="btnSlettFase" runat="server" Height="36px"  Text="Slett" Width="103px" OnClick="btnSlett_Click" />
        <br />
    </div>
    <div>
        <h1>Redigere Fase</h1>
        <p>
            <asp:DropDownList ID="DropDownListEditFase" runat="server" DataSourceID="SqlDataSourceDropDownDelFase" DataTextField="Navn" DataValueField="ID" Height="34px" Width="263px" Font-Size="Medium" AutoPostBack="True" OnSelectedIndexChanged="DropDownListEditFase_SelectedIndexChanged" >
            </asp:DropDownList>
        <asp:Button ID="btnLagreNewFase" runat="server"  Text="Lagre" Width="151px" Height="36px" OnClick="btnLagreNewFase_Click" />
            </p>
        <table>
            <tr>
                <td class="auto-style6">Nytt navn:  </td>
                <td class="auto-style5">
                    <asp:TextBox ID="textBoxNewNavn" runat="server" Width="169px"></asp:TextBox>
                    <asp:Label ID="Label1" runat="server" Text="Aktiv"></asp:Label>
                    <asp:CheckBox ID="EditFaseCheckIsFaseActive" runat="server" Checked="True" />
                </td>
            </tr>
            <tr>
                <td class="auto-style6">Ny beskrivelse: </td>
                <td class="auto-style5">
                    <asp:TextBox ID="textBoxNewBeskrivelse" runat="server" TextMode="MultiLine" Height="94px" Width="292px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style6">&nbsp;</td>
                <td class="auto-style5">
                    &nbsp;</td>
            </tr>
        </table>
        <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <asp:Label ID="resultLabel0" runat="server"></asp:Label>
        <br />
    </div>
    <br />
</asp:Content>
