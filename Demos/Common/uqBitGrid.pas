﻿(*****************************************************************************
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
unit uqBitGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, System.UITypes,
  System.Generics.Collections,
  uqBit.API.Types, uqBit.API, uqBit, Vcl.Menus, Vcl.ComCtrls,
  uKobicAppTrackMenus
  , RTTI
  , uJX4Object
  , uJX4List
  , uJX4dict
  ;
const

  MAXCOL = 100;
  MAXROW = 1000;
  ROWHEIGHT = 18;
  NoSelection: TGridRect = (Left: 0; Top: -1; Right: 0; Bottom: -1);

type

  TGridColPref = class(TJX4Object)
    Idx: TValue;
    Size: TValue;
    Position: TValue;
    Sortfield: TValue;
    SortReverse: TValue;
  end;

  TJsonGrid = class(TJX4Object)
    Grid: TJX4Dict<TGridColPref>;
  end;

  TValueDataFormater = function(v: TValue): string;

  TqBitGridData = class
    Hash: string;
    Selected: boolean;
    Name: string;
    RIdx: Integer;
    CIdx: Integer;
    Field: string;
    Format: TValueDataFormater;
    HintX: integer;
    HintY: integer;
    Obj: TObject;
  end;

  tqBitGridSelection = TObjectList<TObject>;

  TqBitGridUpdateEvent = procedure(Sender: TObject) of object;
  TqBitGridPopupEvent = procedure(Sender: TObject; X, Y, aCol, aRow: integer) of object;
  TqBitGridSelectedEvent = procedure(Sender: TObject) of object;

  TqBitFrame = class(TFrame)
    SG: TStringGrid;
    PMColHdr: TPopupMenu;
    ITMSort: TMenuItem;
    N1: TMenuItem;
    ITMHide: TMenuItem;
    ITMDebug: TMenuItem;
    N2: TMenuItem;
    PMIShowHide: TMenuItem;
    procedure SGDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure SGMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SGDblClick(Sender: TObject);
    procedure SGMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure SGMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure SGMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ITMSortClick(Sender: TObject);
    procedure ITMHideClick(Sender: TObject);
    procedure ITMDebugClick(Sender: TObject);
    procedure PMColHdrPopup(Sender: TObject);
    procedure SGKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FOnUpdateUIEvent: TqBitGridUpdateEvent;
    FOnPopupEvent: TqBitGridPopupEvent;
    FOnRowsSelectedEvent: TqBitGridSelectedEvent;

    FAddColIndex: Integer;
    FRowIndex: integer;
    FLastSelectedRowIndex: integer;
    FSelList: TStringList;
    procedure TrackMenuNotifyHandler(Sender: TMenu; Item: TMenuItem; var CanClose: Boolean);
    procedure ShowHideItemClicked(Sender: TObject);
  public
    { Public declarations }
    SortField: string;
    SortReverse: boolean;

    procedure LoadConfig(Prefs: TJsonGrid);
    procedure SaveConfig(Prefs: TJsonGrid);
    function  AddCol(Name, Field: string; Fmt: TValueDataFormater; Width: Integer; Visible: Boolean): TqBitGridData;
    procedure AddRow(K: string; V: TObject);
    procedure DoCreate;
    procedure DoDestroy;
    function GetColData(Index: Integer): TqBitGridData;
    function GetRowData(Index: Integer): TqBitGridData;
    procedure RowUpdateStart;
    procedure RowUpdateEnd;
    procedure SelectAll;
    function GetSelectedKeys: TStringList;
    function GetSelectedTorrents: TList<TqBitTorrentType>;
    function GetGridSel: tqBitGridSelection;

    property OnUpdateUIEvent: TqBitGridUpdateEvent read FOnUpdateUIEvent write FOnUpdateUIEvent;
    property OnPopupEvent: TqBitGridPopupEvent read FOnPopupEvent write FOnPopupEvent;
    property OnRowsSelectedEvent: TqBitGridSelectedEvent read FOnRowsSelectedEvent write FOnRowsSelectedEvent;
  end;

  //Callbacks
  function TValueFormatString(v: TValue): string;
  function TValueFormatDate(v: TValue): string;
  function TValueFormatBKM(v: TValue): string;
  function TValueFormatBKMPerSec(v: TValue): string;
  function TValueFormatPercent(v: TValue): string;
  function TValueFormatFloat(v: TValue): string;
  function TValueFormatMulti(v: TValue): string;
  function TValueFormatLimit(v: TValue): string;
  function TValueFormatDeltaSec(v: TValue): string;
  function TValueFormatDuration(v: TValue): string;

  var
    aaa: TqBitGridData;
implementation
uses
    Math
  , uJX4Rtti
  , uJX4Value
  , System.TypInfo
  ;

{$R *.dfm}

function TValueFormatString(v: TValue): string;
begin
  Result := v.ToString;
end;

function TValueFormatDate(v: TValue): string;
begin
  if v.ToString.IsEmpty then Exit('');
  Result := DateTimeToStr(v.Timestamp);
end;

function TValueFormatBKM(v: TValue): string;
begin
  if v.ToString.IsEmpty then Exit('0 B');
  Result := V.ToBKiBMiB;
end;

function TValueFormatBKMPerSec(v: TValue): string;
begin
  Result := TValueFormatBKM(v) + '/s';
end;

function TValueFormatPercent(v: TValue): string;
begin
  if v.ToString.IsEmpty then Exit('0');
  Result := V.ToPercent(2);
end;

function TValueFormatFloat(v: TValue): string;
begin
  if v.ToString.IsEmpty then Exit('0');
  Result := V.ToString(2);
end;

function TValueFormatMulti(v: TValue): string;
begin
  if v.ToString.IsEmpty then Exit('0 x');
  Result := V.ToString(2) + ' x';
end;

function TValueFormatLimit(v: TValue): string;
var
  x: Int64;
begin
  if v.ToString.IsEmpty then Exit('0');
  Result := '∞';
  if v.AsInt64 > 0 then Result := TValueFormatBKM(v);
end;

function TValueFormatDeltaSec(v: TValue): string;
begin
  if v.ToString.IsEmpty then Exit('0');
  Result := v.FromSecFromNow;
end;

function TValueFormatDuration(v: TValue): string;
begin
  if v.ToString.IsEmpty then Exit('0');
  Result := v.FromSecToDuration;
end;

function TitleCase(const S: string): string;
var
  IsUpper: boolean;
  i : Byte;
begin
  IsUpper := true;
  Result := '';
  for i := 1 to Length(S) do
  begin
    if IsUpper then
       Result := Result + UpperCase(S[i])
    else
       Result := Result + S[i];
    IsUpper := (S[i] = ' ')
  end;
end;

function VarFormatTrackerStatus(v: TValue): string;
var
  x: Int64;
begin
  if v.ToString.IsEmpty then Exit('Unknown');
  if v.TypeKind = tkvString then x := v.AsString.ToInt64 else x := v.AsInt64;
  case x of
    0: Result := 'Disabled';
    1: Result := 'Not Contacted';
    2: Result := 'Working';
    3: Result := 'Updating';
    4: Result := 'Error';
  else
    Result := 'Unknown';
  end;
end;

function TqBitFrame.GetSelectedKeys: TStringList;
begin
  var Sel := GetGridSel;
  Result := TStringList.Create;
  for var v in Sel do
    Result.Add(TqBitGridData(v).Hash);
  Sel.Free;
end;

function TqBitFrame.GetSelectedTorrents: TList<TqBitTorrentType>;
begin
  var Sel := GetGridSel;
  Result := TList<TqBitTorrentType>.Create;
  for var v in Sel do
    Result.Add(TqBitTorrentType(TqBitGridData(v).Obj));
  Sel.Free;
end;

procedure TqBitFrame.DoCreate;
begin
  SG.RowCount := MAXROW;
  SG.ColCount := MAXCOL;
  SG.DefaultColWidth := 84;
  for var i := 0 to SG.ColCount - 1 do
    for var j := 0 to SG.RowCount - 1 do
    begin
      if (i = 0) or (j = 0 ) then
      begin
        var Data :=  TqBitGridData.Create;
        SG.ColWidths[i] := -1;
        SG.RowHeights[j] := -1;
        SG.Objects[i, j] := Data;
      end;
    end;
  FSelList := TStringList.Create;
  SG.Selection:= NoSelection;
  FLastSelectedRowIndex := 1;
  FAddColIndex := 1;
  SortField := '';
  SortReverse := True;
  PMColHdr.TrackMenu := True;
  PMColHdr.OnTrackMenuNotify := TrackMenuNotifyHandler;
end;

procedure TqBitFrame.DoDestroy;
begin
  FSelList.Free;
  for var i := 0 to SG.ColCount - 1 do
      for var j := 0 to SG.RowCount - 1 do
        if (i = 0) or (j = 0) then TqBitGridData(SG.Objects[i, j]).Free;
end;

procedure TqBitFrame.ITMDebugClick(Sender: TObject);
begin
  for var i := 0 to SG.ColCount - 1 do
    if SG.ColWidths[i] = -2 then
       SG.ColWidths[i] := SG.DefaultColWidth;
end;

procedure TqBitFrame.ITMHideClick(Sender: TObject);
begin
  if SG.ColWidths[PMColHdr.Tag] > -1 then
    SG.ColWidths[PMColHdr.Tag] := -1
  else
    SG.ColWidths[PMColHdr.Tag] := SG.DefaultColWidth;
end;

procedure TqBitFrame.ITMSortClick(Sender: TObject);
begin
  if PMColHdr.Tag < 0 then Exit;
  var Field :=  GetColData(PMColHdr.Tag).Field;
  if SortField <> field then
  begin
    SortField := Field;
    SortReverse := True;
  end else
    SortReverse := not SortReverse;
  if Assigned(FOnUpdateUIEvent) then FOnUpdateUIEvent(Self);
end;

procedure TqBitFrame.ShowHideItemClicked(Sender: TObject);
begin
  var i := TMenuItem(Sender).Tag;
  if SG.ColWidths[i] > 0 then
     SG.ColWidths[i] := -1
  else
     SG.ColWidths[i] := SG.DefaultColWidth;
end;

procedure TqBitFrame.PMColHdrPopup(Sender: TObject);
begin
   for var i := PMIShowHide.Count -1 downto 0 do
    PMIShowHide.Items[i].Free;

  for var i:= 1 to SG.ColCount -1 do
    if (GetColData(i).Name <> '') and ( SG.ColWidths[i]<>-2 )then
    begin
      var NewItem := TMenuItem.Create(PMColHdr);
      NewItem.AutoCheck := True;
      NewItem.Caption := GetColData(i).Name;
      NewItem.Checked := SG.ColWidths[i] > 0;
      NewItem.Tag := i;
      NewItem.GroupIndex := 0;
      NewItem.OnClick := ShowHideItemClicked;
      PMIShowHide.Add(NewItem);
    end;
end;

function TqBitFrame.GetColData(Index: Integer): TqBitGridData;
begin
  Result := TqBitGridData(SG.Objects[Index, 0]);
end;

procedure TqBitFrame.LoadConfig(Prefs: TJsonGrid);
begin
  Prefs.Grid.Clear;
  for var i := 1 to SG.ColCount - 2  do
  begin
    var Obj := TqBitGridData(SG.Objects[i, 0]);
    if not Obj.Name.Trim.IsEmpty then
    begin
      var Layout := TGridColPref.Create;
      Layout.Size := SG.ColWidths[i];
      Layout.Position := i;
      Prefs.Grid.Add(Obj.Name, Layout);
      if SortField = Obj.Field then
      begin
        Layout.SortField := SortField;
        Layout.SortReverse := SortReverse;
      end;
    end;
  end;
end;

procedure TqBitFrame.SaveConfig(Prefs: TJsonGrid);
begin
  for var C in Prefs.Grid do
  begin
    for var i := 1 to SG.ColCount - 2 do
    begin
      var Obj := TqBitGridData(SG.Objects[i, 0]);
      if (Obj.Name = C.Key) then
      begin
        if C.Value.SortField.ToString <> '' then
        begin
          SortField :=   C.Value.Sortfield.AsString;
          SortReverse := C.Value.SortReverse.ASBoolean;
        end;
        SG.ColWidths[i] := C.Value.Size.AsInteger;
        var A := SG.Objects[i, 0];
        var B := SG.Objects[C.Value.Position.AsInteger, 0];
        SG.Objects[i, 0] := B;
        SG.Objects[C.Value.Position.AsInteger, 0] := A;
      end;
    end;
  end;
end;

function TqBitFrame.GetGridSel: tqBitGridSelection;
begin
  Result := TObjectList<TObject>.Create(False);
  for var i := 0 to SG.RowCount - 1 do
    if TqBitGridData(GetRowData(i)).Selected then
      Result.Add(TqBitGridData(GetRowData(i)));
end;

function TqBitFrame.GetRowData(Index: Integer): TqBitGridData;
begin
  Result := TqBitGridData(SG.Objects[0, Index]);
end;

procedure TqBitFrame.RowUpdateStart;
begin
  SG.BeginUpdate;
  FRowIndex := 1;
  for var Row := 1 to SG.RowCount -1 do
    SG.RowHeights[Row] := -1;
  FSelList.Clear;
  for var i := 0 to SG.RowCount - 1 do
  begin
    var RD := GetRowData(i);
    if RD.Selected then
      FSelList.add(RD.Hash);
    RD.Selected := False;
  end;
end;

procedure TqBitFrame.AddRow(K: string; V: TObject);
var
  LTValue: TValue;
begin
  Self.GetRowData(FRowIndex).Hash := K;
  for var Col := 0 to SG.ColCount -1 do
  begin
    var ColData := Self.GetColData(Col);
    for var Field in TxRtti.GetFields(V) do
      if ColData.Field = Field.Name then
      begin
        if not TxRTTI.FieldAsTValue(V, Field, LTValue, [mvPublic]) then Continue;
        SG.Cells[Col, FRowIndex] := TValueFormatString(LTValue);
        SG.RowHeights[FRowIndex] := ROWHEIGHT;
        ColData.RIdx := FRowIndex;
        if ColData.Field = SortField then
        begin
          if not SortReverse then
            SG.Cells[Col, 0] := '🡻 ' + ColData.Name
          else
            SG.Cells[Col, 0] := '🡹 ' + ColData.Name ;
        end else
          SG.Cells[Col, 0] := ColData.Name ;
        break;
      end;
  end;
  Self.GetRowData(FRowIndex).Selected := FSelList.IndexOf(K) <> -1;
  Self.GetRowData(FRowIndex).Obj := V;
  Inc(FRowIndex);
end;

procedure TqBitFrame.RowUpdateEnd;
begin
  if FSelList.Count > 0 then
  begin
    var HasRowSelected := False;
    for var i := 0 to SG.RowCount - 1 do
      HasRowSelected := HasRowSelected or GetRowData(i).Selected;
    if (not HasRowSelected) and Assigned(FOnRowsSelectedEvent)then
       FOnRowsSelectedEvent(Self);
  end;
  FSelList.Clear;
  SG.EndUpdate;
end;

function TqBitFrame.AddCol(Name, Field: string; Fmt: TValueDataFormater; Width: Integer; Visible: Boolean): TqBitGridData;
begin
  Result:= TqBitGridData(SG.Objects[FAddColIndex, 0]);
  SG.ColWidths[FAddColIndex] := Width;
  SG.RowHeights[0] := ROWHEIGHT;
  SG.Cells[FAddColIndex, 0] := Name;
  Result.Name := Name;
  Result.Field := Field;
  Result.Format := Fmt;
  Result.Selected := False;
  Result.CIdx := FAddColIndex;
  Inc(FAddColIndex);
end;

procedure TqBitFrame.SelectAll;
begin
  for var i:= 1 to SG.RowCount  - 1 do
    if assigned(GetRowData(i).Obj)  and (SG.RowHeights[i]>-1) then
      GetRowData(i).Selected := True;
  if Assigned(FOnUpdateUIEvent) then FOnUpdateUIEvent(Self);
end;

procedure TqBitFrame.SGDblClick(Sender: TObject);
var
  P : TPoint;
  ACol, ARow : integer;
begin
  GetCursorPos(P) ;
  SG.MouseToCell(SG.ScreenToClient(P).X, SG.ScreenToClient(P).Y, ACol, ARow);
  if (ACol = -1 ) or (ARow = -1) then Exit;
  var Field := Self.GetColData(ACol);
  if Field.Field = SortField then
    SortReverse := Not SortReverse
  else
    SortReverse := True;
  SortField := Field.Field;
  if Assigned(FOnUpdateUIEvent) then FOnUpdateUIEvent(Self);
end;

procedure TqBitFrame.SGDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  Value: TValue;
  Text: string;
begin

  var FontColor := SG.Canvas.Font.Color;
  var BrushColor := SG.Canvas.Brush.Color;

  if Arow mod 2 = 1 then
    SG.Canvas.Brush.Color := clWhite
  else
    SG.Canvas.Brush.Color := clCream;

  if (ARow < sG.FixedRows) or (ACol < SG.FixedCols) then
      SG.Canvas.Brush.Color := clMenu;

  var GD := TqBitGridData(SG.Objects[0, ARow]);
  if GD.Selected  then
  begin
    SG.Canvas.Brush.Color := clNavy;
    SG.Canvas.Font.Color := clWhite;
  end else begin
    SG.Canvas.Font.Color:=clBlack;
  end;

  SG.Canvas.FillRect(Rect);

  var BackBrushColor := SG.Canvas.Brush.Color;

  if ARow = 0 then
  begin
    SG.Canvas.TextRect (Rect, Rect.Left+4, Rect.Top+2, SG.Cells[ACol,ARow])
  end else begin

    Value :=  SG.Cells[ACol,ARow];
    try
      if Assigned(GetColData(ACol).Format)  then
        Text :=  GetColData(ACol).Format( Value );
    except
      Text := Value.ToString;
    end;
    if @GetColData(ACol).Format = @TValueFormatPercent then
    begin
     if Value.ToString.IsEmpty then Value := '0.00';

     SG.Canvas.Brush.Color := BackBrushColor;
     SG.Canvas.FillRect( TRect.Create(Rect.Left+1 , Rect.Top+1, Rect.Right-1 , Rect.Bottom -1) );

     var L := Round((Rect.Right - Rect.Left) * Value.AsString.ToDouble);
     SG.Canvas.Brush.Color := clGradientActiveCaption;
     SG.Canvas.FillRect( TRect.Create(Rect.Left+2 , Rect.Top+2, Max(Rect.Left + 2, Rect.Left + L -2) , Rect.Bottom-2 ) );

     SG.Canvas.Brush.Style := bsClear;
     L := (Rect.Width - SG.Canvas.TextWidth(Text)) div 2;
     SG.Canvas.TextOut(Rect.Left + L, Rect.Top+2, Text);

    end else
      SG.Canvas.TextRect (Rect, Rect.Left+4, Rect.Top+2, Text);

  end;

  SG.Canvas.Brush.Color := BrushColor;
  SG.Canvas.Font.Color := FontColor;
end;

procedure TqBitFrame.SGKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 65) and ( ssCtrl in Shift) then
    for var i:= 1 to SG.RowCount  - 1 do
      if assigned(GetRowData(i)) then
        GetRowData(i).Selected := True;
  if Assigned(FOnUpdateUIEvent) then FOnUpdateUIEvent(Self)
