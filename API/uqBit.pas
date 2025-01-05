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
unit uqBit;

interface

uses
    Classes
  , SysUtils
  , uqBit.API
  , uqBit.API.Types
  ;

  type

  TqBit = class(TqBitAPI)
  private
  protected
  public

    class function Connect(HostPath, Username, Password : string): TqBit;
    class function TorrentsToHashesList(Torrents: TqBitMainDataType): TStringList; overload;
    class function TorrentsToHashesList(Torrents: TqBitTorrentsListType): TStringList; overload;

    class function qBitMajorVersion: Integer; virtual;
    class function qBitMinorVersion: Integer; virtual;
    class function qBitVersion: string; virtual;
    class function qBitWebAPIVersion: string; virtual;
    class function qBitCheckWebAPICompatibility(RemoteWebAPIVersion: string): Boolean; overload; virtual;
    function       qBitCheckWebAPICompatibility: Boolean; overload; virtual;

    // API Helpers

    function DeleteTorrents(Hashes: TStringList; DeleteFiles: boolean = False): boolean; overload; virtual;
    function DeleteTorrents(Torrents: TqBitMainDataType; DeleteFiles: boolean = False): boolean; overload; virtual;
    function DeleteTorrents(Torrents: TqBitTorrentsListType; DeleteFiles: boolean = False): boolean; overload; virtual;

    function RecheckTorrents(Hashes: TStringList): boolean; overload; virtual;
    function RecheckTorrents(Torrents: TqBitMainDataType): boolean; overload; virtual;
    function RecheckTorrents(Torrents: TqBitTorrentsListType): boolean; overload; virtual;

    function ReannounceTorrents(Hashes: TStringList): boolean; overload;
    function ReannounceTorrents(Torrents: TqBitMainDataType): boolean; overload; virtual;
    function ReannounceTorrents(Torrents: TqBitTorrentsListType): boolean; overload; virtual;

    function AddTrackersToTorrent(Hash: string; Urls: TStringList): boolean; overload; virtual;
    function RemoveTrackers(Hash: string;  Urls: TStringList): boolean; overload; virtual;

    function AddPeers(Hashes: string; Peers: TStringList): boolean; overload; virtual;
    function AddPeers(Hashes, Peers: TStringList): boolean; overload; virtual;
    function AddPeers(Torrents: TqBitMainDataType; Peers: TStringList): boolean; overload; virtual;
    function AddPeers(Torrents: TqBitTorrentsListType; Peers: TStringList): boolean; overload; virtual;

    function BanPeers(Peers: TStringList): boolean; overload; virtual;
    function GetBanPeersList: TStringList; overload; virtual;
    function SetBanPeersList(PeersList: TStringList): Boolean; overload; virtual;
    function SetBanPeersList(PeersStr: string): Boolean; overload; virtual;
    function UnbanPeers(Peers: TStringList): boolean; overload; virtual;
    function UnbanPeers(Peers: string): boolean; overload; virtual;
    function UnbanAllPeers: boolean; overload; virtual;

    function IncreaseTorrentPriority(Hashes: TStringList): boolean; overload; virtual;
    function IncreaseTorrentPriority(Torrents: TqBitMainDataType): boolean; overload; virtual;
    function IncreaseTorrentPriority(Torrents: TqBitTorrentsListType): boolean; overload; virtual;

    function DecreaseTorrentPriority(Hashes: TStringList): boolean; overload; virtual;
    function DecreaseTorrentPriority(Torrents: TqBitMainDataType): boolean; overload; virtual;
    function DecreaseTorrentPriority(Torrents: TqBitTorrentsListType): boolean; overload; virtual;

    function MaximalTorrentPriority(Hashes: TStringList): boolean; overload; virtual;
    function MaximalTorrentPriority(Torrents: TqBitMainDataType): boolean; overload; virtual;
    function MaximalTorrentPriority(Torrents: TqBitTorrentsListType): boolean; overload; virtual;

    function MinimalTorrentPriority(Hashes: TStringList): boolean; overload; virtual;
    function MinimalTorrentPriority(Torrents: TqBitMainDataType): boolean; overload; virtual;
    function MinimalTorrentPriority(Torrents: TqBitTorrentsListType): boolean; overload; virtual;

    function SetFilePriority(Hash: string; Ids: TStringList; Priority: integer): boolean; overload; virtual;

    function GetTorrentDownloadLimit(Hashes: TStringList): TqBitTorrentSpeedsLimitType; overload; virtual;
    function GetTorrentDownloadLimit(Torrents: TqBitMainDataType): TqBitTorrentSpeedsLimitType; overload; virtual;
    function GetTorrentDownloadLimit(Torrents: TqBitTorrentsListType): TqBitTorrentSpeedsLimitType; overload; virtual;

    function SetTorrentDownloadLimit(Hashes: TStringList; Limit: integer): boolean; overload; virtual;
    function SetTorrentDownloadLimit(Torrents: TqBitMainDataType; Limit: integer): boolean; overload; virtual;
    function SetTorrentDownloadLimit(Torrents: TqBitTorrentsListType; Limit: integer): boolean; overload; virtual;

    function SetTorrentShareLimit(Hashes: TStringList; RatioLimit: double; SeedingTimeLimit: integer): boolean; overload; virtual;
    function SetTorrentShareLimit(Torrents: TqBitMainDataType; RatioLimit: double; SeedingTimeLimit: integer): boolean; overload; virtual;
    function SetTorrentShareLimit(Torrents: TqBitTorrentsListType; RatioLimit: double; SeedingTimeLimit: integer): boolean; overload; virtual;

    function GetTorrentUploadLimit(Hashes: TStringList): TqBitTorrentSpeedsLimitType; overload; virtual;
    function GetTorrentUploadLimit(Torrents: TqBitMainDataType): TqBitTorrentSpeedsLimitType; overload; virtual;
    function GetTorrentUploadLimit(Torrents: TqBitTorrentsListType): TqBitTorrentSpeedsLimitType; overload; virtual;

    function SetTorrentUploadLimit(Hashes: TStringList; Limit: integer): boolean; overload; virtual;
    function SetTorrentUploadLimit(Torrents: TqBitMainDataType; Limit: integer): boolean; overload; virtual;
    function SetTorrentUploadLimit(Torrents: TqBitTorrentsListType; Limit: integer): boolean; overload; virtual;

    function SetTorrentLocation(Hashes: TStringList; Location: string): boolean; overload; virtual;
    function SetTorrentLocation(Torrents: TqBitMainDataType; Location: string): boolean; overload; virtual;
    function SetTorrentLocation(Torrents: TqBitTorrentsListType; Location: string): boolean; overload; virtual;

    function SetTorrentCategory(Hashes: TStringList; Category: string): boolean; overload; virtual;
    function SetTorrentCategory(Torrents: TqBitMainDataType; Category: string): boolean; overload; virtual;
    function SetTorrentCategory(Torrents: TqBitTorrentsListType; Category: string): boolean; overload; virtual;

    function RemoveCategories(Categories: TStringList): boolean; overload; virtual;

    function AddTorrentTags(Hashes: string; Tags: TStringList): boolean; overload; virtual;
    function AddTorrentTags(Hashes: TStringList; Tags: string): boolean; overload; virtual;
    function AddTorrentTags(Hashes, Tags: TStringList): boolean; overload; virtual;
    function AddTorrentTags(Torrents: TqBitMainDataType; Tags: TStringList): boolean; overload; virtual;
    function AddTorrentTags(Torrents: TqBitTorrentsListType; Tags: TStringList): boolean; overload; virtual;
    function AddTorrentTags(Torrents: TqBitMainDataType; Tags: string): boolean; overload; virtual;
    function AddTorrentTags(Torrents: TqBitTorrentsListType; Tags: string): boolean; overload; virtual;

    function RemoveTorrentTags(Hashes: string; Tags: TStringList): boolean; overload; virtual;
    function RemoveTorrentTags(Hashes: TStringList; Tags: string): boolean; overload; virtual;
    function RemoveTorrentTags(Hashes, Tags: TStringList): boolean; overload; virtual;
    function RemoveTorrentTags(Torrents: TqBitMainDataType; Tags: TStringList): boolean; overload; virtual;
    function RemoveTorrentTags(Torrents: TqBitTorrentsListType; Tags: TStringList): boolean; overload; virtual;
    function RemoveTorrentTags(Torrents: TqBitMainDataType; Tags: string): boolean; overload; virtual;
    function RemoveTorrentTags(Torrents: TqBitTorrentsListType; Tags: string): boolean; overload; virtual;

    function CreateTags(Tags: TStringList): boolean; overload; virtual;
    function DeleteTags(Tags: TStringList): boolean; overload; virtual;

    function AddNewTorrentUrl(Url: string): boolean;

    function SetAutomaticTorrentManagement(Hashes: TStringList; Enable: boolean): boolean; overload; virtual;
    function SetAutomaticTorrentManagement(Torrents: TqBitMainDataType; Enable: boolean): boolean; overload; virtual;
    function SetAutomaticTorrentManagement(Torrents: TqBitTorrentsListType; Enable: boolean): boolean; overload; virtual;

    function ToggleSequentialDownload(Hashes: TStringList): boolean; overload; virtual;
    function ToggleSequentialDownload(Torrents: TqBitMainDataType): boolean; overload; virtual;
    function ToggleSequentialDownload(Torrents: TqBitTorrentsListType): boolean; overload; virtual;

    function SetFirstLastPiecePriority(Hashes: TStringList): boolean; overload; virtual;
    function SetFirstLastPiecePriority(Torrents: TqBitMainDataType): boolean; overload; virtual;
    function SetFirstLastPiecePriority(Torrents: TqBitTorrentsListType): boolean; overload; virtual;

    function SetForceStart(Hashes: TStringList; Value: boolean): boolean; overload; virtual;
    function SetForceStart(Torrents: TqBitMainDataType; Value: boolean): boolean; overload; virtual;
    function SetForceStart(Torrents: TqBitTorrentsListType; Value: boolean): boolean; overload; virtual;

    function SetSuperSeeding(Hashes: TStringList; Value: boolean): boolean; overload; virtual;
    function SetSuperSeeding(Torrents: TqBitMainDataType; Value: boolean): boolean; overload; virtual;
    function SetSuperSeeding(Torrents: TqBitTorrentsListType; Value: boolean): boolean; overload; virtual;

    function GetAllTorrentList: TqBitTorrentsListType; virtual;

    property HostPath: string read FHostPath;
    property Username: string read FUsername;
    property Password: string read FPassword;
    property HTTPStatus: integer read FHTTPStatus;
    property HTTPResponse: string read FHTTPResponse;
    property HTTPDuration: cardinal read FHTTPDuration;
    property HTTPRetries: integer read FHTTPRetries write FHTTPRetries;
  end;

