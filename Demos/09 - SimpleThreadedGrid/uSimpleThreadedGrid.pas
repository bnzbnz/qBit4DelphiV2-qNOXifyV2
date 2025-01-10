(*****************************************************************************
The MIT License (MIT)

Copyright (c) 2020-2025 Laurent Meyer qBit@lmeyer.fr

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
******************************************************************************)
unit uSimpleThreadedGrid;
{$HINTS OFF}

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Menus
  , uqBit.API.Types
  , uqBit.API
  , uqBit
  , uqBitGrid
  , uqBitThreads
  ;

type
  TFrmSTG = class(TForm)
    Panel1: TPanel;
    MainFrame: TqBitFrame;
    MainPopup: TPopupMenu;
    Pause1: TMenuItem;
    Pause2: TMenuItem;
    N1: TMenuItem;
    ShowSelection1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PauseClick(Sender: TObject);
    procedure ResumeClick(Sender: TObject);
    procedure ShowSelection1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    qB: TqBit;
    MainThread: TqBitMainThread;
    procedure MainThreadEvent(qBitThread: TThread; EventType: TqBitThreadEventCode);
    procedure MainFramUpdateEvent(Sender: TObject);
    procedure MainFramePopupEvent(Sender: TObject; X, Y, aCol, aRow: integer);
  end;

var
  FrmSTG: TFrmSTG;

{$R *.dfm}

implementation
uses
    ShellAPI
  , uqBitSelectServerDlg
  , RTTI
  , uJX4Rtti
  , System.TypInfo
  , System.Generics.Collections
  , System.Generics.Defaults
  ;

procedure TFrmSTG.FormShow(Sender: TObject);
begin
  if qBitSelectServerDlg.ShowModal = mrOk then
  begin
    var Server := qBitSelectServerDlg.GetServer;
    qB := TqBit.Connect(Server.FHP, Server.FUN, Server.FPW);

    MainFrame.DoCreate;
    MainFrame.OnUpdateUIEvent := MainFramUpdateEvent;
    MainFrame.OnPopupEvent := self.MainFramePopupEvent;

    MainFrame.AddCol('Name', 'name', TValueFormatString, 320, True);
    MainFrame.AddCol('Size', 'size', TValueFormatBKM, 84, True);
    MainFrame.AddCol('Total Size', 'total_size', TValueFormatBKM, -1, True);
    MainFrame.AddCol('Progress', 'progress', TValueFormatPercent, 84, True);
    MainFrame.AddCol('Status', 'state', TValueFormatString, 84, True);
    MainFrame.AddCol('Seeds', 'num_seeds', TValueFormatString, 84, True);
    MainFrame.AddCol('Peers', 'num_leechs', TValueFormatString, 84, True);
    MainFrame.AddCol('Ratio', 'ratio', TValueFormatFloat, 36, True);
    MainFrame.AddCol('Down Speed', 'dlspeed', TValueFormatBKMPerSec, 84, True);
    MainFrame.AddCol('Upload Speed', 'upspeed', TValueFormatBKMPerSec, 84, True);
    MainFrame.AddCol('ETA', 'eta', TValueFormatDeltaSec, 128, True);
    MainFrame.AddCol('Category', 'category', TValueFormatString, 84, True);
    MainFrame.AddCol('Tags', 'tags', TValueFormatString, 84, True);
    MainFrame.AddCol('Added On', 'added_on', TValueFormatDate, 128, True);
    MainFrame.AddCol('Completed On', 'completion_on', TValueFormatDate, -1, True);
    MainFrame.AddCol('Tracker', 'tracker', TValueFormatString, -1, True);
    MainFrame.AddCol('Down Limit', 'dl_limit', TValueFormatLimit, -1, True);
    MainFrame.AddCol('Up Limit', 'dl_limit', TValueFormatLimit, -1, True);
    MainFrame.AddCol('Downloaded', 'downloaded', TValueFormatBKM, -1, True);
    MainFrame.AddCol('Uploaded  ', 'uploaded', TValueFormatBKM, -1, True);
    MainFrame.AddCol('Session Downloaded', 'downloaded_session', TValueFormatBKM, -1, True);
    MainFrame.AddCol('Session Uploaded  ', 'uploaded_session', TValueFormatBKM, -1, True);
    MainFrame.AddCol('Availability', 'availability', TValueFormatMulti, -1, True);

    MainFrame.SortField := 'name';
    MainFrame.SortReverse := False;

    var rttictx := TRttiContext.Create();
    var rttitype := rttictx.GetType(TqBitTorrentType);
    for var field in rttitype.GetFields do
    begin
      var Title := 'Raw: ' + field.Name;
      if pos('_', field.Name) = 1 then continue;
      MainFrame.AddCol(Title, field.Name, TValueFormatString, -2, False);
    end;
    rttictx.Free;

    MainThread := TqBitMainThread.Create(qB.Clone, MainThreadEvent);
  end else
    PostMessage(Handle, WM_CLOSE,0 ,0);