end;

procedure TqBitFrame.SGMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
  ACol, ARow : integer;
begin

  SG.MouseToCell(X, Y, ACol, ARow);
  if Button = mbRight then
  begin
    if ARow = 0 then
    begin
      P.X := X; P.Y :=Y;
      PMColHdr.Tag := ACol;
      PMColHdr.Popup(SG.ClientToScreen(P).X - 8, SG.ClientToScreen(P).Y - 2);
    end else begin
      P.X := X; P.Y :=Y;
      if Assigned(FOnPopupEvent) then FOnPopupEvent(Self, SG.ClientToScreen(P).X - 8, SG.ClientToScreen(P).Y - 2, ACol, ARow);
    end;
  end;

  if Button <> mbLeft then Exit;

  if (ARow = 0) and (GetKeyState(VK_SHIFT) < 0) then
  begin

  end;
  if ARow < SG.FixedRows then Exit;

  if GetKeyState(VK_CONTROL) < 0 then
  begin
    TqBitGridData(GetRowData(ARow)).Selected := not TqBitGridData(GetRowData(ARow)).Selected;
    FLastSelectedRowIndex := ARow;
  end else
  if GetKeyState(VK_SHIFT) < 0 then
  begin
    for var Row := Min(FLastSelectedRowIndex, ARow) to Max(FLastSelectedRowIndex, ARow) do
       TqBitGridData(GetRowData(Row)).Selected := True;
  end else begin
    for var i := 0 to SG.RowCount - 1 do GetRowData(i).Selected := False;
    TqBitGridData(GetRowData(ARow)).Selected := True;
    FLastSelectedRowIndex := ARow;
  end;
  if Assigned(FOnRowsSelectedEvent) then FOnRowsSelectedEvent(Self);

  SG.Selection:= NoSelection;
  SG.Invalidate;
