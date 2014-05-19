<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="Timeregistreringssystem.BrukerProfile.ChangePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="row">
        <div class="col-md-8">
            <section id="loginForm">
                <div class="form-horizontal">
                    <h4>Endre passord</h4>
                    <hr />
                      <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <p class="text-danger">
                            <asp:Literal runat="server" ID="FailureText" />
                        </p>
                    </asp:PlaceHolder>
                    <!--Tekstbokser for nytt passord -->
                    <div class="form-group">
                        <asp:Label runat="server" CssClass="col-md-2 control-label">Nytt passord</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="NyttPassord" TextMode="Password" CssClass="form-control" />

                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" CssClass="col-md-2 control-label">Gjenta passord</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="GjentaPassord" TextMode="Password" CssClass="form-control" />

                        </div>
                    </div>
                    <!--Knapp til å legge til nytt passord-->
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <asp:Button runat="server" OnClick="ChangePw" Text="Endre Passord" CssClass="btn btn-default" />
                        </div>
                    </div>
                </div>

            </section>
        </div>


    </div>
</asp:Content>