implementation

class function TqBit.Connect(HostPath, Username, Password : string): TqBit;
begin
  Result := TqBit.Create(HostPath);
  var CurRetries := Result.HTTPRetries;
  Result.FHTTPRetries := 1;
  if not Result.Login(Username, Password) then
    FreeAndNil(Result)
  else
    Result.HTTPRetries := CurRetries;
end;

class function TqBit.TorrentsToHashesList(Torrents: TqBitMainDataType): TStringList;
begin
  Result := TStringList.Create;
  for var Torrent in Torrents.torrents do
    Result.Add(Torrent.Key)
end;

class function TqBit.TorrentsToHashesList(Torrents: TqBitTorrentsListType): TStringList;
begin
  Result := TStringList.Create;
  for var Torrent in Torrents.torrents do
    Result.Add(TqBitTorrentType(Torrent).hash.AsString);
end;

class function TqBit.qBitVersion: string;
begin
  Result := Format('%d.%.*d.%s', [qBitMajorVersion, 3, qBitMinorVersion, qBitAPI_WebAPIVersion]);
end;

class function TqBit.qBitWebAPIVersion: string;
begin
  Result := qBitAPI_WebAPIVersion;
end;

class function TqBit.qBitMajorVersion: Integer;
begin
  Result := qBitAPI_MajorVersion;
