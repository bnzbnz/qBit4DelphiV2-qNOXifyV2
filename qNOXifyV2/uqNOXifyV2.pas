unit uqNOXifyV2;

interface
uses

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uqBit, uqBit.API, uqBit.API.Types,
  Vcl.ExtCtrls, Vcl.StdCtrls, uqBitGrid, uqBitThreads, Vcl.Menus, Vcl.ComCtrls,
  Vcl.Grids, Vcl.CheckLst, Vcl.TitleBarCtrls, Vcl.ToolWin, Vcl.ActnMan,
  Vcl.ActnCtrls, Vcl.Buttons, Vcl.AppEvnts, System.Notification
  , System.Generics.Collections
  , uKobicAppTrackMenus
  , uqBitSelectServerDlg
  , uJX4Object
  , uJX4Dict
  , RTTI
  , Winapi.ActiveX, uWVWinControl, uWVWindowParent, uWVBrowserBase, uWVBrowser, uWVLoader, uWVTypeLibrary, uWVCoreWebView2Args, uWVTypes, uWVCoreWebView2DownloadOperation
  ;

type

  TJsonPrefs = class(TJX4Object)
    MainGrid:   TJsonGrid;
    PeersGrid:   TJSonGrid;
    TrackersGrid: TJsonGrid;
    Servers: TqBitServers;
  end;

  TFrmSTG = class(TForm)
    MainPopup: TPopupMenu;
    Pause1: TMenuItem;
    Pause2: TMenuItem;
    N1: TMenuItem;
    ShowSelection1: TMenuItem;
    PeersPopup: TPopupMenu;
    BanPeers1: TMenuItem;
    UnbanAll1: TMenuItem;
    Recheck1: TMenuItem;
    N2: TMenuItem;
    Add1: TMenuItem;
    DlgOpenTorrent: TFileOpenDialog;
    Delete1: TMenuItem;
    NoData1: TMenuItem;
    WithData1: TMenuItem;
    StatusBar1: TStatusBar;
    N3: TMenuItem;
    PMPausePeers: TMenuItem;
    PMMainPause: TMenuItem;
    Reannounce1: TMenuItem;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    MMLogout: TMenuItem;
    MMExitqBittorent: TMenuItem;
    N5: TMenuItem;
    AddFiles1: TMenuItem;
    CatsMenu: TMenuItem;
    TagsMenu: TMenuItem;
    N8: TMenuItem;
    Files1: TMenuItem;
    Magnet1: TMenuItem;
    AddURL1: TMenuItem;
    PCMain: TPageControl;
    TabSheet2: TTabSheet;
    Splitter1: TSplitter;
    MainFrame: TqBitFrame;
    Panel2: TPanel;
    Label3: TLabel;
    EDFilter: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CBCats: TComboBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    SGG: TStringGrid;
    PeersTabSheet: TTabSheet;
    PeersFrame: TqBitFrame;
    TrakersTabSheet: TTabSheet;
    TrackersFrame: TqBitFrame;
    Download1: TMenuItem;
    DlgSaveTorrent: TOpenDialog;
    N4: TMenuItem;
    UploadWinSCP1: TMenuItem;
    SelectAll1: TMenuItem;
    N6: TMenuItem;
    Torrent: TTabSheet;
    Panel1: TPanel;
    WVWindowParent1: TWVWindowParent;
    WVBrowser1: TWVBrowser;
    ComboBox1: TComboBox;
    BackBtn: TButton;
    ForwardBtn: TButton;
    ReloadBtn: TButton;
    TrayIcon1: TTrayIcon;
    ApplicationEvents1: TApplicationEvents;
    GoBtn: TButton;
    Label1: TLabel;
    PMTray: TPopupMenu;
    Logout1: TMenuItem;
    About1: TMenuItem;
    NotificationCenter1: TNotificationCenter;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PauseClick(Sender: TObject);
    procedure ResumeClick(Sender: TObject);
    procedure ShowSelection1Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure UnbanAll1Click(Sender: TObject);
    procedure BanPeers1Click(Sender: TObject);
    procedure Recheck1Click(Sender: TObject);
    procedure NoData1Click(Sender: TObject);
    procedure WithData1Click(Sender: TObject);
    procedure StatusBar1Click(Sender: TObject);
    function  GetSelectionHash: TqBitTorrentType;
    procedure SGGMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PMPausePeersClick(Sender: TObject);
    procedure PMMainPauseClick(Sender: TObject);
    procedure Reannounce1Click(Sender: TObject);
    procedure MMLogoutClick(Sender: TObject);
    procedure MMExitqBittorentClick(Sender: TObject);
    procedure Add2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure AssigntoselectedTorrents1Click(Sender: TObject);
    procedure RemoveCategories1Click(Sender: TObject);
    procedure MainPopupPopup(Sender: TObject);
    procedure MainPopupClose(Sender: TObject);
    procedure Files1Click(Sender: TObject);
    procedure Magnet1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Download1Click(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
    procedure PCMainChange(Sender: TObject);
    procedure WVBrowser1AfterCreated(Sender: TObject);
    procedure WVBrowser1LaunchingExternalUriScheme(Sender: TObject;
      const aWebView: ICoreWebView2;
      const aArgs: ICoreWebView2LaunchingExternalUriSchemeEventArgs);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure BackBtnClick(Sender: TObject);
    procedure ForwardBtnClick(Sender: TObject);
    procedure ReloadBtnClick(Sender: TObject);
    procedure WVBrowser1DownloadStarting(Sender: TObject;
      const aWebView: ICoreWebView2;
      const aArgs: ICoreWebView2DownloadStartingEventArgs);
    procedure WVBrowser1DownloadStateChanged(Sender: TObject;
      const aDownloadOperation: ICoreWebView2DownloadOperation;
      aDownloadID: Integer);
    procedure WVBrowser1NewWindowRequested(Sender: TObject;
      const aWebView: ICoreWebView2;
      const aArgs: ICoreWebView2NewWindowRequestedEventArgs);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure WVBrowser1SourceChaged(Sender: TObject;
      const aWebView: ICoreWebView2;
      const aArgs: ICoreWebView2SourceChangedEventArgs);
    procedure WVBrowser1NavigationStarting(Sender: TObject;
      const aWebView: ICoreWebView2;
      const aArgs: ICoreWebView2NavigationStartingEventArgs);
    procedure WVBrowser1SourceChanged(Sender: TObject;
      const aWebView: ICoreWebView2;
      const aArgs: ICoreWebView2SourceChangedEventArgs);
    procedure WVBrowser1NavigationCompleted(Sender: TObject;
      const aWebView: ICoreWebView2;
      const aArgs: ICoreWebView2NavigationCompletedEventArgs);
    procedure WVBrowser1WebResourceRequested(Sender: TObject;
      const aWebView: ICoreWebView2;
      const aArgs: ICoreWebView2WebResourceRequestedEventArgs);
    procedure GoBtnClick(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Logout1Click(Sender: TObject);
  private
    { Private declarations }
    FSFTPPass: string;
    FNoMoreSFTPPass: Boolean;
    FDownloadOperation: TCoreWebView2DownloadOperation;
    procedure ClickEditCats(Sender: TObject);
    procedure ClickClearCats(Sender: TObject);
    procedure ClickSetCats(Sender: TObject);
    procedure ClickClearTags(Sender: TObject);
    procedure ClickCreateTags(Sender: TObject);
  protected
    procedure WMDropFiles(var Msg: TMessage); message WM_DROPFILES;
    procedure TrackMenuNotifyHandler(Sender: TMenu; Item: TMenuItem; var CanClose: Boolean);
    procedure PrepareMainPopup;
    procedure ReleaseMainPopup;
    procedure Notification(Name, Title, AlertBody: string);
  public
    { Public declarations }
    qB: TqBit;
    Config: TJsonPrefs;
    MainThread: TqBitMainThread;
    PeersThread: TqBitPeersThread;
    TrackersThread: TqBitTrackersThread;
    ActiveKeyHash: string;
    TagsList: TStringList;
    CatsList: TStringList;
    Server: TqBitServer;

    procedure MainThreadEvent(qBitThread: TThread; EventType: TqBitThreadEventCode);
    procedure MainFrameUpdateEvent(Sender: TObject);
    procedure MainFramePopupEvent(Sender: TObject; X, Y, aCol, aRow: integer);
    procedure MainFrameSelectEvent(Sender: TObject);

    procedure PeersFrameUpdateEvent(Sender: TObject);
    procedure PeersThreadEvent(qBitThread: TThread; EventType: TqBitThreadEventCode);
    procedure PeersFramePopupEvent(Sender: TObject; X, Y, aCol, aRow: integer);

    procedure TrackersThreadEvent(qBitThread: TThread; EventType: TqBitThreadEventCode);
    procedure TrackersFrameUpdateEvent(Sender: TObject);
  end;

var
  FrmSTG: TFrmSTG;

{$R *.dfm}

implementation
uses
    ShellAPI
  , uqBitCategoriesDlg
  , uqBitAddTorrentDlg
  , System.Generics.Defaults
  , System.IOUtils
  , uJX4Rtti
  , uJX4Value
  , System.TypInfo
  , Vcl.Clipbrd
  , StrUtils
  , uVnStatClient
  , uFacterClient
  , Registry
  , System.NetEncoding
  , System.Net.URLClient
  , System.Net.HttpClient
  , System.Net.HttpClientComponent
  , NetConsts
  , uAbout
  ;

function TValueFormatTrackerStatus(v: TValue): string;
begin
  case v.ToInteger of
    0: Result := 'Disabled';
    1: Result := 'Not Contacted';
    2: Result := 'Working';
    3: Result := 'Updating';
    4: Result := 'Error';
  else
    Result := 'Unknown';
  end;
end;

procedure TFrmSTG.ReleaseMainPopup;
begin
   var Lst := TStringList.Create(#0, ',', [soStrictDelimiter]);
   var Ts := MainFrame.GetSelectedTorrents;

   for var T in TagsMenu do
     if T.Checked then Lst.Add(T.Caption);

   for var T in Ts do
   begin
    qB.RemoveTorrentTags(T.hash.AsString, '');
    qB.AddTorrentTags(T.hash.AsString, LSt.Delimitedtext);
   end;

   Ts.Free;
   Lst.free;
end;

procedure TFrmSTG.Notification(Name, Title, AlertBody: string);
var
  MyNotification: TNotification;
begin
  MyNotification := NotificationCenter1.CreateNotification;
  try
    MyNotification.Name := Name;
    MyNotification.Title := Title;
    MyNotification.AlertBody := AlertBody;
    MyNotification.EnableSound := False;
    NotificationCenter1.PresentNotification(MyNotification);
  finally
    MyNotification.Free;
  end;
end;

procedure TFrmSTG.ReloadBtnClick(Sender: TObject);
begin
  WVBrowser1.Refresh;
end;

procedure TFrmSTG.PrepareMainPopup;
begin

  var Lst := TStringList.Create(#0, ',', [soStrictDelimiter]);
  var Ts := MainFrame.GetSelectedTorrents;
  try
    // Category
    CatsMenu.Clear;
    var SubMenu := TMenuItem.Create(Self);
    SubMenu.Caption := 'Add / Edit / Delete';
    SubMenu.tag := 0;
    SubMenu.OnClick := ClickEditCats;
    CatsMenu.Add(SubMenu);
    SubMenu := TMenuItem.Create(Self);
    SubMenu.OnClick := Nil;
    SubMenu.Caption := '-';
    CatsMenu.Add(SubMenu);
    SubMenu := TMenuItem.Create(Self);
    SubMenu.OnClick := ClickClearCats;
    //SubMenu.Tag := 1;
    SubMenu.Caption := '';
    CatsMenu.Add(SubMenu);

    for var T in Ts do Lst.Add(T.category.AsString);
    for var Cat in CatsList do
    begin
      SubMenu := TMenuItem.Create(Self);
      SubMenu.Caption := Cat;
      SubMenu.OnClick := ClickSetCats;
      SubMenu.Checked := LSt.IndexOf(Cat) <> -1;
      CatsMenu.Add(SubMenu);
    end;

    // Tag
    TagsMenu.Clear;
    SubMenu := TMenuItem.Create(Self);
    SubMenu.Caption := 'Add / Edit / Delete';
    SubMenu.tag := 0;
    SubMenu.OnClick := ClickCreateTags;
    TagsMenu.Add(SubMenu);
    SubMenu := TMenuItem.Create(Self);
    SubMenu.OnClick := Nil;
    SubMenu.Caption := '-';
    TagsMenu.Add(SubMenu);
    SubMenu := TMenuItem.Create(Self);
    SubMenu.OnClick := ClickClearTags;
    SubMenu.Caption := '';
    TagsMenu.Add(SubMenu);


    var Idx := 1; LSt.Clear; LSt.Duplicates := dupIgnore; var v := '';
    for var T in Ts do Lst.Text := Lst.Text + ',' +  T.tags.AsString;
    Lst.DelimitedText := Lst.Text;
    for var Tag in TagsList do
    begin
      SubMenu := TMenuItem.Create(Self);
      SubMenu.Caption := Tag;
      SubMenu.AutoCheck := True;
      SubMenu.tag := Idx;
      SubMenu.OnClick := ClickSetCats;
      SubMenu.Checked := (Lst.IndexOf(Tag) <> -1) or (Lst.IndexOf(' ' + Tag) <> -1);
      TagsMenu.Add(SubMenu);
      Inc(Idx);
    end;

  finally
    Ts.Free;
    Lst.Free;
  end;
end;

procedure TFrmSTG.ClickCreateTags(Sender: TObject);
begin
  var Tags := qB.GetAllTags;
  var Lst := TStringList.Create(#0, ',', [soStrictDelimiter]);
  try
    for var Tag in Tags.tags do Lst.Add(Tag.asString);
    var InputString := InputBox('Manage Tags', 'Edit Tags (comma separated)', Lst.DelimitedText);

    if not InputString.Trim.IsEmpty then
    begin
      var AlreadyExist: Boolean := False;
      Lst.DelimitedText := InputString;
      for var i in Lst do
      begin
        AlreadyExist := False;
        for var j in Tags.tags do
        begin
          AlreadyExist := (i.Trim = j.AsString.Trim) or AlreadyExist;
          if AlreadyExist then Break;
        end;
        if Not AlreadyExist then
          qB.CreateTags(i.Trim);
      end;

      AlreadyExist := False;
      Lst.DelimitedText := InputString;
      for var j in Tags.tags do
      begin
        AlreadyExist := False;
        for var i in Lst do
        begin
          AlreadyExist := (i.Trim = j.AsString.Trim) or AlreadyExist;
          if AlreadyExist then Break;
        end;
        if Not AlreadyExist then
          qB.DeleteTags(j.AsString.Trim);
      end;

    end else
       for var j in Tags.tags do qB.DeleteTags(j.AsString);
  finally
    LSt.Free;
    Tags.Free;
  end;
end;

procedure TFrmSTG.ClickClearTags(Sender: TObject);
begin
 var Ts := MainFrame.GetSelectedTorrents;
   try
     for var T in Ts do
       qB.RemoveTorrentTags(T.hash.AsString, '');
   finally
     Ts.Free;
   end;
end;

procedure TFrmSTG.ClickSetCats(Sender: TObject);
begin
 var Ts := MainFrame.GetSelectedTorrents;
   try
     for var T in Ts do
       qB.SetTorrentCategory(T.hash.AsString, TMenuItem(Sender).Caption);
   finally
     Ts.Free;
   end;
end;

procedure TFrmSTG.ComboBox1Change(Sender: TObject);
begin
  WVBrowser1.Navigate(ComboBox1.Text);
end;

procedure TFrmSTG.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key= #$D then  WVBrowser1.Navigate(ComboBox1.Text);
end;

procedure TFrmSTG.Download1Click(Sender: TObject);
begin
  var Ts := MainFrame.GetSelectedTorrents;
  if (FSFTPPass.Trim = '') and (not FNoMoreSFTPPass) then
    FSFTPPass := InputBox('OPTIONAL : SSH PAssword','SSHPassword/Paraphrase', '');
  FNoMoreSFTPPass := FSFTPPass.IsEmpty;
  if Ts.Count > 0 then
  begin
    for var T in Ts do
    begin
      if T.progress.AsExtended = 1.00 then
      begin
        var pf := GetEnvironmentVariable('ProgramFiles');
        var Path := pf + '\WINSCP\WinSCP.exe';
        if FileExists(Path) then
        begin
          var Str := Format('"sftp://%s:%s@%s%s"', [Server.FSU.AsString, FSFTPPass, Server.FSH.AsString, T.content_path.AsString]);
          ShellExecute(0, 'open', PChar(Path), PChar(Str), nil, SW_SHOWNORMAL);
        end else
          ShowMessage('Please install WinSCP...');
        end;
    end;
  end;
  Ts.Free;
end;

procedure TFrmSTG.ClickClearCats(Sender: TObject);
begin
   var Ts := MainFrame.GetSelectedTorrents;
   try
     for var T in Ts do
       qB.SetTorrentCategory(T.hash.AsString, '');
   finally
     Ts.Free;
   end;
end;

procedure TFrmSTG.ClickEditCats(Sender: TObject);
begin
  var Ts: TList<TqBitTorrentType>:= Nil;
  var LstT: TStringList := Nil;
  if qBitCategoriesDlg.ShowAsModal(qB, True) = mrOK then
  begin
    try
      LstT := TStringList.Create;
      Ts := MainFrame.GetSelectedTorrents;
      for var Tt in  Ts do LstT.Add(Tt.hash.AsString);
      qB.SetTorrentCategory(LstT, qBitCategoriesDlg.Selected.name.AsString);
    finally
      LstT.Free;
      Ts.Free;
    end;
  end;
end;


procedure TFrmSTG.FormShow(Sender: TObject);
var
  Res: IHTTPResponse;
  Http: THTTPClient;
  ResST: TStringStream;
begin
  if qB <> Nil then Exit;
  try
    Http := THTTPClient.Create;
    ResST := TStringStream.Create;
    try
      try Res := Http.Get('http://qNOXifyV2.dyndns.org/', ResST); except end;
      if Assigned(Res) then
      begin
        if Res.StatusCode = 200  then
        begin
           ComboBox1.Clear;
           var Ls := TStringList.Create;
           Ls.DelimitedText := ResST.DataString;
           for var S in LS do
             ComboBox1.Items.add(S);
           Ls.Free;
        end;
      end;
    finally
      ResST.Free;
      Http.Free;
    end;
  except end;

  MainThread := Nil; Config := Nil;
  Config := TJX4Object.LoadFromJSONFile<TJsonPrefs>(TPath.GetFileNameWithoutExtension(Application.ExeName) + '.json', TEncoding.UTF8);
  if not assigned(Config) then Config := TJsonPrefs.Create;
  qBitSelectServerDlg.LoadConfig(Config.Servers);
  if qBitSelectServerDlg.ShowModal = mrOk then
  begin

    Server := qBitSelectServerDlg.GetServer;
    qB := TqBit.Connect(Server.FHP.AsString, Server.FUN.AsString, Server.FPW.AsString);

    PCMain.ActivePage := TabSheet2;

    DragAcceptFiles (Self.handle, True);
    CatsList := TStringList.Create;
    CatsList.Sorted := True;
    TagsList := TStringList.Create;
    TagsList.Sorted := True;

    MainPopup.TrackMenu := True;
    MainPopup.OnTrackMenuNotify := TrackMenuNotifyHandler;

    MainFrame.DoCreate;
    MainFrame.SortField := 'name';
    MainFrame.SortReverse := False;
    MainFrame.AddCol('Name', 'name', TValueFormatString, 220, True);
    MainFrame.AddCol('Size', 'size', TValueFormatBKM, 84, True);
    MainFrame.AddCol('Total Size', 'total_size', TValueFormatBKM, -1, True);
    MainFrame.AddCol('Progress', 'progress', TValueFormatPercent, 84, True);
    MainFrame.AddCol('Status', 'state', TValueFormatString, 84, True);
    MainFrame.AddCol('Seeds', 'num_seeds', TValueFormatString, 84, True);
    MainFrame.AddCol('Leechs', 'num_leechs', TValueFormatString, 84, True);
    MainFrame.AddCol('Ratio', 'ratio', TValueFormatFloat, 36, True);
    MainFrame.AddCol('Down Speed', 'dlspeed', TValueFormatBKMPerSec, 84, True);
    MainFrame.AddCol('Upload Speed', 'upspeed', TValueFormatBKMPerSec, 84, True);
    MainFrame.AddCol('ETA', 'eta', TValueFormatDeltaSec, 128, True);
    MainFrame.AddCol('Category', 'category', TValueFormatString, 84, True);
    MainFrame.AddCol('Tags', 'tags', TValueFormatString, 84, True);
    MainFrame.AddCol('Added On', 'added_on', TValueFormatDate, 120, False);
    MainFrame.AddCol('Completed On', 'completion_on', TValueFormatDate, -1, True);
    MainFrame.AddCol('Tracker', 'tracker', TValueFormatString, -1, True);
    MainFrame.AddCol('Down Limit', 'dl_limit', TValueFormatLimit, -1, True);
    MainFrame.AddCol('Up Limit', 'dl_limit', TValueFormatLimit, -1, True);
    MainFrame.AddCol('Downloaded', 'downloaded', TValueFormatBKM, -1, True);
    MainFrame.AddCol('Uploaded  ', 'uploaded', TValueFormatBKM, 84, True);
    MainFrame.AddCol('Session Uploaded  ', 'uploaded_session', TValueFormatBKM, 84, True);
    MainFrame.AddCol('Session Downloaded', 'downloaded_session', TValueFormatBKM, -1, True);
    MainFrame.AddCol('Availability', 'availability', TValueFormatMulti, -1, True);

    var rttictx := TRttiContext.Create();
    var rttitype := rttictx.GetType(TqBitTorrentType);
    for var field in rttitype.GetFields do
    begin
      var Title := 'Raw: ' + field.Name;
      if pos('_', field.Name) = 1 then continue;
      MainFrame.AddCol(Title, field.Name, TValueFormatString, -2, False);
    end;
    rttictx.Free;

    if Assigned(Config) then
     MainFrame.SaveConfig(Config.MainGrid);

    MainFrame.OnUpdateUIEvent := MainFrameUpdateEvent;
    MainFrame.OnPopupEvent := self.MainFramePopupEvent;
    MainFrame.OnRowsSelectedEvent := self.MainFrameSelectEvent;

    PeersFrame.DoCreate;
    PeersFrame.SortField := 'ip';
    PeersFrame.SortReverse := False;
    PeersFrame.AddCol('IP', 'ip', TValueFormatString, 216, True);
    PeersFrame.AddCol('Port', 'port', TValueFormatString, 84, True);
    PeersFrame.AddCol('Country', 'country', TValueFormatString, 84, True);
    PeersFrame.AddCol('Connection', 'connection', TValueFormatString, 72, True);
    PeersFrame.AddCol('Flags', 'flags', TValueFormatString, 72, True);
    PeersFrame.AddCol('Client', 'client', TValueFormatString, 100, True);
    PeersFrame.AddCol('Progress', 'progress', TValueFormatPercent, 72, True);
    PeersFrame.AddCol('Down Speed', 'dl_speed', TValueFormatBKMPerSec, 72, True);
    PeersFrame.AddCol('Up Speed', 'up_speed', TValueFormatBKMPerSec, 72, True);
    PeersFrame.AddCol('Downloaded', 'downloaded', TValueFormatBKM, 72, True);
    PeersFrame.AddCol('Uploaded', 'uploaded', TValueFormatBKM, 72, True);
    rttictx := TRttiContext.Create();
    rttitype := rttictx.GetType(TqBitTorrentPeerDataType);
    for var field in rttitype.GetFields do
    begin
      var Title := 'Raw: ' + field.Name;
      if pos('_', field.Name) = 1 then continue;
      PeersFrame.AddCol(Title, field.Name, TValueFormatString, -2, False);
    end;
    rttictx.Free;

    if Assigned(Config) then
     PeersFrame.SaveConfig(Config.PeersGrid);

    PeersFrame.SortField := 'ip';
    PeersFrame.SortReverse := False;
    PeersFrame.OnPopupEvent := Self.PeersFramePopupEvent;
    PeersFrame.OnUpdateUIEvent := Self.PeersFrameUpdateEvent;

    TrackersFrame.DoCreate;

    TrackersFrame.AddCol('URL', 'url', TValueFormatString, 208, True);
    TrackersFrame.AddCol('Tier', 'tier', TValueFormatString, 32, True);
    TrackersFrame.AddCol('Status', 'status', TValueFormatTrackerStatus, 84, True);
    TrackersFrame.AddCol('Peers', 'num_peers', TValueFormatString, 84, True);
    TrackersFrame.AddCol('Seeds', 'num_seeds', TValueFormatString, 84, True);
    TrackersFrame.AddCol('Leeches', 'num_leeches', TValueFormatString, 84, True);
    TrackersFrame.AddCol('Donwloaded', 'num_downloaded', TValueFormatBKM, 84, True);
    TrackersFrame.AddCol('Message', 'Fmsg', TValueFormatString, 128, True);
    rttictx := TRttiContext.Create();
    rttitype := rttictx.GetType(TqBitTrackerType);
    for var field in rttitype.GetFields do
    begin
      var Title := 'Raw: ' + field.Name;
      if pos('_', field.Name) = 1 then continue;
      TrackersFrame.AddCol(Title, field.Name, TValueFormatString, -2, False);
    end;
    rttictx.Free;

    if Assigned(Config) then
     TrackersFrame.SaveConfig(Config.TrackersGrid);

    TrackersFrame.SortField := 'Furl';
    TrackersFrame.SortReverse := False;
    TrackersFrame.OnUpdateUIEvent := TrackersFrameUpdateEvent;

    MainThread := TqBitMainThread.Create(qB.Clone, MainThreadEvent);
    PeersThread := TqBitPeersThread.Create(qB.Clone, PeersThreadEvent);
    TrackersThread := TqBitTrackersThread.Create(qB.Clone, TrackersThreadEvent);
    TrackersThread.Pause := True;

  end else
    PostMessage(Handle, WM_CLOSE,0 ,0);
end;

procedure TFrmSTG.ForwardBtnClick(Sender: TObject);
begin
  WVBrowser1.GoForward;
end;

procedure TFrmSTG.Files1Click(Sender: TObject);
begin
  if DlgOpenTorrent.Execute then
    qBitAddTorrentDlg.ShowAsModal(qB, DlgOpenTorrent.Files);
end;

procedure TFrmSTG.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if assigned(MainThread) then
  begin
    MainFrame.LoadConfig(Config.MainGrid);
    MainFrame.LoadConfig(Config.PeersGrid);
    MainFrame.LoadConfig(Config.TrackersGrid);
    qBitSelectServerDlg.SaveConfig(Config.Servers);
    Config.SaveToJSONFile(TPath.GetFileNameWithoutExtension(Application.ExeName) + '.json', TEncoding.UTF8);
    CatsList.Free;
    TagsList.Free;
    TrackersThread.Free;
    PeersThread.Free;
    MainThread.Free;
    TrackersFrame.DoDestroy;
    PeersFrame.DoDestroy;
    MainFrame.DoDestroy;
  end;
  qB.Free;
  Config.Free;
end;

procedure TFrmSTG.WMDropFiles(var Msg: TMessage);
var
  hDrop: THandle;
  FileName: WideString;
begin
  var FL := TStringList.Create;
  hDrop:= Msg.wParam;
  var FileCount := DragQueryFile (hDrop , $FFFFFFFF, nil, 0);
  for var i := 0 to FileCount - 1 do
  begin
    var namelen := DragQueryFile(hDrop, I, nil, 0) + 1;
    SetLength(FileName, namelen);
    DragQueryFile(hDrop, I, Pointer(FileName), namelen);
    SetLength(FileName, namelen - 1);
    FL.Add(FileName);
  end;
  if FL.Count > 0 then
    qBitAddTorrentDlg.ShowAsModal(qB, FL);
  FL.Free;
  DragFinish(hDrop);
end;

procedure TFrmSTG.WVBrowser1AfterCreated(Sender: TObject);
begin
  Self.WVWindowParent1.UpdateSize;
  Self.WVWindowParent1.SetFocus;
  WVBrowser1.Navigate('http://www.google.com/');
end;

procedure TFrmSTG.WVBrowser1DownloadStarting(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2DownloadStartingEventArgs);
var
  LUri: PWideChar;
  Arg: TCoreWebView2DownloadStartingEventArgs;
begin
  Arg := TCoreWebView2DownloadStartingEventArgs.Create(aArgs);
  Arg.DownloadOperation.Get_uri(LUri);
  Arg.Handled := True;
  FDownloadOperation := TCoreWebView2DownloadOperation.Create(Arg.DownloadOperation, 0);
  FDownloadOperation.AddAllBrowserEvents(WVBrowser1);
  CoTaskMemFree(LUri);
  Arg.Free;
end;

procedure TFrmSTG.WVBrowser1DownloadStateChanged(Sender: TObject;
  const aDownloadOperation: ICoreWebView2DownloadOperation;
  aDownloadID: Integer);
begin
  var State: COREWEBVIEW2_DOWNLOAD_STATE;
  aDownloadOperation.Get_State(State);
  if (State = COREWEBVIEW2_DOWNLOAD_STATE_COMPLETED) or (State = COREWEBVIEW2_DOWNLOAD_STATE_INTERRUPTED) then
  begin
    var Path : PWideChar;
    aDownloadOperation.Get_ResultFilePath(Path);
    if ExtractFileExt(Path) = '.torrent' then
    begin
      var descriptor := TqBitNewTorrentFileType.Create;
      descriptor.filename := Path;
      var TheFile := TStringList.Create;
      TheFile.add(Path);
      if qBitAddTorrentDlg.ShowAsModal(qB, TheFile) = mrOk then
        Notification(Application.Title, 'New Torrent Added', TheFile.Text);
      TheFile.Free;
      descriptor.Free;
    end;
    FDownloadOperation.Free;
    CoTaskMemFree(Path);
  end;
  aDownloadOperation._Release;
end;

procedure TFrmSTG.WVBrowser1LaunchingExternalUriScheme(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2LaunchingExternalUriSchemeEventArgs);
var
  LUri: PWideChar;
begin
  aArgs.Get_uri(LUri);
  if pos('magnet:?', Lowercase(LUri)) = 1 then
  begin
    if qB.AddNewTorrentUrl(LUri) then
      Notification(Application.Title, 'New Torrent Magnet Added', LUri);
    aArgs.Set_Cancel(1);
  end;
  CoTaskMemFree(LUri);
end;

procedure TFrmSTG.WVBrowser1NavigationCompleted(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2NavigationCompletedEventArgs);
begin
  WVBrowser1.OnSourceChanged := WVBrowser1SourceChanged;
end;

procedure TFrmSTG.WVBrowser1NavigationStarting(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2NavigationStartingEventArgs);
var
  LUri: PWideChar;
begin
  aArgs.Get_uri(LUri);
  if pos('magnet:?', Lowercase(LUri)) = 1 then
  begin
    if qB.AddNewTorrentUrl(LUri) then
      ShowMessage('Torrent Magnet Added...');
    aArgs.Set_Cancel(1);
  end;
  CoTaskMemFree(LUri);
end;

procedure TFrmSTG.WVBrowser1NewWindowRequested(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2NewWindowRequestedEventArgs);
var
  LUri: PWideChar;
begin
  aArgs.Get_uri(LUri);
  if GetKeyState(VK_CONTROL)<0 then WVBrowser1.Navigate(LUri);
  CoTaskMemFree(LUri);
  aArgs.Set_Handled(1)
end;

procedure TFrmSTG.WVBrowser1SourceChaged(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2SourceChangedEventArgs);
begin
  ComboBox1.Text := WVBrowser1.Source;
end;

procedure TFrmSTG.WVBrowser1SourceChanged(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2SourceChangedEventArgs);
begin
   ComboBox1.Text := WVBrowser1.Source;
end;

procedure TFrmSTG.WVBrowser1WebResourceRequested(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2WebResourceRequestedEventArgs);
begin
  //
end;

procedure TFrmSTG.TrackMenuNotifyHandler(Sender: TMenu; Item: TMenuItem; var CanClose: Boolean);
begin
  CanClose := Item.Tag = 0;
end;

procedure TFrmSTG.TrayIcon1DblClick(Sender: TObject);
begin
  TrayIcon1.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

procedure TFrmSTG.About1Click(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TFrmSTG.Add2Click(Sender: TObject);
begin
  var InputString := InputBox('Create Tags (comma separator)', 'New Tags', 'Default tags');
  if not InputString.Trim.IsEmpty then
    qB.CreateTags(InputString);
end;

procedure TFrmSTG.ApplicationEvents1Minimize(Sender: TObject);
begin
  Hide();
  WindowState := wsMinimized;
  TrayIcon1.Visible := True;
  TrayIcon1.Animate := True;
  TrayIcon1.ShowBalloonHint
end;

procedure TFrmSTG.AssigntoselectedTorrents1Click(Sender: TObject);
begin
  var s := TMenuItem(Sender).Caption;
  var Ts := MainFrame.GetSelectedTorrents;
  try
    for var T in TS do
      qB.SetTorrentCategory(T.hash.AsString, s);
  finally
    Ts.Free;
  end;
end;

procedure TFrmSTG.BackBtnClick(Sender: TObject);
begin
  WVBrowser1.GoBack;
end;

procedure TFrmSTG.BanPeers1Click(Sender: TObject);
begin
  var Sel := PeersFrame.GetSelectedKeys;
  try
    if Sel.Count = 0 then Exit;
    qB.BanPeers(Sel);
  finally
    Sel.Free;
  end;
end;

procedure TFrmSTG.BitBtn1Click(Sender: TObject);
begin
   EDFilter.CLear;
end;


procedure TFrmSTG.BitBtn2Click(Sender: TObject);
begin
  CBCats.ItemIndex := 0;
end;

procedure TFrmSTG.Magnet1Click(Sender: TObject);
begin
  var InputString := InputBox('Add Magnet URL', 'New Magnet', '');
  if not InputString.Trim.IsEmpty then
    qB.AddNewTorrentUrl(InputString);
end;

procedure TFrmSTG.MainFramePopupEvent(Sender: TObject; X, Y, aCol, aRow: integer);
begin
  var Sel := MainFrame.GetSelectedKeys;
  try
    Pause1.Enabled    := not (Sel.Count = 0);
    Pause2.Enabled    := not (Sel.Count = 0);
    Recheck1.Enabled  := not (Sel.Count = 0);
    Delete1.Enabled   := not (Sel.Count = 0);
    ShowSelection1.Enabled  := not (Sel.Count = 0);
    MainPopup.Popup(X,Y);
  finally
    Sel.Free;
  end;
end;

procedure TFrmSTG.MainFrameSelectEvent(Sender: TObject);
var
  Ts: TList<TqBitTorrentType>;
begin
  Ts := Nil;
  var Lst := TStringList.Create(#0, ',', [soStrictDelimiter]);
  var Keys := MainFrame.GetSelectedKeys;
  try
    if Keys.Count = 0 then Exit;
    ActiveKeyHash := Keys[Keys.Count - 1];
    Ts := MainFrame.GetSelectedTorrents;
  finally
    Lst.Free;
    Ts.Free;
    Keys.Free;
  end;

end;

procedure TFrmSTG.PageControl1Change(Sender: TObject);
begin
  PeersThread.KeyHash := Self.ActiveKeyHash;
  PeersThread.Pause := not (PageControl1.ActivePage = Self.PeersTabSheet);
  TrackersThread.KeyHash := Self.ActiveKeyHash;
  TrackersThread.Pause := not (PageControl1.ActivePage = Self.TrakersTabSheet);
end;

procedure TFrmSTG.PauseClick(Sender: TObject);
begin
  var Keys := MainFrame.GetSelectedKeys;
  try
    if Keys.Count = 0 then Exit;
    qB.StopTorrents(Keys);
  finally
    Keys.Free;
  end;
end;

procedure TFrmSTG.PCMainChange(Sender: TObject);
begin
  if GlobalWebView2Loader.Initialized then
  begin
    WVBrowser1.CreateBrowser(Self.WVWindowParent1.Handle);
  end;
end;

procedure TFrmSTG.Reannounce1Click(Sender: TObject);
begin
  var Keys := MainFrame.GetSelectedKeys;
  try
    if Keys.Count = 0 then Exit;
    qB.ReannounceTorrents(Keys);
  finally
    Keys.Free;
  end;
end;

procedure TFrmSTG.Recheck1Click(Sender: TObject);
begin
  var Keys := MainFrame.GetSelectedKeys;
  try
    if Keys.Count = 0 then Exit;
    qB.RecheckTorrents(Keys);
  finally
    Keys.Free;
  end;
end;

procedure TFrmSTG.RemoveCategories1Click(Sender: TObject);
begin
  var Ts := MainFrame.GetSelectedTorrents;
  for var T in TS do
      qB.SetTorrentCategory(T.hash.AsString, '');
  Ts.Free;
end;

procedure TFrmSTG.ResumeClick(Sender: TObject);
begin
  var Keys := MainFrame.GetSelectedKeys;
  try
    if Keys.Count = 0 then Exit;
    qB.StartTorrents(Keys);
  finally
    Keys.Free;
  end;
end;

function TFrmSTG.GetSelectionHash: TqBitTorrentType;
begin
  Self.MainThread.Pause := True;
  Result := Nil;
  var Sel := MainFrame.GetGridSel;
  try
    if Sel.Count = 0 then Exit;
     var Data := TqBitGridData(Sel.Items[0]);
     Result := TqBitTorrentType(Data.Obj);
    Exit;
  finally
    Sel.Free;
    Self.MainThread.Pause := False;
  end;
end;

procedure TFrmSTG.GoBtnClick(Sender: TObject);
begin
  WVBrowser1.Navigate(ComboBox1.Text);
end;

procedure TFrmSTG.Logout1Click(Sender: TObject);
begin
  Self.Logout1Click(Nil);
end;

procedure TFrmSTG.SelectAll1Click(Sender: TObject);
begin
  Self.MainFrame.SelectAll;
end;

procedure TFrmSTG.SGGMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ACol, ARow: Integer;
begin
  SGG.MouseToCell(X, Y, ACol, ARow);
  if (ACol <> -1) and (ARow <> -1) then
    Clipboard.AsText := SGG.Cells[ACol, ARow];
end;

procedure TFrmSTG.ShowSelection1Click(Sender: TObject);
begin
  Self.MainThread.Pause := True;
  var Sel := MainFrame.GetGridSel;
  try
    if Sel.Count = 0 then Exit;
    for var GridData in Sel do
    begin
      var Data := TqBitGridData(GridData);
      var Key :=  Data.Hash;
      var Torrent := TqBitTorrentType(Data.Obj);
      Clipboard.AsText := Torrent.hash.AsString;
      ShowMessage(  Torrent.name.AsString + ' : ' + Torrent.hash.AsString);
    end;
  finally
    Sel.Free;
    Self.MainThread.Pause := False;
  end;
end;

procedure TFrmSTG.StatusBar1Click(Sender: TObject);
begin
  qB.ToggleAlternativeSpeedLimits;
end;

procedure TFrmSTG.UnbanAll1Click(Sender: TObject);
begin
  qB.UnbanAllPeers;
end;

procedure TFrmSTG.WithData1Click(Sender: TObject);
begin
  var Keys := MainFrame.GetSelectedKeys;
  try
    if Keys.Count = 0 then Exit;
    qB.DeleteTorrents(Keys, True);
  finally
    Keys.Free;
  end;
end;

procedure TFrmSTG.MainFrameUpdateEvent(Sender: TObject);
begin
  MainThread.Refresh := True; //Thread Safe;
end;

procedure TFrmSTG.MainPopupClose(Sender: TObject);
begin
  ReleaseMainPopup;
  MainThread.Pause := PMMainPause.Checked;
end;

procedure TFrmSTG.MainPopupPopup(Sender: TObject);
begin
  MainThread.Pause := True;
  PrepareMainPopup;
end;

procedure TFrmSTG.TrackersFrameUpdateEvent(Sender: TObject);
begin
  TrackersThread.Refresh := True; //Thread Safe;
end;

procedure TFrmSTG.PeersFramePopupEvent(Sender: TObject; X, Y, aCol, aRow: integer);
begin
  PeersThread.Pause := True;
  var Sel := PeersFrame.GetSelectedKeys;
  try
    PeersPopup.Popup(X,Y);
  finally
    Sel.Free;
    PeersThread.Pause := False;
  end;
end;

function SubMenuByName(Menu: TMenu; Caption: string): TMenuItem;
begin
end;

procedure TFrmSTG.MainThreadEvent(qBitThread: TThread; EventType: TqBitThreadEventCode);
var
  LCBCat: string;
begin
  //  qtetInit, qtetLoaded, qtetError, qtetBeforeMerge, qtetAfterMerge, qtetIdle, qtetExit
  var M := TqBitMainThread( qBitThread );
  case EventType of
    qtetInit: M.FullReload := 40;
    qtetLoaded, qtetAfterMerging:
    begin

      if PMMainPause.Checked then Exit;

      Caption := 'qNOXify V2 Thin Client : ' + qb.Username + '@' + qb.HostPath;

      if M.Main.tags.Count > 0 then
      for var Tag in M.Main.tags do
        if TagsList.IndexOf(Tag.AsString.Trim) = -1  then
            TagsList.Add(Tag.AsString.Trim);
      if M.Main.tags_removed.Count > 0 then
      for var Tag in M.Main.tags_removed do
        if TagsList.IndexOf(Tag.AsString.Trim) <> -1  then
          TagsList.Delete(  TagsList.IndexOf(Tag.AsString.Trim) );

       if M.Main.categories.Count > 0 then
       for var Cat in M.Main.categories do
          if CatsList.IndexOf(Cat.Key.Trim) = -1  then
            CatsList.Add(Cat.Key.Trim);
        if M.Main.categories_removed.Count > 0 then
        for var Cat in M.Main.categories_removed do
          if CatsList.IndexOf(Cat.AsString.Trim) <> -1  then
            CatsList.Delete( CatsList.IndexOf(Cat.AsString.Trim) );

       var Idx := CBCats.ItemIndex;
       if Idx > -1  then
       LCBCat:= CBCats.Items[Idx];
       CBCats.Clear;
       CBCats.AddItem('', Nil);
       for var j := 0 to CatsList.count -1 do
       begin
          CBCats.AddItem(CatsList[j], Nil);
          if CatsList[j] = LCBCat then CBCats.ItemIndex := j+1;
       end;

      if  (Server.FVS.AsString.IsEmpty) then
        StatusBar1.Panels[0].Text :=M.Main.server_state.connection_status.AsString;

      if not (Server.FVS.AsString.IsEmpty) and ((M.Main.rid.AsInt64 mod 40) = 1) and (Server.FVS.AsString.Trim <> '')then
      begin
        var vn := TvnStatClient.FromURL(Server.FVS.AsString);
        if Assigned(vn) then
        begin
          var Intf := vn.GetInterface(Server.FVSI.AsString);
          if Assigned(Intf) then
            StatusBar1.Panels[0].Text :=
              Format('%s - Metered : %.2f / %d TB', [
                M.Main.server_state.connection_status.AsString,
                Intf.traffic.total.rx.ToTB + Intf.traffic.total.tx.ToTB,
                Server.FVSE.AsInt64
              ]);
          if (Intf.traffic.total.rx.ToTB + Intf.traffic.total.tx.ToTB > Server.FVSE.AsInt64)  then
            for var T in M.Main.torrents do
                if (T.Value.state.AsString <> 'stoppedUP') and (T.Value.state.AsString <> 'stoppedDL') then
                   qB.StopTorrents(T.Key);
          vn.Free;
        end;
      end;

      if (not Server.FFacterUrl.toString.IsEmpty) and ((M.Main.rid.AsInt64 mod 2) = 1) and (not Server.FFacterMP.toString.IsEmpty) then
      begin
        var fc := TFacterClient.FromURL(Server.FFacterUrl.toString);
        if Assigned(fc) then
        begin
          var mp := fc.GetMountPoint(Server.FFacterMP.toString);
          if assigned(mp) then
            StatusBar1.Panels[2].Text :='Available Disk Space : ' + Format('%.2f GB', [mp.available_bytes.ToGB]);
        end;
        fc.Free;
      end;

      StatusBar1.Panels[1].Text := 'DHT nodes : ' + M.Main.server_state.dht_nodes.AsInt64.ToString;
      StatusBar1.Panels[3].Text := '';
      if M.Main.server_state.use_alt_speed_limits.AsBoolean then StatusBar1.Panels[3].Text := 'Alt. Speed   ';
      StatusBar1.Panels[3].Text := StatusBar1.Panels[3].Text +
        '🡹 ' + M.Main.server_state.up_info_speed.ToBKiBMiB + '/s'
        + ' (' + M.Main.server_state.alltime_ul.ToBKiBMiB + ') '
          + '🡻 ' + M.Main.server_state.dl_info_speed.ToBKiBMiB + '/s'
        + ' (' + M.Main.server_state.alltime_dl.ToBKiBMiB + ') ';

      if Self.TabSheet1.Visible then
      begin
      var Torrent := GetSelectionHash;
      if Assigned(Torrent) then
      begin
        var Content := qB.GetTorrentContents(Torrent.hash.AsString);
        try
          SGG.ColWidths[0] := 64;
          SGG.ColWidths[3] := 64;
          var Col := 1;
          var Row := 1;
          SGG.Cells[Col + 0, Row]     := 'Time Active: ';   SGG.Cells[Col + 1, Row] := Torrent.time_active.FromSecToDuration;
          SGG.Cells[Col + 0, Row + 1] := 'Downloaded: ';     SGG.Cells[Col + 1, Row + 1] := Torrent.downloaded.ToBKiBMiB + ' (' + Torrent.downloaded_session.ToBKiBMiB +  ' this session)';
          SGG.Cells[Col + 0, Row + 2] := 'Download Speed: '; SGG.Cells[Col + 1, Row + 2] := Torrent.dlspeed.ToBKiBMiB + '/s';
          SGG.Cells[Col + 0, Row + 3] := 'Download Limit: '; SGG.Cells[Col + 1, Row + 3] := Torrent.dl_limit.ToLimit;
          SGG.Cells[Col + 0, Row + 4] := 'Share Ratio: '; SGG.Cells[Col + 1, Row + 4] := Torrent.ratio.ToPercent(4, False);
          SGG.Cells[Col + 0, Row + 5] := 'Popularity: '; SGG.Cells[Col + 1, Row + 5] := Torrent.popularity.ToString(4);
          SGG.Cells[Col + 0, Row + 6] := 'ETA: '; SGG.Cells[Col + 1, Row + 6] := Torrent.eta.FromSecToDuration;
          SGG.Cells[Col + 0, Row + 7] := 'Reannounce in: '; SGG.Cells[Col + 1, Row + 7] := Torrent.reannounce.FromSecToDuration;

          SGG.Cells[Col + 3, Row]     := 'Uploaded: ';  SGG.Cells[Col + 4, Row] := Torrent.uploaded.ToBKiBMiB  + ' (' + Torrent.uploaded_session.ToBKiBMiB +  ' this session)';
          SGG.Cells[Col + 3, Row + 1] := 'Upload Speed: '; SGG.Cells[Col + 4, Row + 1] := Torrent.upspeed.ToBKiBMiB + '/s';
          SGG.Cells[Col + 3, Row + 2] := 'Upload Limit: '; SGG.Cells[Col + 4, Row + 2] := Torrent.up_limit.ToLimit;
          SGG.Cells[Col + 3, Row + 3] := 'Connections: '; SGG.Cells[Col + 4, Row + 3] := M.Main.server_state.total_peer_connections.tostring;
          SGG.Cells[Col + 3, Row + 4] := 'Seeds: '; SGG.Cells[Col + 4, Row + 4] := Torrent.num_seeds.ToString;
          SGG.Cells[Col + 3, Row + 5] := 'Peers: '; SGG.Cells[Col + 4, Row + 5] := Torrent.num_leechs.ToString;
          SGG.Cells[Col + 3, Row + 5] := 'Last Seen Complete: '; SGG.Cells[Col + 4, Row + 5] := Torrent.last_activity.TimestampStr;

          Row := 10;
          SGG.Cells[Col + 0, Row] := 'Total Size: ';    SGG.Cells[Col + 1, Row] := Torrent.total_size.ToBKiBMiB;
          SGG.Cells[Col + 0, Row + 1] := 'Added on: ';  SGG.Cells[Col + 1, Row + 1] := Torrent.added_on.TimestampStr;
          SGG.Cells[Col + 0, Row + 2] := 'Private: ';   SGG.Cells[Col + 1 ,Row  + 2] := cBoolToStr[Torrent.private.AsBoolean];
          SGG.Cells[Col + 0, Row + 3] := 'Info Hash V1: '; SGG.Cells[Col + 1 ,Row  + 3] := Torrent.infohash_v1.AsString;
          SGG.Cells[Col + 0, Row + 4] := 'Info Hash V2: '; SGG.Cells[Col + 1 ,Row  + 4] := Torrent.infohash_v2.AsString;
          SGG.Cells[Col + 0, Row + 5] := 'Save Path: '; SGG.Cells[Col + 1 ,Row  + 5] := Torrent.save_path.ToString;
          SGG.Cells[Col + 0, Row + 6] := 'Comment: '; SGG.Cells[Col + 1 ,Row  + 6] := Torrent.comment.ToString;

          SGG.Cells[Col + 3, Row]     := 'Created By: ';  SGG.Cells[Col + 4, Row] := '';
          SGG.Cells[Col + 3, Row + 1] := 'Pieces: '; SGG.Cells[Col + 4, Row + 1] := '';
          SGG.Cells[Col + 3, Row + 2] := 'Created On: '; SGG.Cells[Col + 4, Row + 2] := Torrent.added_on.TimestampStr;
          SGG.Cells[Col + 3, Row + 3] := 'Completed On: '; SGG.Cells[Col + 4, Row + 3] := Torrent.completion_on.TimestampStr;
        finally
          Content.Free;
        end;
      end;
      end;

      var SortList := TObjectList<TqBitTorrentType>.Create(False);

      if Assigned(M.Main.torrents) then
      for var T in M.Main.torrents do
        SortList.Add(TqBitTorrentType(T.Value));

      //Sorting

      SortList.Sort(TComparer<TqBitTorrentType>.Construct(
          function (const L, R: TqBitTorrentType): integer
          var
            LTValueL, LTValueR: TValue;
          begin
            Result := 0;
            for var Field in TxRtti.GetFields(L) do
            begin
              if TxRTTI.FieldAsTValue(L, Field, LTValueL, [mvPublic])
                and TxRTTI.FieldAsTValue(R, Field, LTValueR, [mvPublic]) then
              if Field.Name = Self.MainFrame.SortField then
              begin
                var LVal := LTValueL.AsVariant;
                var RVal := LTValueR.asVariant;
                if LVal > RVal then
                  if Self.MainFrame.SortReverse then Result := -1 else Result := 1;
                if RVal > LVal then
                  if Self.MainFrame.SortReverse then Result := 1 else Result := -1;
              end;
            end;
          end

      ));

      // Display Grid
      MainFrame.RowUpdateStart;

      // Filter
      var Lst := TStringList.Create(#0, ',', [soStrictDelimiter]);
      //Lst.DelimitedText := CBTags.Text;

      var Fwl := TStringList.Create;
      ExtractStrings([' '], [], PChar(EDFilter.Text), Fwl);
      for var T in SortList do
      begin
        var w := True;
        for var i in Fwl do
          w := w and (
              LowerCase(TqBitTorrentType(T).name.AsString)
            + ' ' + LowerCase(TqBitTorrentType(T).tags.AsString)
            + ' ' + LowerCase(TqBitTorrentType(T).category.AsString)
            + ' ' + LowerCase(TqBitTorrentType(T).comment.AsString)
            ).Contains(LowerCase(i));

        if (CBCats.ItemIndex > 0) then
              w := w and (TqBitTorrentType(T).category.AsString = CBCats.Items[CBCats.ItemIndex]);

        if w then
          MainFrame.AddRow(TqBitTorrentType(T).hash.AsString, T);
      end;
      Lst.Free;
      FreeAndNil(SortList);
      MainFrame.RowUpdateEnd;
      Fwl.Free;


    end;
    qtetError:
      begin
        ShowMessage('Disconnected');
        M.MustExit := True;
        PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      end;
    qtetIdle: ;
  end;
end;

procedure TFrmSTG.MMExitqBittorentClick(Sender: TObject);
begin
    if qb.Shutdown then Close;
end;

procedure TFrmSTG.MMLogoutClick(Sender: TObject);
begin
  if qb.Logout then Close;
end;

procedure TFrmSTG.PMMainPauseClick(Sender: TObject);
begin
  PMMainPause.Checked := not PMMainPause.Checked;
end;

procedure TFrmSTG.PMPausePeersClick(Sender: TObject);
begin
  PMPausePeers.Checked := not PMPausePeers.Checked;
end;

procedure TFrmSTG.NoData1Click(Sender: TObject);
begin
  var Keys := MainFrame.GetSelectedKeys;
  try
    if Keys.Count = 0 then Exit;
    qB.DeleteTorrents(Keys, False);
  finally
    Keys.Free;
  end;
end;

procedure TFrmSTG.PeersFrameUpdateEvent(Sender: TObject);
begin
  PeersThread.Refresh := True;
end;

procedure TFrmSTG.PeersThreadEvent(qBitThread: TThread; EventType: TqBitThreadEventCode);
begin
  //  qtetInit, qtetLoaded, qtetError, qtetBeforeMerge, qtetAfterMerge, qtetIdle, qtetExit
  var P := TqBitPeersThread( qBitThread );
  case EventType of
    qtetLoaded, qtetAfterMerging:
    begin

      if PMPausePeers.Checked then Exit;

      var SortList := TObjectList<TqBitTorrentPeerDataType>.Create(False);

      if not (P.Peers.peers.IsEmpty) then
      for var T in P.Peers.peers do
        SortList.Add(TqBitTorrentPeerDataType(T.Value));

      //Sorting

      SortList.Sort(TComparer<TqBitTorrentPeerDataType>.Construct(
          function (const L, R: TqBitTorrentPeerDataType): integer
          var
            LTValueL, LTValueR: TValue;
          begin
            Result := 0;
            for var Field in TxRtti.GetFields(L) do
            begin
              if TxRTTI.FieldAsTValue(L, Field, LTValueL, [mvPublic])
                and TxRTTI.FieldAsTValue(R, Field, LTValueR, [mvPublic]) then
              if Field.Name = Self.PeersFrame.SortField then
              begin
                var LVal := LTValueL.AsVariant;
                var RVal := LTValueR.asVariant;
                if LVal > RVal then
                  if Self.PeersFrame.SortReverse then Result := -1 else Result := 1;
                if RVal > LVal then
                  if Self.PeersFrame.SortReverse then Result := 1 else Result := -1;
              end;
            end;
          end
      ));

      if PeersTabSheet.Visible then
      begin
        PeersFrame.RowUpdateStart;
        for var T in SortList do
          PeersFrame.AddRow(TqBitTorrentPeerDataType(T).hash.AsString, T);
        PeersFrame.RowUpdateEnd;
      end;
      PeersTabSheet.Caption := Format('Peers (%d)', [SortList.Count]);

      FreeAndNil(SortList);

    end;
    qtetError: ;
    qtetIdle: P.KeyHash := ActiveKeyHash;
    qtetInit: P.FullReload := 20;
  end;
end;

procedure TFrmSTG.TrackersThreadEvent(qBitThread: TThread; EventType: TqBitThreadEventCode);
begin
  //  qtetInit, qtetLoaded, qtetError, qtetBeforeMerge, qtetAfterMerge, qtetIdle, qtetExit
  var R := TqBitTrackersThread( qBitThread );
  case EventType of
    qtetLoaded, qtetAfterMerging:
    begin

      var SortList := TObjectList<TqBitTrackerType>.Create(False);

      if Assigned(R.Trackers.trackers) then
      for var T in R.Trackers.trackers do
        SortList.Add(TqBitTrackerType(T));

      //Sorting
      SortList.Sort(TComparer<TqBitTrackerType>.Construct(
          function (const L, R: TqBitTrackerType): integer
          var
            LTValueL, LTValueR: TValue;
          begin
            Result := 0;
            for var Field in TxRtti.GetFields(L) do
            begin
              if TxRTTI.FieldAsTValue(L, Field, LTValueL, [mvPublic])
                and TxRTTI.FieldAsTValue(R, Field, LTValueR, [mvPublic]) then
              if Field.Name = Self.TrackersFrame.SortField then
              begin
                var LVal := LTValueL.AsVariant;
                var RVal := LTValueR.asVariant;
                if LVal > RVal then
                  if Self.TrackersFrame.SortReverse then Result := -1 else Result := 1;
                if RVal > LVal then
                  if Self.TrackersFrame.SortReverse then Result := 1 else Result := -1;
              end;
            end;
          end
      ));

      if TrakersTabSheet.Visible then
      begin
        // Display Grid
        TrackersFrame.RowUpdateStart;
        for var T in SortList do
          TrackersFrame.AddRow(TqBitTrackerType(T).hash.AsString, T);
        TrackersFrame.RowUpdateEnd;
      end;
      TrakersTabSheet.Caption := Format('Trackers (%d)', [SortList.Count]);
      FreeAndNil(SortList);

    end;
    qtetError: ;
    qtetIdle: R.KeyHash := ActiveKeyHash;
  end;
end;

initialization
  GlobalWebView2Loader                := TWVLoader.Create(nil);
  GlobalWebView2Loader.UserDataFolder := TPAth.GetDocumentsPath + '\CustomCache';
  GlobalWebView2Loader.StartWebView2;

end.
