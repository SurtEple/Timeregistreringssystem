﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EndreProsjekt.aspx.cs" Inherits="Timeregistreringssystem.Prosjektadmin.EndreProsjekt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Prosjekt</h1>

    <div>
        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1">
        </asp:GridView>
       

        <h1>Slett Prosjekt</h1>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" 
                        SelectCommand="SELECT ID, Navn, Oppsummering, Neste_Fase FROM Prosjekt" UpdateCommand="&quot;UPDATE `HLVDKN_DB1`.`Bruker` SET `Stilling_ID` = '4' WHERE `Bruker`.`ID` = &quot; + txtbxID.Text + &quot;;&quot;;"></asp:SqlDataSource>

        <asp:DropDownList ID="DropDownListSlettProsjekt" runat="server" DataSourceID="SqlDataSourceDropDownDelProject" DataTextField="Navn" DataValueField="ID" Height="34px" Width="141px">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSourceDropDownDelProject" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, Navn FROM Prosjekt"></asp:SqlDataSource>

        <br />
        &nbsp; &nbsp;<asp:Label ID="resultLabel" runat="server"></asp:Label>

        

             

        

             <br />
                          <asp:Button ID="btnSlett" runat="server" Height="36px" OnClick="btnSlett_Click" Text="Slett" Width="103px" />
        <br />

        

    </div>
        <div>
            <h1>Redigere Prosjekt</h1>
            <p>
                <asp:DropDownList ID="DropDownListEditProsjekt" runat="server" DataSourceID="SqlDataSourceDropDownDelProject" DataTextField="Navn" DataValueField="ID" Height="34px" Width="157px" AutoPostBack="True">
                </asp:DropDownList>
            </p>
            <table>
                <tr>
                    <td class="auto-style6">Nytt navn:  </td>
                <td class="auto-style5">
                    <asp:TextBox ID="textBoxNewNavn" runat="server" Width="128px"></asp:TextBox>
                </td>
            </tr>

                 <tr>
                <td class="auto-style6">Ny oppsummering: </td>
                <td class="auto-style5">
                    <asp:TextBox ID="textBoxNewOppsummering" runat="server" TextMode="MultiLine"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td class="auto-style6">Ny neste fase: </td>
                <td class="auto-style5">
                    <asp:DropDownList ID="DropDownListNyNesteFase" runat="server" DataSourceID="SqlDataSourceNyNesteFase" DataTextField="Navn" DataValueField="ID" Height="34px" Width="138px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceNyNesteFase" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Navn, ID FROM Fase"></asp:SqlDataSource>
                </td>
            </tr>

            </table>

            <br />
            <asp:Button ID="btnLagreNewProject" runat="server" OnClick="btnLagreNewProject_Click" Text="Lagre" Width="103px" Height="36px" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="resultLabel0" runat="server"></asp:Label>

        

             

        

            <br />

        </div>

        <br />
        <br />
</asp:Content>