end;

class function TqBit.qBitMinorVersion: Integer;
begin
  Result := qBitAPI_MinorVersion;
end;

class function TqBit.qBitCheckWebAPICompatibility(RemoteWebAPIVersion: string): Boolean;
begin
  var DigitsR := RemoteWebAPIVersion.Split(['.']);
  var DigitsL := qBitAPI_WebAPIVersion.Split(['.']);
  Result :=  CompareText(RemoteWebAPIVersion, qBitAPI_WebAPIVersion)  >= 0;
end;

function TqBit.qBitCheckWebAPICompatibility: Boolean;
begin
  Result := qBitCheckWebAPICompatibility(GetAPIVersion);
end;

// DeleteTorrents
function TqBit.DeleteTorrents(Hashes: TStringList; DeleteFiles: boolean = False): boolean;
begin
  Hashes.StrictDelimiter := True; Hashes.Delimiter := '|';
  Result := DeleteTorrents(Hashes.DelimitedText, DeleteFiles);
end;
function TqBit.DeleteTorrents(Torrents: TqBitTorrentsListType; DeleteFiles: boolean): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := DeleteTorrents(TorrentList);
  TorrentList.Free;;
end;
function TqBit.DeleteTorrents(Torrents: TqBitMainDataType; DeleteFiles: boolean): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := DeleteTorrents(TorrentList);
  TorrentList.Free;;
