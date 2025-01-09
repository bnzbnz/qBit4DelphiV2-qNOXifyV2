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
unit uqBitThreads;

interface
uses  classes,
      uqBit.API.Types,
      uqBit;
const
  QBIT_DEFAULT_THREAD_WAIT_MS = 1500;
type

  TqBitThreadEventCode = (qtetInit, qtetExit, qtetLoaded, qtetBeforeMerging, qtetAfterMerging, qtetIdle, qtetNotFound, qtetError);
  TqBitThreadEvent = procedure(qBitThread: TThread; EventType: TqBitThreadEventCode) of object;

  TqBitMainThread = class(TThread)
  private
    FqB: TqBit;
    FOnEvent: TqBitThreadEvent;
    FMain: TqBitMainDataType;
    FMainUpdate: TqBitMainDataType;
    FRefresh: Boolean;
    FPause: Boolean;
    FMustExit: Boolean;
    FIntervalMS: Cardinal;
  public
    constructor Create( qBClone: TqBit; OnEvent: TqBitThreadEvent); overload;
    procedure Execute; override;
    destructor Destroy; override;

    property qB: TqBit read FqB;
    property Main: TqBitMainDataType read FMain;
    property MainUpdate: TqBitMainDataType read FMainUpdate;
    property IntervalMS: Cardinal read FIntervalMS write FIntervalMS;
    property Refresh: Boolean read FRefresh write FRefresh;
    property Pause: Boolean read FPause write FPause;
    property MustExit: Boolean read FMustExit write FMustExit;
  end;

  TqBitPeersThread = class(TThread)
  private
    FqB : TqBit;
    FOnEvent: TqBitThreadEvent;
    FPeers: TqBitTorrentPeersDataType;
    FPeerUpdate: TqBitTorrentPeersDataType;
    FIntervalMS: Cardinal;
    FKeyHash: string;
    FPause: Boolean;
    FRefresh: Boolean;
    FMustExit: Boolean;
  public
    constructor Create( qBClone: TqBit; OnEvent: TqBitThreadEvent); overload;
    procedure Execute; override;
    destructor Destroy; override;

    property Peers: TqBitTorrentPeersDataType read FPeers;
    property PeerUpdate: TqBitTorrentPeersDataType read FPeerUpdate;
    property IntervalMS: Cardinal read FIntervalMS write FIntervalMS;
    property KeyHash: string read FKeyHash write FKeyHash;
    property Refresh: Boolean read FRefresh write FRefresh;
    property MustExit: Boolean read FMustExit write FMustExit;
    property Pause: Boolean read FPause write FPause;
  end;

  TqBitTrackersThread = class(TThread)
  private
    FqB : TqBit;
    FOnEvent: TqBitThreadEvent;
    FTrackers: TqBitTrackersType;
    FIntervalMS: Cardinal;
    FKeyHash: string;
    FPause: Boolean;
    FRefresh: Boolean;
    FMustExit: Boolean;
  public
    constructor Create( qBClone: TqBit; OnEvent: TqBitThreadEvent); overload;
    procedure Execute; override;
    destructor Destroy; override;

    property Trackers: TqBitTrackersType read FTrackers;
    property IntervalMS: Cardinal read FIntervalMS write FIntervalMS;
    property KeyHash: string read FKeyHash write FKeyHash;
    property MustExit: Boolean read FMustExit write FMustExit;
    property Pause: Boolean read FPause write FPause;
    property Refresh: Boolean read FRefresh write FRefresh;
  end;


implementation
uses SysUtils;

{ TqBitMainThread }

constructor TqBitMainThread.Create(qBClone: TqBit; OnEvent: TqBitThreadEvent);
begin
  FqB := qBClone;
  FOnEvent := OnEvent;
  FMain := Nil;
  FMainUpdate := Nil;
  FMustExit := False;
  FRefresh := False;
  FPause := False;
  FIntervalMS := QBIT_DEFAULT_THREAD_WAIT_MS;
  inherited Create(False);
end;

destructor TqBitMainThread.Destroy;
begin
  Terminate;
  WaitFor;
  FqB.Free;
  inherited;
end;

procedure TqBitMainThread.Execute;
begin
  // Handle: qtetInit, qtetLoaded, qtetError, qtetBeforeMerge, qtetAfterMerge, qtetIdle, qtetExit

  try
    Synchronize( procedure begin FOnEvent(Self, qtetInit); end );

    FMain := FqB.GetMainData(0);
    if Main = Nil then
    begin
      Synchronize( procedure begin FOnEvent(Self, qtetError); end );
      if FMustExit then Exit; // Check disconnect with qB.HTTPStatus = -1
    end else begin
      FIntervalMS :=  Main.server_state.refresh_interval.AsInteger;
      FOnEvent(Self, qtetLoaded);
    end;

    while not Terminated do
    begin

      if not FPause then
      begin

        var StartTime := GetTickCount;
        try
          FRefresh := False;
          FMainUpdate := FqB.GetMainData(Main.rid.AsInteger);
          if FMainUpdate = Nil then
          begin
            Synchronize( procedure begin FOnEvent(Self, qtetError); end );
            if FMustExit then Exit;
          end else begin
            Synchronize( procedure begin FOnEvent(Self, qtetBeforeMerging); end );
            Main.Merge(FMainUpdate);
            Synchronize( procedure begin FOnEvent(Self, qtetAfterMerging); end );
          end;
        finally
          FreeAndNil(FMainUpdate);
        end;

        while
          (GetTickCount - StartTime < IntervalMS)
          and (not Terminated) and (not FRefresh) do
        begin
          Sleep(100);
          Synchronize( procedure begin FOnEvent(Self, qtetIdle); end );
        end;

      end else
       Sleep(100);

    end;

  finally
    Synchronize( procedure begin FOnEvent(Self, qtetExit); end );
    Main.Free;
    Terminate;
  end;

