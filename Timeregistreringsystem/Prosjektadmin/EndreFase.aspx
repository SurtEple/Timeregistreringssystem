<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EndreFase.aspx.cs" Inherits="Timeregistreringssystem.Prosjektadmin.EndreFase" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Fase</h1>
    <div>
        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" DataKeyNames="ID" CssClass="table">
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                <asp:BoundField DataField="Navn" HeaderText="Navn" SortExpression="Navn" />
                <asp:BoundField DataField="StartDato" HeaderText="StartDato" SortExpression="StartDato" />
                <asp:BoundField DataField="SluttDato" HeaderText="SluttDato" SortExpression="SluttDato" />
                <asp:CheckBoxField DataField="Aktiv" HeaderText="Aktiv" SortExpression="Aktiv" />
                <asp:BoundField DataField="Beskrivelse" HeaderText="Beskrivelse" SortExpression="Beskrivelse" />
                <asp:BoundField DataField="Prosjekt_ID" HeaderText="Prosjekt_ID" SortExpression="Prosjekt_ID" />
            </Columns>
        </asp:GridView>
        <h1>Slett Fase</h1>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" 
                        SelectCommand="SELECT ID, Navn, DATE_FORMAT(Dato_startet , '%d.%m.%Y') AS &quot;StartDato&quot;, DATE_FORMAT(Dato_sluttet , '%d.%m.%Y') AS &quot;SluttDato&quot;,Aktiv, Beskrivelse, Prosjekt_ID FROM Fase

WHERE ID &gt; 0" UpdateCommand="&quot;UPDATE `HLVDKN_DB1`.`Bruker` SET `Stilling_ID` = '4' WHERE `Bruker`.`ID` = &quot; + txtbxID.Text + &quot;;&quot;;"></asp:SqlDataSource>
        <asp:DropDownList ID="DropDownListSlettFase" runat="server" DataSourceID="SqlDataSourceDropDownDelFase" DataTextField="Navn" DataValueField="ID" Width="263px" Font-Size="Medium" CssClass="dropdown" OnSelectedIndexChanged="DropDownListSlettFase_SelectedIndexChanged">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSourceDropDownDelFase" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Navn, ID FROM Fase"></asp:SqlDataSource>
        <br />&nbsp; &nbsp;<asp:Label ID="resultLabel" runat="server"></asp:Label>
        <br />
        <asp:Button ID="btnSlettFase" runat="server" Height="36px"  Text="Slett" Width="103px" OnClick="btnSlett_Click" CssClass="btn" Enabled="False" />
        <br />
    </div>
    <div>
        <h1>Redigere Fase</h1>
        <table>
            <tr>
                <td class="auto-style6" style="height: 35px">Velg Fase</td>
                  <td class="auto-style6" style="height: 35px"><asp:DropDownList ID="DropDownListEditFase" runat="server" DataSourceID="SqlDataSourceDropDownDelFase" DataTextField="Navn" DataValueField="ID" Height="34px" Width="263px" Font-Size="Medium" AutoPostBack="True" OnSelectedIndexChanged="DropDownListEditFase_SelectedIndexChanged" CssClass="dropdown" >
            </asp:DropDownList></td>
            </tr>
            <tr>
                <td class="auto-style6" style="height: 37px">Aktiv? </td>
                <td class="auto-style5" style="height: 37px">
                    <asp:Label ID="Label1" runat="server" Text="Aktiv"></asp:Label>
                    <asp:CheckBox ID="EditFaseCheckIsFaseActive" runat="server" Checked="True" />
                </td>
            </tr>
            <tr>
                <td class="auto-style6">&nbsp;Nytt navn:  </td>
                <td class="auto-style5">
                    <asp:TextBox ID="textBoxNewNavn" runat="server" Width="169px" CssClass="input-group-sm" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style6">Ny beskrivelse:</td>
                <td class="auto-style5">
                    <asp:TextBox ID="textBoxNewBeskrivelse" runat="server" TextMode="MultiLine" Height="94px" Width="292px" CssClass="input-lg" Enabled="False"></asp:TextBox>
                </td>
            </tr>
        </table>
        <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnLagreNewFase" runat="server"  Text="Lagre" Width="151px" Height="36px" OnClick="btnLagreNewFase_Click" CssClass="btn" Enabled="False" />
            &nbsp;&nbsp;&nbsp; 
        <asp:Label ID="resultLabel0" runat="server"></asp:Label>
        <br />
    </div>
    <br />
</asp:Content>