end;

// RecheckTorrents
function TqBit.RecheckTorrents(Hashes: TStringList): boolean;
begin
  Hashes.StrictDelimiter := True; Hashes.Delimiter := '|';
  Result := RecheckTorrents(Hashes.DelimitedText);
end;
function TqBit.RecheckTorrents(Torrents: TqBitTorrentsListType): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := RecheckTorrents(TorrentList);
  TorrentList.Free;;
end;
function TqBit.RecheckTorrents(Torrents: TqBitMainDataType): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := RecheckTorrents(TorrentList);
  TorrentList.Free;;
end;

// ReannounceTorrents
function TqBit.ReannounceTorrents(Hashes: TStringList): boolean;
begin
  Hashes.StrictDelimiter := True; Hashes.Delimiter := '|';
  Result := ReannounceTorrents(Hashes.DelimitedText);
end;
function TqBit.ReannounceTorrents(Torrents: TqBitTorrentsListType): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := ReannounceTorrents(TorrentList);
  TorrentList.Free;;
end;
function TqBit.ReannounceTorrents(Torrents: TqBitMainDataType): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := ReannounceTorrents(TorrentList);
  TorrentList.Free;;
end;

// AddTrackersToTorrent
function TqBit.AddTrackersToTorrent(Hash: string;  Urls: TStringList): boolean;
begin
  Urls.StrictDelimiter := True; Urls.Delimiter := Chr($A);
  Result := AddTrackersToTorrent(Hash, Urls.DelimitedText);
end;

// RemoveTrackers
function TqBit.RemoveTrackers(Hash: string;  Urls: TStringList): boolean;
begin
  Urls.StrictDelimiter := True; Urls.Delimiter := '|';
  Result := RemoveTrackers(Hash, Urls.DelimitedText);
end;

// AddPeers
function TqBit.AddPeers(Hashes: string; Peers: TStringList): boolean;
begin
  Peers.StrictDelimiter := True; Peers.Delimiter := '|';
  Result := AddPeers(Hashes, Peers.DelimitedText);
end;
function TqBit.AddPeers(Hashes, Peers: TStringList): boolean;
begin
  Hashes.StrictDelimiter := True; Hashes.Delimiter := '|';
  Peers.StrictDelimiter := True; Peers.Delimiter := '|';
  Result := AddPeers(Hashes.DelimitedText, Peers.DelimitedText);
end;
function TqBit.AddPeers(Torrents: TqBitMainDataType; Peers: TStringList): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := AddPeers(TorrentList, Peers);
  TorrentList.Free;;
end;
function TqBit.AddPeers(Torrents: TqBitTorrentsListType; Peers: TStringList): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := AddPeers(TorrentList, Peers);
  TorrentList.Free;;
end;

// Ban/Unban Peers
function TqBit.BanPeers(Peers: TStringList): boolean;
begin
  Peers.StrictDelimiter := True; Peers.Delimiter := '|';
  Result := BanPeers(Peers.DelimitedText);
end;

function TqBit.UnbanPeers(Peers: TStringList): boolean;
begin
  Result := False;
  var BanPeers := GetBanPeersList;
  if BanPeers = nil then exit;
  for var Peer in Peers do
    if BanPeers.IndexOf(Peer) <> -1 then
      BanPeers.Delete(BanPeers.IndexOf(Peer));
  Result := SetBanPeersList(BanPeers);
  BanPeers.Free;
end;

