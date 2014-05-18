<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TimeRegistrering.aspx.cs" Inherits="Timeregistreringssystem.BrukerAdministrasjon.TimeRegistrering" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Registrer timer</h1>
    
    <h3>Hei  <b><%= (string)Session["Brukernavn"] %></b>! Du har valgt å jobbe på oppgaven <b>"<%= (string)Session["OppgaveTittel"] %>"</b>. 
       Du kan når som helst endre oppgave på din <a runat="server" href="~/Startside/BrukerForside.aspx">Startside</a>.</h3>
    <br/>
    <h4>Trykk <b>Start</b> for å begynne å registrere timer. Når du trenger å ta en pause trykker du på <b>Pause</b>, og når du er ferdig med pausen trykker du på <b>Unpause</b>. Når du er ferdig med å jobbe trykker du på <b>Stopp</b>. </h4>
    
    
    <table style="width:100%;">
        <tr>
            <td style="width: 124px" ><asp:Button ID="ButtonStart" runat="server" OnClick="Button1_Click" Text="Start" Width="96px" CssClass="btn" BackColor="#006600" ForeColor="White" /> </td>
            <td style="width: 124px" > <asp:Button ID="ButtonPause" runat="server" Height="37px" OnClick="ButtonPause_Click" Text="Pause"  CssClass="btn" Enabled="False" BackColor="#000099" ForeColor="White" Width="98px" /></td>
            <td style="width: 124px"> <asp:Button ID="ButtonStop" runat="server" OnClick="ButtonStop_Click" Text="Stopp" Width="104px" CssClass="btn" Enabled="False" BackColor="#990000" ForeColor="White" /></td>
        </tr>
        <tr>
            <td style="width: 124px" > <asp:Label ID="LabelStart" runat="server"></asp:Label></td>
            <td style="width: 124px" >  <asp:Label ID="LabelPause" runat="server" Enabled="False"></asp:Label></td>
            <td style="width: 124px"> <asp:Label ID="LabelStop" runat="server"></asp:Label></td>
        </tr>

    </table>
    
    <br />
    <br />
  
    
  
   
    <asp:SqlDataSource ID="SqlDataSourceTimer" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" InsertCommand="INSERT INTO Timer(Start, BrukerID, OppgaveID) VALUES (@Start, @BrukerID, @OppgaveID)" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT ID, IsPaused FROM Timer WHERE (Start = (SELECT MAX(Start) AS Expr1 FROM Timer Timer_1))" UpdateCommand="UPDATE  Timer SET  IsPaused=@IsPaused