end;

procedure TqBitFrame.SGMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  P : TPoint;
  ACol, ARow : integer;
begin
  GetCursorPos(P);
  SG.MouseToCell(SG.ScreenToClient(P).X, SG.ScreenToClient(P).Y, ACol, ARow);
  if ( (GetColData(0).HintX <> P.X) or (GetColData(0).HintY <> P.Y) ) then
  begin
    if (ACol<1) or (ARow<1) then Exit;
    SG.Hint := SG.Cells[1, ARow] + #$D#$A + SG.Cells[ACol, 0] + ' : ' +SG.Cells[ACol, ARow];
    Application.ActivateHint(P);
    Application.HintPause := 2000;
    Application.HintHidePause := 10000;
    GetColData(0).HintX := P.X;
    GetColData(0).HintY := P.Y;
    SG.ShowHint := True;
  end;
end;

procedure TqBitFrame.SGMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  var MaxRow := 1;
  while( SG.RowHeights[MaxRow] <> -1 ) do Inc(MaxRow);
  if SG.VisibleRowCount < MaxRow then SG.TopRow := SG.TopRow + 4;
  Handled := True;
end;

procedure TqBitFrame.SGMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
   SG.TopRow := Max(SG.TopRow - 4, 1);
   Handled := True;
end;

procedure TqBitFrame.TrackMenuNotifyHandler(Sender: TMenu; Item: TMenuItem;
  var CanClose: Boolean);
begin
  CanClose := Item.Tag = 0;
end;

end.