function TqBit.UnbanPeers(Peers: string): boolean;
begin
  var BanPeers := TStringList.create(#0, '|', [soStrictDelimiter]);
  BanPeers.Text := Peers;
  Result := UnbanPeers(BanPeers.DelimitedText);
  BanPeers.Free;
end;

function TqBit.UnbanAllPeers: boolean;
begin
  Result := SetBanPeersList('*');
end;

function TqBit.GetBanPeersList: TStringList;
begin
  Result := nil;
  var Prefs := Self.GetPreferences;
  if Prefs = nil then Exit;
  Result := TStringList.Create;
  Result.StrictDelimiter := True; Result.Delimiter := #$A;
  Result.DelimitedText := Prefs.banned_IPs.AsString;
  Prefs.Free;
end;

function TqBit.SetBanPeersList(PeersStr: string): Boolean;
begin
  var Prefs := TqBitPreferencesType.Create;
  Prefs.banned_IPs := PeersStr;
  Result := SetPreferences(Prefs);
  Prefs.Free;
end;

function TqBit.SetBanPeersList(PeersList: TStringList): Boolean;
begin
   PeersList.StrictDelimiter := True; PeersList.Delimiter := #$A;
   Result := SetBanPeersList(PeersList.DelimitedText);
end;

// IncreaseTorrentPriority
function TqBit.IncreaseTorrentPriority(Hashes: TStringList): boolean;
begin
  Hashes.StrictDelimiter := True; Hashes.Delimiter := '|';
  Result := IncreaseTorrentPriority(Hashes.DelimitedText);
end;
function TqBit.IncreaseTorrentPriority(Torrents: TqBitTorrentsListType): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := IncreaseTorrentPriority(TorrentList);
  TorrentList.Free;;
end;
function TqBit.IncreaseTorrentPriority(Torrents: TqBitMainDataType): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := IncreaseTorrentPriority(TorrentList);
  TorrentList.Free;;
end;

// DecreaseTorrentPriority
function TqBit.DecreaseTorrentPriority(Hashes: TStringList): boolean;
begin
  Hashes.StrictDelimiter := True; Hashes.Delimiter := '|';
  Result := DecreaseTorrentPriority(Hashes.DelimitedText);
end;
function TqBit.DecreaseTorrentPriority(Torrents: TqBitTorrentsListType): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := DecreaseTorrentPriority(TorrentList);
  TorrentList.Free;;
end;
function TqBit.DecreaseTorrentPriority(Torrents: TqBitMainDataType): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := DecreaseTorrentPriority(TorrentList);
  TorrentList.Free;;
end;

// MinimalTorrentPriority
function TqBit.MinimalTorrentPriority(Hashes: TStringList): boolean;
begin
  Hashes.StrictDelimiter := True; Hashes.Delimiter := '|';
  Result := MinimalTorrentPriority(Hashes.DelimitedText);
end;
function TqBit.MinimalTorrentPriority(Torrents: TqBitTorrentsListType): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := MinimalTorrentPriority(TorrentList);
  TorrentList.Free;;
end;
function TqBit.MinimalTorrentPriority(Torrents: TqBitMainDataType): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := MinimalTorrentPriority(TorrentList);
  TorrentList.Free;;
end;

// MaximalTorrentPriority
function TqBit.MaximalTorrentPriority(Hashes: TStringList): boolean;
begin
  Hashes.StrictDelimiter := True; Hashes.Delimiter := '|';
  Result := MaximalTorrentPriority(Hashes.DelimitedText);
end;
function TqBit.MaximalTorrentPriority(Torrents: TqBitTorrentsListType): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := MaximalTorrentPriority(TorrentList);
  TorrentList.Free;;
end;
function TqBit.MaximalTorrentPriority(Torrents: TqBitMainDataType): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := MaximalTorrentPriority(TorrentList);
  TorrentList.Free;;
end;

// SetFilePriority
function TqBit.SetFilePriority(Hash: string; Ids: TStringList; Priority: integer): boolean;
begin
  Ids.StrictDelimiter := True; Ids.Delimiter := '|';
  Result := SetFilePriority(Hash, Ids.DelimitedText, Priority);
end;

// GetTorrentDownloadLimit
function TqBit.GetTorrentDownloadLimit(Hashes: TStringList): TqBitTorrentSpeedsLimitType;
begin
  Hashes.StrictDelimiter := True; Hashes.Delimiter := '|';
  Result := GetTorrentDownloadLimit(Hashes.DelimitedText);
end;
function TqBit.GetTorrentDownloadLimit(Torrents: TqBitTorrentsListType): TqBitTorrentSpeedsLimitType;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := GetTorrentDownloadLimit(TorrentList);
  TorrentList.Free;;
end;
function TqBit.GetTorrentDownloadLimit(Torrents: TqBitMainDataType): TqBitTorrentSpeedsLimitType;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := GetTorrentDownloadLimit(TorrentList);
  TorrentList.Free;;
end;

// SetTorrentDownloadLimit
function TqBit.SetTorrentDownloadLimit(Hashes: TStringList; Limit: integer): boolean;
begin
  Hashes.StrictDelimiter := True; Hashes.Delimiter := '|';
  Result := SetTorrentDownloadLimit(Hashes.DelimitedText, Limit);
end;
function TqBit.SetTorrentDownloadLimit(Torrents: TqBitMainDataType; Limit: integer): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := SetTorrentDownloadLimit(TorrentList, Limit);
  TorrentList.Free;;
end;
function TqBit.SetTorrentDownloadLimit(Torrents: TqBitTorrentsListType; Limit: integer): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := SetTorrentDownloadLimit(TorrentList, Limit);
  TorrentList.Free;;
end;

// SetTorrentShareLimit
function TqBit.SetTorrentShareLimit(Hashes: TStringList; RatioLimit: double; SeedingTimeLimit: integer): boolean;
begin
  Hashes.StrictDelimiter := True; Hashes.Delimiter := '|';
  Result := SetTorrentShareLimit(Hashes.DelimitedText, RatioLimit, SeedingTimeLimit);
end;
function TqBit.SetTorrentShareLimit(Torrents: TqBitMainDataType; RatioLimit: double; SeedingTimeLimit: integer): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := SetTorrentShareLimit(TorrentList, RatioLimit, SeedingTimeLimit);
  TorrentList.Free;;
end;
function TqBit.SetTorrentShareLimit(Torrents: TqBitTorrentsListType; RatioLimit: double; SeedingTimeLimit: integer): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := SetTorrentShareLimit(TorrentList, RatioLimit, SeedingTimeLimit);
  TorrentList.Free;;
end;

// GetTorrentUploadLimit
function TqBit.GetTorrentUploadLimit(Hashes: TStringList): TqBitTorrentSpeedsLimitType;
begin
 Hashes.StrictDelimiter := True;  Hashes.Delimiter := '|';
  Result := GetTorrentUploadLimit(Hashes.DelimitedText);
end;
function TqBit.GetTorrentUploadLimit(Torrents: TqBitMainDataType): TqBitTorrentSpeedsLimitType;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := GetTorrentUploadLimit(TorrentList);
  TorrentList.Free;;
end;
function TqBit.GetTorrentUploadLimit(Torrents: TqBitTorrentsListType): TqBitTorrentSpeedsLimitType;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := GetTorrentUploadLimit(TorrentList);
  TorrentList.Free;;
end;

// SetTorrentUploadLimit
function TqBit.SetTorrentUploadLimit(Hashes: TStringList; Limit: integer): boolean;
begin
  Hashes.StrictDelimiter := True; Hashes.Delimiter := '|';
  Result := SetTorrentUploadLimit(Hashes.DelimitedText, Limit);
end;
function TqBit.SetTorrentUploadLimit(Torrents: TqBitMainDataType; Limit: integer): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := SetTorrentUploadLimit(TorrentList, Limit);
  TorrentList.Free;;
end;
function TqBit.SetTorrentUploadLimit(Torrents: TqBitTorrentsListType; Limit: integer): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := SetTorrentUploadLimit(TorrentList, Limit);
  TorrentList.Free;;
end;

// SetTorrentLocation
function TqBit.SetTorrentLocation(Hashes: TStringList;
  Location: string): boolean;
begin
  Hashes.StrictDelimiter := True; Hashes.Delimiter := '|';
  Result := SetTorrentLocation(Hashes.DelimitedText, Location);
end;
function TqBit.SetTorrentLocation(Torrents: TqBitMainDataType; Location: string): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := SetTorrentLocation(TorrentList, Location);
  TorrentList.Free;;
end;
function TqBit.SetTorrentLocation(Torrents: TqBitTorrentsListType; Location: string): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := SetTorrentLocation(TorrentList, Location);
  TorrentList.Free;;
end;

// SetTorrentCategory
function TqBit.SetTorrentCategory(Hashes: TStringList; Category: string): boolean;
begin
  Hashes.StrictDelimiter := True; Hashes.Delimiter := '|';
  Result := SetTorrentCategory(Hashes.DelimitedText, Category);
end;
function TqBit.SetTorrentCategory(Torrents: TqBitMainDataType; Category: string): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := SetTorrentCategory(TorrentList, Category);
  TorrentList.Free;;
end;
function TqBit.SetTorrentCategory(Torrents: TqBitTorrentsListType; Category: string): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := SetTorrentLocation(TorrentList, Category);
  TorrentList.Free;;
end;

// RemoveCategories
function TqBit.RemoveCategories(Categories: TStringList): boolean;
begin
  Categories.StrictDelimiter := True; Categories.Delimiter := Chr($A);
  Result := RemoveCategories(Categories.DelimitedText);
end;

// AddTorrentTags
function TqBit.AddTorrentTags(Hashes: string; Tags: TStringList): boolean;
begin
  Tags.StrictDelimiter := True; Tags.Delimiter := ',';
  Result := AddTorrentTags(Hashes, Tags.DelimitedText);
end;
function TqBit.AddTorrentTags(Hashes: TStringList; Tags: string): boolean;
begin
  Hashes.StrictDelimiter := True; Hashes.Delimiter := ',';
  Result := AddTorrentTags(Hashes.DelimitedText, Tags);
end;
function TqBit.AddTorrentTags(Hashes, Tags: TStringList): boolean;
begin
  Hashes.StrictDelimiter := True; Hashes.Delimiter := '|';
  Hashes.StrictDelimiter := True; Tags.Delimiter := ',';
  Result := AddTorrentTags(Hashes.DelimitedText, Tags.DelimitedText);
end;
function TqBit.AddTorrentTags(Torrents: TqBitMainDataType; Tags: TStringList): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := AddTorrentTags(TorrentList, Tags);
  TorrentList.Free;;
end;
function TqBit.AddTorrentTags(Torrents: TqBitTorrentsListType; Tags: TStringList): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := AddTorrentTags(TorrentList, Tags);
  TorrentList.Free;;
end;
function TqBit.AddTorrentTags(Torrents: TqBitMainDataType; Tags: string): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := AddTorrentTags(TorrentList, Tags);
  TorrentList.Free;;
end;
function TqBit.AddTorrentTags(Torrents: TqBitTorrentsListType; Tags: string): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := AddTorrentTags(TorrentList, Tags);
  TorrentList.Free;;
end;

// RemoveTorrentTags
function TqBit.RemoveTorrentTags(Hashes: string; Tags: TStringList): boolean;
begin
  Tags.StrictDelimiter := True; Tags.Delimiter := ',';
  Result := RemoveTorrentTags(Hashes, Tags.DelimitedText);
end;
function TqBit.RemoveTorrentTags(Hashes: TStringList; Tags: string): boolean;
begin
  Hashes.StrictDelimiter := True; Hashes.Delimiter := '|';
  Result := RemoveTorrentTags(Hashes.DelimitedText, Tags);
end;
function TqBit.RemoveTorrentTags(Hashes, Tags: TStringList): boolean;
begin
  Hashes.StrictDelimiter := True; Hashes.Delimiter := '|';
  Hashes.StrictDelimiter := True; Tags.Delimiter := ',';
  Result := RemoveTorrentTags(Hashes.DelimitedText, Tags.DelimitedText);
end;
function TqBit.RemoveTorrentTags(Torrents: TqBitMainDataType; Tags: TStringList): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := RemoveTorrentTags(TorrentList, Tags);
  TorrentList.Free;;
end;
function TqBit.RemoveTorrentTags(Torrents: TqBitTorrentsListType; Tags: TStringList): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := RemoveTorrentTags(TorrentList, Tags);
  TorrentList.Free;;
end;
function TqBit.RemoveTorrentTags(Torrents: TqBitMainDataType; Tags: string): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := RemoveTorrentTags(TorrentList, Tags);
  TorrentList.Free;;
end;
function TqBit.RemoveTorrentTags(Torrents: TqBitTorrentsListType; Tags: string): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := RemoveTorrentTags(TorrentList, Tags);
  TorrentList.Free;;
end;


// CreateTags
function TqBit.CreateTags(Tags: TStringList): boolean;
begin
  Tags.StrictDelimiter := True; Tags.Delimiter := ',';
  Result := CreateTags(Tags.DelimitedText);
end;

// DeleteTags
function TqBit.DeleteTags(Tags: TStringList): boolean;
begin
  Tags.StrictDelimiter := True; Tags.Delimiter := ',';
  Result := DeleteTags(Tags.DelimitedText);
end;

// AddNewTorrentUrl
function TqBit.AddNewTorrentUrl(Url: string): boolean;
var
  NewTorrentUrls: TqBitNewTorrentUrlsType;
begin
  NewTorrentUrls := TqBitNewTorrentUrlsType.Create;
  NewTorrentUrls.urls.Add(Url);
  Result := AddNewTorrentUrls(NewTorrentUrls);
  NewTorrentUrls.Free;
end;


// SetAutomaticTorrentManagement
function TqBit.SetAutomaticTorrentManagement(Hashes: TStringList; Enable: boolean): boolean;
begin
  Hashes.StrictDelimiter := True; Hashes.Delimiter := '|';
  Result := SetAutomaticTorrentManagement(Hashes.DelimitedText, Enable);
end;
function TqBit.SetAutomaticTorrentManagement(Torrents: TqBitMainDataType; Enable: boolean): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := SetAutomaticTorrentManagement(TorrentList, Enable);
  TorrentList.Free;;
end;
function TqBit.SetAutomaticTorrentManagement(Torrents: TqBitTorrentsListType; Enable: boolean): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := SetAutomaticTorrentManagement(TorrentList, Enable);
  TorrentList.Free;;
end;

// ToggleSequentialDownload
function TqBit.ToggleSequentialDownload(Hashes: TStringList): boolean;
begin
  Hashes.StrictDelimiter := True;  Hashes.Delimiter := '|';
  Result := ToggleSequentialDownload(Hashes.DelimitedText);
end;
function TqBit.ToggleSequentialDownload(Torrents: TqBitMainDataType): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := ToggleSequentialDownload(TorrentList);
  TorrentList.Free;;
end;
function TqBit.ToggleSequentialDownload(Torrents: TqBitTorrentsListType): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := ToggleSequentialDownload(TorrentList);
  TorrentList.Free;;
end;

// SetFirstLastPiecePriority
function TqBit.SetFirstLastPiecePriority(Hashes: TStringList): boolean;
begin
  Hashes.StrictDelimiter := True; Hashes.Delimiter := '|';
  Result := SetFirstLastPiecePriority(Hashes.DelimitedText);
end;
function TqBit.SetFirstLastPiecePriority(Torrents: TqBitMainDataType): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := SetFirstLastPiecePriority(TorrentList);
  TorrentList.Free;;
end;
function TqBit.SetFirstLastPiecePriority(Torrents: TqBitTorrentsListType): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := SetFirstLastPiecePriority(TorrentList);
  TorrentList.Free;;
end;

// SetForceStart
function TqBit.SetForceStart(Hashes: TStringList; Value: boolean): boolean;
begin
  Hashes.StrictDelimiter := True; Hashes.Delimiter := '|';
  Result := SetForceStart(Hashes.DelimitedText, Value);
end;
function TqBit.SetForceStart(Torrents: TqBitMainDataType; Value: boolean): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := SetForceStart(TorrentList, Value);
  TorrentList.Free;;
end;
function TqBit.SetForceStart(Torrents: TqBitTorrentsListType; Value: boolean): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := SetForceStart(TorrentList, Value);
  TorrentList.Free;;
end;

// SetSuperSeeding
function TqBit.SetSuperSeeding(Hashes: TStringList; Value: boolean): boolean;
begin
  Hashes.StrictDelimiter := True; Hashes.Delimiter := '|';
  Result := SetSuperSeeding(Hashes.DelimitedText, value);
end;
function TqBit.SetSuperSeeding(Torrents: TqBitMainDataType; Value: boolean): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := SetSuperSeeding(TorrentList, Value);
  TorrentList.Free;;
end;
function TqBit.SetSuperSeeding(Torrents: TqBitTorrentsListType; Value: boolean): boolean;
begin
  var TorrentList := Self.TorrentsToHashesList(Torrents);
  Result := SetSuperSeeding(TorrentList, Value);
  TorrentList.Free;
end;

// GetAllTorrentList
function TqBit.GetAllTorrentList: TqBitTorrentsListType;
var
  Req: TqBitTorrentListRequestType;
begin
  Req:= Nil;
  try
    Req := TqBitTorrentListRequestType.Create;
    Req.Filter := 'all';
    Result := GetTorrentList(Req);
  finally
    Req.Free;
  end;
end;



end.
