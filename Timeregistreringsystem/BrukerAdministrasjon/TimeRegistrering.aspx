<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TimeRegistrering.aspx.cs" Inherits="Timeregistreringssystem.BrukerAdministrasjon.TimeRegistrering" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Registrer timer</h1>
    
    <br />
    <br />
    <asp:Label ID="Label1" runat="server" Text="Label" Visible="False"></asp:Label>
    <asp:Button ID="ButtonStart" runat="server" OnClick="Button1_Click" Text="Start" Width="96px" CssClass="btn" />
    <asp:Label ID="Label2" runat="server" Text="Label" Visible="False"></asp:Label>
    <asp:Button ID="ButtonPause" runat="server" Height="37px" OnClick="ButtonPause_Click" Text="Pause"  CssClass="btn" Enabled="False" />
    <asp:Label ID="LabelPause" runat="server" Text="Label" Visible="False"></asp:Label>
    <asp:Button ID="ButtonStop" runat="server" OnClick="ButtonStop_Click" Text="Stop" Width="104px" CssClass="btn" Enabled="False" />
    <asp:Label ID="Label3" runat="server" Text="Label" Visible="False"></asp:Label>
    <asp:SqlDataSource ID="SqlDataSourceTimer" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" InsertCommand="INSERT INTO Timer(Start,BrukerID) VALUES (@Start,@BrukerID)" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Timer.ID, Timer.IsPaused, Timer.Start, Timer.Slutt, Timer.BrukerID, Bruker.Brukernavn, Timer.Totaltid FROM Timer INNER JOIN Bruker ON Timer.BrukerID = Bruker.ID WHERE (Timer.Start = (SELECT MAX(Start) AS Expr1 FROM Timer Timer_1))" UpdateCommand="UPDATE  Timer SET  IsPaused=@IsPaused
WHERE ID = @ID;"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceStop" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" InsertCommand="INSERT INTO Pause(PauseStart) VALUES PauseStart=@PauseStart, Timer_ID=@ID;" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT TIMEDIFF(@Slutt, Start) AS Delta FROM Timer WHERE (ID = @ID)" UpdateCommand="UPDATE Timer SET Slutt = @Slutt, Totaltid = @Totaltid

WHERE (ID = @ID)"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" InsertCommand="INSERT INTO Timer(Slutt) VALUES (@Slutt)" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Slutt FROM Timer"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePause" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" InsertCommand="INSERT INTO Pause(PauseStart, Timer_ID) VALUES (@PauseStart, @ID);" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Timer.ID, Pause.ID AS PauseID, Timer.Start, Timer.Slutt, Timer.BrukerID, Timer.IsPaused, Pause.PauseStart, Pause.PauseStop, Pause.PauseSum, (SELECT SUM(PauseSum) FROM Pause WHERE Pause.Timer_ID = Timer.ID) AS Totaltid FROM Pause INNER JOIN Timer ON Pause.Timer_ID = Timer.ID WHERE (Timer.Start = (SELECT MAX(Start) FROM Timer)) ORDER BY PauseID DESC" UpdateCommand="UPDATE Pause SET PauseStop = @PauseStop, PauseSum = @PauseSum WHERE (Timer_ID = @ID) AND (ID = @PauseID)"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTotalTidPause" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT SUM(PauseSum) AS Totaltid FROM Pause WHERE (Timer_ID = @TimerID)" UpdateCommand="UPDATE Timer SET Totaltid = @Totaltid WHERE ID=@TimerID"></asp:SqlDataSource>
    <br />
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceTimer" DataKeyNames="ID" Width="545px" CssClass="table">
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" />
            <asp:CheckBoxField DataField="IsPaused" HeaderText="IsPaused" SortExpression="IsPaused" />
            <asp:BoundField DataField="Start" HeaderText="Start" SortExpression="Start" />
            <asp:BoundField DataField="Slutt" HeaderText="Slutt" SortExpression="Slutt" />
            <asp:BoundField DataField="BrukerID" HeaderText="BrukerID" SortExpression="BrukerID" />
            <asp:BoundField DataField="Brukernavn" HeaderText="Brukernavn" SortExpression="Brukernavn" />
            <asp:BoundField DataField="Totaltid" HeaderText="Totaltid" SortExpression="Totaltid" />
        </Columns>
    </asp:GridView>
    <br />
    <asp:GridView ID="TimerGridView" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourcePause" DataKeyNames="ID,PauseID" CssClass="table">
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" />
            <asp:BoundField DataField="PauseID" HeaderText="PauseID" InsertVisible="False" ReadOnly="True" SortExpression="PauseID" />
            <asp:BoundField DataField="Start" HeaderText="Start" SortExpression="Start" />
            <asp:BoundField DataField="Slutt" HeaderText="Slutt" SortExpression="Slutt" />
            <asp:BoundField DataField="BrukerID" HeaderText="BrukerID" SortExpression="BrukerID" />
            <asp:CheckBoxField DataField="IsPaused" HeaderText="IsPaused" SortExpression="IsPaused" />
            <asp:BoundField DataField="PauseStart" HeaderText="PauseStart" SortExpression="PauseStart" />
            <asp:BoundField DataField="PauseStop" HeaderText="PauseStop" SortExpression="PauseStop" />
            <asp:BoundField DataField="PauseSum" HeaderText="PauseSum" SortExpression="PauseSum" />
            <asp:BoundField DataField="Totaltid" HeaderText="Totaltid" SortExpression="Totaltid" />
        </Columns>
    </asp:GridView>
    <br />
    <asp:Label ID="Label4" runat="server" Text="Label" Visible="False"></asp:Label>
    <br />
    <br />
     <br />
     <asp:SqlDataSource ID="SqlDataSourceRegistreringer" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Timer.ID, DATE_FORMAT(Timer.Start, '%Y-%m-%d  %H:%i:%S') AS Start, DATE_FORMAT(Timer.Slutt, '%Y-%m-%d  %H:%i:%S') AS Slutt, DATE_FORMAT(Timer.Totaltid, ' %H:%i:%S') AS Totaltid, Bruker.ID AS BrukerID, Bruker.Brukernavn FROM Timer INNER JOIN Bruker ON Timer.BrukerID = Bruker.ID WHERE (Bruker.ID = @BrukerID) ORDER BY Timer.ID DESC" UpdateCommand="UPDATE Timer SET Start = @Start, Slutt = @Slutt, Totaltid = @Totaltid WHERE (ID = @ID)"></asp:SqlDataSource>
    
    <h1>Endre timer</h1>
    <asp:GridView ID="TimerGridView0" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceRegistreringer" DataKeyNames="ID,BrukerID" AllowPaging="True" AllowSorting="True" CssClass="table">
        <Columns>
            <asp:CommandField ShowEditButton="True" CancelText="Avbryt" EditText="Endre" UpdateText="Oppdater" />
            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
            <asp:BoundField DataField="Start" HeaderText="Start" SortExpression="Start" />
            <asp:BoundField DataField="Slutt" HeaderText="Slutt" SortExpression="Slutt" />
            <asp:BoundField DataField="Totaltid" HeaderText="Totaltid" SortExpression="Totaltid" ReadOnly="True" />
            <asp:BoundField DataField="BrukerID" HeaderText="BrukerID" InsertVisible="False" ReadOnly="True" SortExpression="BrukerID" />
            <asp:BoundField DataField="Brukernavn" HeaderText="Brukernavn" SortExpression="Brukernavn" ReadOnly="True" />
        </Columns>
    </asp:GridView>
    <br />
</asp:Content>