end;

procedure TFrmSTG.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MainThread.Free;
  MainFrame.DoDestroy;
  qB.Free;
end;

procedure TFrmSTG.MainFramePopupEvent(Sender: TObject; X, Y, aCol, aRow: integer);
begin
  MainThread.Pause := True;  //Thread Safe;
  var Sel := MainFrame.GetGridSel;
  try
    if Sel.Count = 0 then Exit;
    MainPopup.Popup(X,Y);
  finally
    Sel.Free;
    MainThread.Pause := False;  //Thread Safe;
  end;
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

procedure TFrmSTG.ShowSelection1Click(Sender: TObject);
begin
  var Sel := MainFrame.GetGridSel;
  try
    if Sel.Count = 0 then Exit;
    for var GridData in Sel do
    begin
      var Data := TqBitGridData(GridData);
      var Torrent := TqBitTorrentType(Data.Obj);
      ShowMessage( Torrent.hash.AsString + ' : ' + Torrent.name.AsString );
    end;
  finally
    Sel.Free;
  end;
end;

procedure TFrmSTG.MainFramUpdateEvent(Sender: TObject);
begin
  MainThread.Refresh := True; //Thread Safe;
end;

procedure TFrmSTG.MainThreadEvent(qBitThread: TThread; EventType: TqBitThreadEventCode);
begin
  //  qtetInit, qtetLoaded, qtetError, qtetBeforeMerge, qtetAfterMerge, qtetIdle, qtetExit
  var M := TqBitMainThread( qBitThread );
  case EventType of
    qtetLoaded, qtetAfterMerging:
    begin
      var SortList := TObjectList<TqBitTorrentType>.Create(False);

      if Assigned(M.Main.torrents) then
      for var T in M.Main.torrents do
        SortList.Add(TqBitTorrentType(T.Value));

      //Sorting
      var rttictx := TRttiContext.Create();
      var rttitype := rttictx.GetType(TqBitTorrentType);
      SortList.Sort(TComparer<TqBitTorrentType>.Construct(
          function (const L, R: TqBitTorrentType): integer
          var
            LTValueL: TValue;
            LTValueR: TValue;
          begin
            Result := 0;
            for var Field in RttiType.GetFields do
            begin
              if Field.Name = Self.MainFrame.SortField then
              begin
                if TxRTTI.FieldAsTValue(L, Field, LTValueL, [mvPublic])
                  and TxRTTI.FieldAsTValue(R, Field, LTValueR, [mvPublic]) then
                  begin
                    var LVal := LTValueL.AsVariant;
                    var RVal := LTValueR.asVariant;
                    if LVal > RVal then
                      if Self.MainFrame.SortReverse then Result := -1 else Result := 1;
                    if RVal > LVal then
                      if Self.MainFrame.SortReverse then Result := 1 else Result := -1;
                    Result := 0;
                  end;
              end;
            end;
          end
      ));
      rttictx.Free;

      // Displaying Grid

      MainFrame.RowUpdateStart;
      for var T in SortList do
        MainFrame.AddRow(TqBitTorrentType(T).hash.AsString, T);
      MainFrame.RowUpdateEnd;
      FreeAndNil(SortList);


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

end.