end;

{ TqBitPeersThread }

constructor TqBitPeersThread.Create( qBClone: TqBit; OnEvent: TqBitThreadEvent);
begin
  FqB := qBClone;
  FOnEvent := OnEvent;
  FIntervalMS := QBIT_DEFAULT_THREAD_WAIT_MS;
  FKeyHash := '';
  FPeers := Nil;
  FPeerUpdate := Nil;
  FMustExit := False;;
  FPause := False;
  FRefresh := False;
  inherited Create(False);
end;

destructor TqBitPeersThread.Destroy;
begin
  Terminate;
  WaitFor;
  FqB.Free;
  inherited;
end;

procedure TqBitPeersThread.Execute;
begin
  // Handle: qtetInit, qtetNotFound, qtetError, qtetBeforeMerge, qtetAfterMerge, qtetIdle, qtetExit

  var CurKeyHash := '';

  try
  Synchronize( procedure begin FOnEvent(Self, qtetInit); end );
  while not Terminated do
  begin
    if not FPause then
    begin
      var StartTime := GetTickCount;
      if KeyHash <> '' then
      begin
        if KeyHash <> CurKeyHash then
        begin

          CurKeyHash := KeyHash;
          FreeAndNil(FPeers);
          FPeers := FqB.GetTorrentPeersData(KeyHash, 0);
          if FPeers = Nil then
          begin
            CurKeyHash := '';
            if FqB.HTTPStatus = 404 then
              Synchronize( procedure begin FOnEvent(Self, qtetNotFound); end )
            else
              Synchronize( procedure begin FOnEvent(Self, qtetError); end );
            if FMustExit then Exit;
          end else
            FOnEvent(Self, qtetLoaded);

        end else begin

          FPeerUpdate := FqB.GetTorrentPeersData(KeyHash, Peers.rid.AsInteger);
          if FPeerUpdate = Nil then
          begin
            CurKeyHash := '';
            if FqB.HTTPStatus = 404 then
              Synchronize( procedure begin FOnEvent(Self, qtetNotFound); end )
            else
              Synchronize( procedure begin FOnEvent(Self, qtetError); end );
            if FqB.HTTPStatus = -1 then Exit;
          end else begin
            Synchronize( procedure begin FOnEvent(Self, qtetBeforeMerging); end );
            Peers.Merge(FPeerUpdate);
            Synchronize( procedure begin FOnEvent(Self, qtetAfterMerging); end );
            FreeAndNil(FPeerUpdate);
          end;

        end;
      end else begin
        CurKeyHash := '';
        FreeAndNil(FPeers);
        Synchronize( procedure begin FOnEvent(Self, qtetIdle); end );
      end;

      var Refresh := Self.FRefresh;
      Self.FRefresh := False;
      while
        ((GetTickCount - StartTime) < IntervalMS)
        and (not Terminated) and (not Refresh)
      do
      begin
        Synchronize( procedure begin FOnEvent(Self, qtetIdle); end );
        Refresh := (KeyHash <> CurKeyHash) or FRefresh;
        if not Refresh then Sleep(100);
      end;

    end else
      Sleep(100);
  end;
  finally
    Synchronize( procedure begin FOnEvent(Self, qtetExit); end );
    FreeAndNil(FPeers);
    Terminate;
  end;
end;

{ TqBitTrackersThread }

constructor TqBitTrackersThread.Create(qBClone: TqBit;
  OnEvent: TqBitThreadEvent);
begin
  FqB := qBClone;
  FOnEvent := OnEvent;
  FIntervalMS := QBIT_DEFAULT_THREAD_WAIT_MS;
  FKeyHash := '';
  FTrackers := Nil;
  FMustExit := False;
  FPause := False;
  FRefresh := False;
  inherited Create(False);
end;

destructor TqBitTrackersThread.Destroy;
begin
  Terminate;
  WaitFor;
  FqB.Free;
  inherited;
end;

procedure TqBitTrackersThread.Execute;
begin
  // Handle: qtetInit, qtetLoaded, qtetNotFound, qtetError, qtetIdle, qtetExit

  try
    Synchronize( procedure begin FOnEvent(Self, qtetInit); end );
    while not Terminated do
    begin

      if not FPause then
      begin

        var StartTime := GetTickCount;
        if FKeyHash <> '' then
        begin
          FreeAndNil(FTrackers);
          FTrackers := FqB.GetTorrentTrackers(KeyHash);
          if FTrackers = Nil then
          begin
            if FqB.HTTPStatus = 404 then
              Synchronize( procedure begin FOnEvent(Self, qtetNotFound); end )
            else
              Synchronize( procedure begin FOnEvent(Self, qtetError); end );
            if FMustExit then Exit;
          end else
            FOnEvent(Self, qtetLoaded);
        end;

        while
          ((GetTickCount - StartTime) < IntervalMS) and (not Terminated) and (not Refresh)
        do
        begin
          Synchronize( procedure begin FOnEvent(Self, qtetIdle); end );
          sleep(100);
        end;
        FRefresh := False;
      end else
        Sleep(100);
    end;
  finally
    Synchronize( procedure begin FOnEvent(Self, qtetExit); end );
    FreeAndNil(FTrackers);
    Terminate;
  end

end;

end.