WHERE ID = @ID;"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceStop" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" InsertCommand="INSERT INTO Pause(PauseStart) VALUES PauseStart=@PauseStart, Timer_ID=@ID;" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT TIMEDIFF(@Slutt, Start) AS Delta FROM Timer WHERE (ID = @ID)" UpdateCommand="UPDATE Timer SET Slutt = @Slutt, Totaltid = @Totaltid WHERE (ID = @ID)"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" InsertCommand="INSERT INTO Timer(Slutt) VALUES (@Slutt)" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT TIMEDIFF(Timer.Totaltid, SUM(Pause.PauseSum)) AS Expr1 FROM Timer INNER JOIN Pause ON Timer.ID = Pause.Timer_ID WHERE Timer.ID=@TimerID"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePause" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" InsertCommand="INSERT INTO Pause(PauseStart, Timer_ID) VALUES (@PauseStart, @ID);" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Timer.ID, Pause.ID AS PauseID, Timer.Start, Timer.Slutt, Timer.BrukerID, Timer.IsPaused, Pause.PauseStart, Pause.PauseStop, Pause.PauseSum, (SELECT SUM(PauseSum) FROM Pause WHERE Pause.Timer_ID = Timer.ID) AS Totaltid FROM Pause INNER JOIN Timer ON Pause.Timer_ID = Timer.ID WHERE (Timer.Start = (SELECT MAX(Start) FROM Timer)) ORDER BY PauseID DESC" UpdateCommand="UPDATE Pause SET PauseStop = @PauseStop, PauseSum = @PauseSum WHERE (Timer_ID = @ID) AND (ID = @PauseID)"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTotalTidPause" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT SUM(PauseSum) AS Totaltid FROM Pause WHERE (Timer_ID = @TimerID)" UpdateCommand="UPDATE Timer SET Totaltid = @Totaltid WHERE ID=@TimerID"></asp:SqlDataSource>
    <br />
    <br />
    <asp:SqlDataSource ID="SqlDataSourceHenteArbeidstid" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT TIMEDIFF(Timer.Totaltid, SUM(Pause.PauseSum)) AS Total FROM Timer INNER JOIN Pause ON Timer.ID = Pause.Timer_ID WHERE (Timer.ID = @ID)" UpdateCommand="UPDATE Timer SET TotalArbeidsTid=@TotalArbeidsTid WHERE ID=@ID"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Bruker.Brukernavn, Oppgave.Tittel, Timer.Start, SUM(Pause.PauseSum) AS &quot;Pause i sekunder&quot;, Timer.Slutt, Timer.TotalArbeidsTid FROM Timer INNER JOIN Pause ON Timer.ID = Pause.Timer_ID INNER JOIN Oppgave ON Timer.OppgaveID = Oppgave.ID INNER JOIN Bruker ON Timer.BrukerID = Bruker.ID WHERE (Timer.Start = (SELECT MAX(Start) AS Expr1 FROM Timer Timer_1)) AND Bruker.ID=@BrukerID GROUP BY Timer.ID ORDER BY Timer.ID DESC"></asp:SqlDataSource>
   

                 <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceTimer" DataKeyNames="ID" Width="223px" CssClass="table" Visible="False">
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" />
            <asp:CheckBoxField DataField="IsPaused" HeaderText="IsPaused" SortExpression="IsPaused" />
            
        </Columns>
    </asp:GridView>

         

                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource4" CssClass="table">
        <Columns>
            <asp:BoundField DataField="Brukernavn" HeaderText="Brukernavn" SortExpression="Brukernavn" />
            <asp:BoundField DataField="Tittel" HeaderText="Tittel" SortExpression="Tittel" />
            <asp:BoundField DataField="Start" HeaderText="Start" SortExpression="Start" />
            <asp:BoundField DataField="Pause i sekunder" HeaderText="Pause i sekunder" SortExpression="Pause i sekunder" />
            <asp:BoundField DataField="Slutt" HeaderText="Slutt" SortExpression="Slutt" />
            <asp:BoundField DataField="TotalArbeidsTid" HeaderText="TotalArbeidsTid" SortExpression="TotalArbeidsTid" />
        </Columns>
    </asp:GridView>

       

    <br />
    <asp:GridView ID="TimerGridView" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourcePause" DataKeyNames="ID,PauseID" CssClass="table" Visible="False">
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
     <asp:SqlDataSource ID="SqlDataSourceRegistreringer" runat="server" ConnectionString="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString %>" ProviderName="<%$ ConnectionStrings:HLVDKN_DB1ConnectionString.ProviderName %>" SelectCommand="SELECT Timer.ID, Bruker.Brukernavn, DATE_FORMAT(Timer.Start, '%Y-%m-%d  %H:%i:%S') AS Start, DATE_FORMAT(Timer.Slutt, '%Y-%m-%d  %H:%i:%S') AS Slutt, DATE_FORMAT(Timer.TotalArbeidstid, ' %H:%i:%S') AS TotalArbeidstid FROM Timer INNER JOIN Bruker ON Timer.BrukerID = Bruker.ID WHERE (Bruker.ID = @BrukerID) ORDER BY Timer.ID DESC" UpdateCommand="UPDATE Timer SET Start = @Start, Slutt = @Slutt, TotalArbeidsTid = @TotalArbeidstid  WHERE (ID = @ID)"></asp:SqlDataSource>
    
    <h1>Endre timer</h1>
    <asp:GridView ID="TimerGridView0" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceRegistreringer" DataKeyNames="ID" AllowPaging="True" AllowSorting="True" CssClass="table">
        <Columns>
            <asp:CommandField ShowEditButton="True" CancelText="Avbryt" EditText="Endre" UpdateText="Lagre" />
            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
            <asp:BoundField DataField="Start" HeaderText="Start" SortExpression="Start" />
            <asp:BoundField DataField="Slutt" HeaderText="Slutt" SortExpression="Slutt" />
            <asp:BoundField DataField="TotalArbeidstid" HeaderText="TotalArbeidstid" SortExpression="TotalArbeidstid" />
        </Columns>
    </asp:GridView>
    <br />
</asp:Content>
