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
unit uqBit.API;

interface
uses

    Classes
  , uqBit.API.Types
  ;

const

  qBitAPI_MajorVersion = 2;
  qBitAPI_MinorVersion = 1;
  qBitAPI_Developer = 'Laurent Meyer (qBit@lmeyer.fr)';

type

  TqBitAPI = class(TObject)
  protected
    FSID: string;
    FHostPath:      string;
    FUsername:      string;
    FPassword:      string;
    FHTTPStatus:    Integer;
    FHTTPResponse:  string;
    FHTTPDuration:  Cardinal;
    FHTTPRetries:   Integer;
  public
    constructor Create(HostPath: string); virtual;

    function qBCom(Verb: string; MethodPath: string; ReqST, ResST: TStringStream; ContentType: string): integer; virtual;
    function qBPost(MethodPath: string; var Body: string): integer; virtual;
    function qBGet(MethodPath: string; var Body: string): integer overload; virtual;
    function qBGet(MethodPath: string): Integer; overload; virtual;


  /////////////////////////////////////////////////////////////////////////////////////////
  // WebAPI: https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1) //
  /////////////////////////////////////////////////////////////////////////////////////////

  // Authentication :
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#login
    function Login(Username, Password: string): Boolean; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#logout
    function Logout: Boolean; virtual;

  // Application :
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-application-version
    function GetVersion: string; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-api-version
    function GetAPIVersion: string; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-build-info
    function GetBuildInfo: TqBitBuildInfoType; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#shutdown-application
    function Shutdown: Boolean; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-application-preferences
    function GetPreferences: TqBitPreferencesType; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#set-application-preferences
    function SetPreferences(Prefs: TqBitPreferencesType): boolean; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-default-save-path
    function GetDefaultSavePath: string; virtual;
       // UNDOCUMENTED
    function GetNetworkInterfaces: TqBitNetworkInterfacesType;
        // UNDOCUMENTED
    function GetNetworkInterfaceAddress(Iface: string = ''): TqBitNetworkInterfaceAddressesType;

  // Log :
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#log
    function GetLog(LastKnownId: int64 = -1; Normal: boolean = false;
              Info: boolean = false; Warning: boolean = true; Critical: boolean = true) : TqBitLogsType; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-peer-log
    function GetPeerLog(LastKnownId: int64 = -1): TqBitPeerLogsType; virtual;

  // Sync :
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-main-data
    function GetMainData(Rid: int64 = 0): TqBitMainDataType; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-torrent-peers-data
    function GetTorrentPeersData(Hash: string; Rid: int64 = 0): TqBitTorrentPeersDataType; virtual;

  // Transfer :
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-global-transfer-info
    function GetGlobalTransferInfo: TqBitGlobalTransferInfoType; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-alternative-speed-limits-state
    function GetAlternativeSpeedLimitsState: boolean; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#toggle-alternative-speed-limits
    function ToggleAlternativeSpeedLimits: boolean; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-global-download-limit
    function GetGlobalDownloadLimit: integer; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#set-global-download-limit
    function SetGlobalDownloadLimit( GlobalDownloadLimit: integer): boolean; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#set-global-upload-limit
    function GetGlobalUploadLimit: integer; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-global-upload-limit
    function SetGlobalUploadLimit(GlobalUploafimit: integer): boolean; virtual;
       // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#ban-peers
    function BanPeers(PeerListStr: string): boolean; overload; virtual;

  // Torrent management :
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-torrent-list
    function GetTorrentList(TorrentListRequest : TqBitTorrentListRequestType): TqBitTorrentsListType; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-torrent-generic-properties
    function GetTorrentGenericProperties(Hash: string): TqBitTorrentInfoType; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-torrent-trackers
    function GetTorrentTrackers(Hash: string): TqBitTrackersType; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-torrent-web-seeds
    function GetTorrentWebSeeds(Hash: string): TqBitWebSeedsType; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-torrent-contents
    function GetTorrentContents(Hash: string; Indexes: string = ''): TqBitContentsType;  virtual;
        // https://github.co m/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-torrent-pieces-states
    function GetTorrentPiecesStates(Hash: string): TqBitPiecesStatesType; virtual;
       // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#pause-torrents
    function StopTorrents(Hashes: string = 'all'): boolean; overload; virtual;
          // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#resume-torrents
    function StartTorrents(Hashes: string = 'all'): boolean; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#delete-torrents
    function DeleteTorrents(Hashes: string; DeleteFiles: boolean = False): boolean; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#recheck-torrents
    function RecheckTorrents(Hashes: string): boolean; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#reannounce-torrents
    function ReannounceTorrents(Hashes: string): boolean; overload; virtual;
       // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#add-new-torrent
    function AddNewTorrentUrls(NewTorrentUrls: TqBitNewTorrentUrlsType): boolean; virtual;
       // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#add-new-torrent
    function AddNewTorrentFile(NewTorrentFile: TqBitNewTorrentFileType): boolean; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#add-trackers-to-torrent
    function AddTrackersToTorrent(Hash: string; Urls: string): boolean; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#edit-trackers
    function EditTracker(Hash, OrigUrl, NewUrl: string): boolean; virtual;
         // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#remove-trackers
    function RemoveTrackers(Hash, Urls: string): boolean; overload; virtual;
         // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#add-peers
    function AddPeers(Hashes, Peers: string): boolean; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#increase-torrent-priority
    function IncreaseTorrentPriority(Hashes: string): boolean; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#decrease-torrent-priority
    function DecreaseTorrentPriority(Hashes: string): boolean; overload; virtual;
        // lient-tunnel.canalplus.com/resiliation-abonnement/selection-motif?contractId=1
    function MaximalTorrentPriority(Hashes: string): boolean; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#minimal-torrent-priority
    function MinimalTorrentPriority(Hashes: string): boolean; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#set-file-priority
    function SetFilePriority(Hash, Ids: string; Priority: integer): boolean; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-torrent-download-limit
    function GetTorrentDownloadLimit(Hashes: string): TqBitTorrentSpeedsLimitType; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#set-torrent-download-limit
    function SetTorrentDownloadLimit(Hashes: string; Limit: integer): boolean; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#set-torrent-share-limit
    function SetTorrentShareLimit(Hashes: string; RatioLimit: double; SeedingTimeLimit: integer): boolean; overload; virtual;
         // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-torrent-upload-limit
    function GetTorrentUploadLimit(Hashes: string): TqBitTorrentSpeedsLimitType; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#set-torrent-upload-limit
    function SetTorrentUploadLimit(Hashes: string; Limit: integer): boolean; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#set-torrent-location
    function SetTorrentLocation(Hashes, Location: string): boolean; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#set-torrent-name
    function SetTorrentName(Hash, Name: string): boolean; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#set-torrent-category
    function SetTorrentCategory(Hashes, Category: string): boolean; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-all-categories
    function GetAllCategories: TqBitCategoriesType; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#add-new-category
    function AddNewCategory(Category, SavePath: string): boolean;  virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#edit-category
    function EditCategory(Category, SavePath: string): boolean; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#remove-categories
    function RemoveCategories(Categories: string): boolean; overload; virtual;
      // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#add-torrent-tags
    function AddTorrentTags(Hashes, Tags: string): boolean; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#remove-torrent-tags
    function RemoveTorrentTags(Hashes, Tags: string): boolean; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-all-tags
    function GetAllTags: TqBitTagsType; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#create-tags
    function CreateTags(Tags: string): boolean; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#delete-tags
    function DeleteTags(Tags: string): boolean; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#set-automatic-torrent-management
    function SetAutomaticTorrentManagement(Hashes: string; Enable: boolean): boolean; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#toggle-sequential-download
    function ToggleSequentialDownload(Hashes: string): boolean; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#set-firstlast-piece-priority
    function SetFirstLastPiecePriority(Hashes: string): boolean; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#set-force-start
    function SetForceStart(Hashes: string; value: boolean): boolean; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#set-super-seeding
    function SetSuperSeeding(Hashes: string; value: boolean): boolean; overload; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#rename-file
    function RenameFile(Hash, OldPath, NewPath: string): boolean; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#rename-folder
    function RenameFolder(Hash, OldPath, NewPath: string): boolean; virtual;


  // RSS : EXPERIMENTAL & Not Tested
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#add-folder
    function RSSAddFolder(Path: string): boolean; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#add-feed
    function RSSAddFeed(Url, Path: string): boolean; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#remove-item
    function RSSRemoveItem(Path: string): boolean; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#move-item
    function RSSMoveItem(ItemPath, DestPath: string): boolean; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-all-items
    function RSSGetAllItems(WithData: boolean): TqBitRSSAllItemsType; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#mark-as-read
    function RSSMarkAsRead(ItemPath, ArticleId: string): boolean; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#refresh-item
    function RSSRefreshItem(ItemPath: string): boolean; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#set-auto-downloading-rule
    function RSSSetAutoDownloadingRules(RuleName: string; RuleDef: TqBitRSSRuleType): boolean; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#rename-auto-downloading-rule
    function RSSRenameAutoDownloadingRules(RuleName, NewRuleName: string): boolean; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#remove-auto-downloading-rule
    function RSSRemoveAutoDownloadingRules(RuleName: string): boolean; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-all-auto-downloading-rules
    function RSSGetAllAutoDownloadingRules: TqBitAutoDownloadingRulesType; virtual;
        // https://github.com/qbittorrent/qBittorrent/wiki/WebUI-API-(qBittorrent-4.1)#get-all-articles-matching-a-rule
    function RSSGetMatchingArticles(RuleName: string): TqBitRSSArticlesType; virtual;

  // Search : will be implemented if requested.

  end;

implementation
uses
    StrUtils
  , SysUtils
  , NetEncoding
  , System.Diagnostics
  , System.Net.URLClient
  , System.Net.HttpClient
  , System.Net.HttpClientComponent
  , NetConsts
  , System.Hash
  , uJX4Object
  ;


function URLEncode(const ToEncode: string): string;
begin
  // Having issues with TNetEncoding.URL.Encode()   (space being + instead of %20...)
  {$WARNINGS OFF}
  Result := System.Net.URLClient.TURI.URLEncode(ToEncode);
  {$WARNINGS ON}
end;

function URLEncodeDelimStr(Str: string; Delim: Char): string;
begin
  var List := TStringList.Create;
  List.StrictDelimiter := True;
  List.Delimiter := Delim;
  List.DelimitedText := Str;
  for var i := 0 to List.Count - 1 do
    List[i] := URLEncode(List[i]);
  Result := List.DelimitedText;
  List.Free;
end;

constructor TqBitAPI.Create(HostPath: string);
begin
  inherited Create;
  FSID := '';
  FHostPath := HostPath;
  FHTTPResponse := '';
  FHTTPStatus := -1;
  FHTTPDuration :=  0;
end;

function TqBitAPI.qBCom(Verb: string; MethodPath: string; ReqST, ResST: TStringStream; ContentType: string): integer;
var
  Res: IHTTPResponse;
  Http: THTTPClient;
  Sw: TStopWatch;
begin
  FHTTPResponse := '';
  FHTTPStatus := -1;
  Sw := TStopwatch.StartNew;;
  Http := THTTPClient.Create;
  try
    Http.UserAgent :=
      Format(
        // Do not Alter....
        'qBittorrent WebAPI for Delphi (qBit4Delphi, qB4D) - Version: %s.%d.%.*d -%s',
        [qBitAPI_WebAPIVersion, qBitAPI_MajorVersion, 3, qBitAPI_MinorVersion, qBitAPI_Developer]
      );
    Http.AutomaticDecompression := [THTTPCompressionMethod.Any];
    Http.ContentType := ContentType;
    Http.CustomHeaders['Referer'] := FHostPath;
    Http.CookieManager.AddServerCookie(Format('SID=%s', [FSID]), FHostPath);
    var Retries := FHTTPRetries;
    repeat
      Dec(Retries);
      var Url := Format('%s/api/v2%s?%s', [FHostPath, MethodPath, URLEncode(THash.GetRandomString)]);
      if LowerCase(Verb) = 'post' then
      begin
        ReqST.Position := 0; ResST.Position := 0;
        try Res := Http.Post(Url, ReqST, ResST);  except end;
      end else
        try Res := Http.Get(Url, ResST);  except end;

    until ((Res <> nil) or (Retries <= 0));
    if Res = nil then Exit;
    FHTTPStatus := Res.StatusCode;
    FHTTPResponse := ResST.DataString;
    for var Cookie in  Http.CookieManager.Cookies do
      if Cookie.Name = 'SID' then FSID := Cookie.Value;
  finally
    Result := FHTTPStatus;
    HTTP.Free;
    FHTTPDuration := Sw.ElapsedMilliseconds;
  end;
end;

function TqBitAPI.qBPost(MethodPath: string; var Body: string): integer;
var
  ReqSS: TStringStream;
  ResSS: TStringStream;
begin
  ReqSS := nil;
  ResSS := nil;
  try
  try
    ReqSS := TStringStream.Create(Body, TEncoding.UTF8);
    ResSS := TStringStream.Create('', TEncoding.UTF8);
    Result := qBCom('POST', MethodPath, ReqSS, ResSS, 'application/x-www-form-urlencoded; charset=UTF-8');
    if Result = 200 then Body := ResSS.DataString else Body := '';
  except
    Result := -1;
  end;
  finally
    ResSS.Free;
    ReqSS.Free;
  end;
end;

function TqBitAPI.qBGet(MethodPath: string; var Body: string): integer;
var
  ResSS: TStringStream;
begin
  ResSS := nil;
  try
  try
    ResSS := TStringStream.Create('', TEncoding.UTF8);
    Result := qBCom('GET', MethodPath, Nil, ResSS, 'application/json; charset=UTF-8');
    if Result = 200 then Body := ResSS.DataString else Body := '';
  except
    Result := -1;
  end;
  finally
    ResSS.Free;
  end;
end;

function TqBitAPI.qBGet(MethodPath: string): Integer;
begin
  var Body : string := '';
  Result := qBGet(MethodPath, body);
end;

////////////////////////////////////////////////////////////////////////////////

function TqBitAPI.Login(Username, Password: string): Boolean;
begin
  FUsername := Username;
  FPassword := Password;
  var Body := Format('username=%s&password=%s',[ URLEncode(Username), URLEncode(Password) ]);
  Result := (qBPost('/auth/login', Body) = 200)  and (Body = 'Ok.');
end;

function TqBitAPI.Logout: Boolean;
begin
  var Body: string := '';
  Result := qBPost('/auth/logout', Body) = 200;
end;

function TqBitAPI.GetVersion: string;
begin
  qBGet('/app/version', Result);
end;

function TqBitAPI.GetAPIVersion: string;
begin
  qBGet('/app/webapiVersion', Result);
end;

function TqBitAPI.GetBuildInfo: TqBitBuildInfoType;
begin
  Result := nil;
  var Body := '';
  if qBGet('/app/buildInfo', Body) = 200 then
    Result := TJX4Object.FromJSON<TqBitBuildInfoType>(Body);
end;

function TqBitAPI.Shutdown: Boolean;
begin
  var Body: string := '';
  Result := qBPost('/app/shutdown', Body) = 200;
end;

function TqBitAPI.GetPreferences: TqBitPreferencesType;
begin
  Result := nil;
  var Body := '';
  if qBGet('/app/preferences', Body) = 200 then
    Result := TJX4Object.FromJSON<TqBitPreferencesType>(Body, [joRaiseException, joRaiseOnMissingField]);
end;

function TqBitAPI.SetPreferences(Prefs: TqBitPreferencesType): boolean;
begin
  var Body := 'json=' + URLEncode(TJX4Object.ToJson(Prefs, [joNullToEmpty]));
  Result := qBPost('/app/setPreferences', Body) = 200;
end;

function TqBitAPI.GetDefaultSavePath: string;
begin
  qBGet('/app/defaultSavePath', Result);
end;

function TqBitAPI.GetNetworkInterfaces: TqBitNetworkInterfacesType;
begin
  Result := nil;
  var Body := '';
  if (qBPost('/app/networkInterfaceList', Body) = 200) and (Body <> '')  then
    Result := TJX4Object.FromJSON<TqBitNetworkInterfacesType>('{"ifaces":' + Body + '}', []);
end;

function TqBitAPI.GetNetworkInterfaceAddress(Iface: string): TqBitNetworkInterfaceAddressesType;
begin
  Result := nil;
  var Body := Format('iface=%s', [URLEncode(Iface)]);
  if (qBPost('/app/networkInterfaceAddressList', Body) = 200) and (Body <> '')  then
    Result := TJX4Object.FromJSON<TqBitNetworkInterfaceAddressesType>('{"adresses":' + Body + '}', []);
end;

function TqBitAPI.GetLog(LastKnownId: int64 = -1; Normal: boolean = false;
      Info: boolean = false; Warning: boolean = true; Critical: boolean = true) : TqBitLogsType;
begin
  Result := nil;
  var Body := Format(
                'normal=%s&info=%s&warning=%s&critical=%s&last_known_id=%d',
                [ cBoolToStr[Normal],  cBoolToStr[Info],  cBoolToStr[Warning],  cBoolToStr[Critical], LastKnownId ]
              );
  if qBGet('/log/main', Body) = 200 then
    Result := TJX4Object.FromJSON<TqBitLogsType>('{"logs":' + Body + '}', [joRaiseException, joRaiseOnMissingField]);
end;

function TqBitAPI.GetPeerLog(LastKnownId: int64 = -1): TqBitPeerLogsType;
begin
  Result := nil;
  var Body :=  Format('last_known_id=%d', [lastKnownId]);
  if  qBGet('/log/peers', Body) = 200 then
    Result :=  TJX4Object.FromJSON<TqBitPeerLogsType>('{"logs":' + Body + '}', []);
end;

function TqBitAPI.GetMainData(Rid: int64 = 0): TqBitMainDataType;
begin
  Result := nil;
  var Body := Format('rid=%d', [ Rid ]);
  if  qBPost('/sync/maindata', Body) = 200 then
  begin
    Result :=TJX4Object.FromJSON<TqBitMainDataType>(Body, []);
    // Custom Fields
    for var LEle in Result.torrents do LEle.Value.hash := LEle.Key;
  end;
end;

function TqBitAPI.GetTorrentPeersData(Hash: string;
  Rid: int64 = 0): TqBitTorrentPeersDataType;
begin
  Result := nil;
  var Body := Format('hash=%s&rid=%d', [Hash, Rid]);
  if  qBPost('/sync/torrentPeers', Body) = 200 then
  begin
    Result := TJX4Object.FromJSON<TqBitTorrentPeersDataType>(Body, []);
    // Custom Fields
    for var LEle in Result.peers do LEle.Value.hash := LEle.Key;
  end;
end;

function TqBitAPI.GetGlobalTransferInfo: TqBitGlobalTransferInfoType;
begin
  Result := nil;
  var Body := '';
  if  qBGet('/transfer/info', Body) = 200 then
    Result := TJX4Object.FromJSON<TqBitGlobalTransferInfoType>(Body, []);
end;

function TqBitAPI.GetAlternativeSpeedLimitsState: boolean;
begin
  Result := False;
  var Body := '';
  if  qBGet('/transfer/speedLimitsMode', Body) = 200 then
    Result := Body = '1';
end;

function TqBitAPI.ToggleAlternativeSpeedLimits: boolean;
begin
  var Body: string := '';
  Result := qBPost('/transfer/toggleSpeedLimitsMode', Body) = 200 ;
end;

function TqBitAPI.GetGlobalDownloadLimit: integer;
begin
  Result := -1;
  var Body := '';
  if  qBGet('/transfer/downloadLimit', Body) = 200 then
    TryStrToInt(Body, Result);
end;

function TqBitAPI.SetGlobalDownloadLimit(GlobalDownloadLimit: integer): boolean;
begin
  var Body :=  Format('limit=%d', [GlobalDownloadLimit]);
    Result := qBPost('/transfer/setDownloadLimit', Body) = 200;
end;

function TqBitAPI.GetGlobalUploadLimit: integer;
begin
  Result := -1;
  var Body := '';
  if qBGet('/transfer/uploadLimit', Body) = 200 then
    TryStrToInt(Body, Result);
end;

function TqBitAPI.SetGlobalUploadLimit(GlobalUploafimit: integer): boolean;
begin
  var Body := Format('limit=%d', [GlobalUploafimit]);
  Result := qBPost('/transfer/setUploadLimit', Body) = 200;
end;

function TqBitAPI.BanPeers(PeerListStr: string): boolean;
begin
  var Body := Format('peers=%s', [URLEncodeDelimStr(PeerListStr, '|')]);
  Result := qBPost('/transfer/banPeers', Body) = 200;
end;

function TqBitAPI.GetTorrentList(TorrentListRequest: TqBitTorrentListRequestType): TqBitTorrentsListType;
var
  Lsl: TStringList;
begin
  Result := nil;
  Lsl := TStringList.Create(#0, '&', [soStrictDelimiter]);
  if not TorrentListRequest.filter.IsEmpty then Lsl.Add('filter=' + URLEncode(TorrentListRequest.filter));
  if not TorrentListRequest.category.IsEmpty then Lsl.Add('category=' + URLEncode(TorrentListRequest.category));
  if not TorrentListRequest.tag.IsEmpty then Lsl.Add('tag=' + URLEncode(TorrentListRequest.tag));
  if not TorrentListRequest.sort.IsEmpty then Lsl.Add('sort=' + URLEncode(TorrentListRequest.sort));
  if TorrentListRequest.reverse then Lsl.Add('reverse=' + URLEncode(cBoolToStr[TorrentListRequest.reverse]));
  if TorrentListRequest.limit > 0 then Lsl.Add('limit=' + URLEncode(TorrentListRequest.limit.ToString));
  if TorrentListRequest.offset > 0 then Lsl.Add('offset=' + URLEncode(TorrentListRequest.offset.ToString));
  if not TorrentListRequest.hashes.IsEmpty then Lsl.Add('hashes=' + URLEncode(TorrentListRequest.hashes.DelimitedText));
  var Body := Lsl.DelimitedText;
  if (qBGet('/torrents/info', Body) = 200) and (Body <> '')  then
    Result := TJX4Object.FromJSON<TqBitTorrentsListType>('{"torrents":' + Body + '}', []);
end;

function TqBitAPI.GetTorrentGenericProperties(Hash: string): TqBitTorrentInfoType;
begin
  Result := nil;
  var Body :=  Format('hash=%s', [Hash]);
  if (qBPost('/torrents/properties', Body) = 200) and (Body <> '')  then
    Result := TJX4Object.FromJSON<TqBitTorrentInfoType>(Body, []);
end;

function TqBitAPI.GetTorrentTrackers(Hash: string): TqBitTrackersType;
begin
  Result := nil;
  var Body := Format('hash=%s', [Hash]);
  if (qBPost('/torrents/trackers', Body) = 200) and (Body <> '')  then
  begin
    Result := TJX4Object.FromJSON<TqBitTrackersType>('{"trackers":' + Body + '}', []);
    // Custom Fields
    for var LEle in Result.trackers do LEle.hash := LEle.url;
  end;
end;

function TqBitAPI.GetTorrentWebSeeds(Hash: string): TqBitWebSeedsType;
begin
  Result := nil;
  var Body := Format('hash=%s', [Hash]);
  if (qBPost('/torrents/webseeds', Body) = 200) and (Body <> '')  then
     Result := TJX4Object.FromJSON<TqBitWebSeedsType>('{"urls":' + Body + '}', []);
end;

function TqBitAPI.GetTorrentContents(Hash: string; Indexes: string = ''): TqBitContentsType;
begin
  Result := nil;
  var Body := '';
  if Indexes = '' then
    Body := Format('hash=%s', [Hash])
  else
    Body := Format('hash=%s&indexes=%s', [Hash, URLEncodeDelimStr(Indexes, '|')]);
  if (qBPost('/torrents/files', Body) = 200) and (Body <> '')  then
    Result := TJX4Object.FromJSON<TqBitContentsType>('{"contents":' + Body + '}', []);
end;

function TqBitAPI.GetTorrentPiecesStates(Hash: string): TqBitPiecesStatesType;
begin
  Result := nil;
  var Body :=  Format('hash=%s', [Hash]);
  if (qBPost('/torrents/pieceStates', Body) = 200) and (Body <> '')  then
    Result := TJX4Object.FromJSON<TqBitPiecesStatesType>('{"states":' + Body + '}', []);
end;

function TqBitAPI.StopTorrents(Hashes: string = 'all'): boolean;
begin
  var Body :=  Format('hashes=%s', [Hashes]);
  Result := qBPost('/torrents/stop', Body) = 200;
end;

function TqBitAPI.StartTorrents(Hashes: string = 'all'): boolean;
begin
  var Body :=  Format('hashes=%s', [Hashes]);
  Result := qBPost('/torrents/start', Body) = 200;
end;

function TqBitAPI.DeleteTorrents(Hashes: string; DeleteFiles: boolean = False): boolean;
begin
  var Body := Format('hashes=%s&deleteFiles=%s', [Hashes, cBoolToStr[DeleteFiles]]);
  Result := qBPost('/torrents/delete', Body) = 200;
end;

function TqBitAPI.RecheckTorrents(Hashes: string): boolean;
begin
  var Body := Format('hashes=%s', [Hashes]);
  Result := qBPost('/torrents/recheck', Body) = 200;
end;

function TqBitAPI.ReannounceTorrents(Hashes: string): boolean;
begin
  var Body := Format('hashes=%s', [Hashes]);
  Result := qBPost('/torrents/reannounce', Body) = 200;
end;

function TqBitAPI.AddNewTorrentUrls(NewTorrentUrls: TqBitNewTorrentUrlsType): boolean;
var
  GUID: TGUID;
  Boundary: string;
  SS: TStringStream;
begin
  SS := nil;
  try
    SS := TStringStream.Create('', TEncoding.ASCII);
    CreateGUID(GUID);
    Boundary := '----' +
                Format(
                   '%0.8X%0.4X%0.4X%0.2X%0.2X%0.2X%0.2X%0.2X%0.2X%0.2X%0.2X',
                   [GUID.D1, GUID.D2, GUID.D3,
                   GUID.D4[0], GUID.D4[1], GUID.D4[2], GUID.D4[3],
                   GUID.D4[4], GUID.D4[5], GUID.D4[6], GUID.D4[7]]
                );
    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="urls"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    SS.WriteString(NewTorrentUrls.urls.Text);
    SS.WriteString(#$D#$A);
    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="autoTMM"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    SS.WriteString(cBoolToStr[NewTorrentUrls.autoTMM.AsBoolean]);
    SS.WriteString(#$D#$A);
    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="savepath"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    SS.WriteString(NewTorrentUrls.savepath.AsString);
    SS.WriteString(#$D#$A);
    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="cookie"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    SS.WriteString(NewTorrentUrls.cookie.AsString);
    SS.WriteString(#$D#$A);
    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="rename"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    SS.WriteString(NewTorrentUrls.rename.AsString);
    SS.WriteString(#$D#$A);
    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="category"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    SS.WriteString(NewTorrentUrls.category.AsString);
    SS.WriteString(#$D#$A);
    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="paused"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    SS.WriteString(cBoolToStr[NewTorrentUrls.stopped.AsBoolean]);
    SS.WriteString(#$D#$A);
    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="skip_checking"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    SS.WriteString(cBoolToStr[NewTorrentUrls.skip_checking.AsBoolean]);
    SS.WriteString(#$D#$A);
    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="contentLayout"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    SS.WriteString(NewTorrentUrls.contentLayout.AsString);
    SS.WriteString(#$D#$A);
    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="sequentialDownload"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    SS.WriteString(cBoolToStr[NewTorrentUrls.sequentialDownload.AsBoolean]);
    SS.WriteString(#$D#$A);
    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="firstLastPiecePrio"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    SS.WriteString(cBoolToStr[NewTorrentUrls.firstLastPiecePrio.AsBoolean]);
    SS.WriteString(#$D#$A);
    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="dlLimit"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    if NewTorrentUrls.dlLimit.AsInteger < 0 then SS.WriteString('NaN') else SS.WriteString(NewTorrentUrls.dlLimit.ToString);
    SS.WriteString(#$D#$A);
    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="upLimit"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    if NewTorrentUrls.upLimit.AsInteger < 0 then SS.WriteString('NaN') else SS.WriteString(NewTorrentUrls.upLimit.ToString);
    SS.WriteString(#$D#$A);
    SS.WriteString('--' + Boundary +'--');
    SS.WriteString(#$D#$A);
    var Res := TStringStream.Create('', TEncoding.ASCII);
    Result := (qBCom('POST', '/torrents/add', SS, Res, Format('multipart/form-data; boundary=%s', [Boundary])) = 200) and (Res.DataString = 'Ok.');
    Res.Free;
  finally
    SS.Free;
  end;
end;

function TqBitAPI.AddNewTorrentFile(NewTorrentFile: TqBitNewTorrentFileType): boolean;
var
  GUID: TGUID;
  Boundary: string;
  SS :TStringStream;
begin
  SS := TStringStream.Create('', TEncoding.ASCII);
  try
    CreateGUID(GUID);
    Boundary := '----' +
                Format(
                   '%0.8X%0.4X%0.4X%0.2X%0.2X%0.2X%0.2X%0.2X%0.2X%0.2X%0.2X',
                   [GUID.D1, GUID.D2, GUID.D3,
                   GUID.D4[0], GUID.D4[1], GUID.D4[2], GUID.D4[3],
                   GUID.D4[4], GUID.D4[5], GUID.D4[6], GUID.D4[7]]
                );
    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString(Format('Content-Disposition: form-data; name="fileselect[]"; filename="%s"', [ ExtractFileName(NewTorrentFile.filename.ToString) ]));
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Type: application/x-bittorrent');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    var FileStream := TFileStream.Create(NewTorrentFile.filename.AsString, fmOpenRead or fmShareDenyWrite);
    SS.CopyFrom(FileStream, FileStream.Size);
    FileStream.Free;

    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="autoTMM"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    SS.WriteString(cBoolToStr[NewTorrentFile.autoTMM.AsBoolean]);
    SS.WriteString(#$D#$A);

    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="savepath"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    SS.WriteString(NewTorrentFile.savepath.AsString);
    SS.WriteString(#$D#$A);

    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="rename"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    SS.WriteString(NewTorrentFile.rename.AsString);
    SS.WriteString(#$D#$A);

    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="category"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    SS.WriteString(NewTorrentFile.category.AsString);
    SS.WriteString(#$D#$A);

    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="stopped"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    SS.WriteString(cBoolToStr[NewTorrentFile.stopped.AsBoolean]);
    SS.WriteString(#$D#$A);

    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="addToTopOfQueue"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    SS.WriteString(cBoolToStr[NewTorrentFile.addToTopOfQueue.AsBoolean]);
    SS.WriteString(#$D#$A);

    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="stopCondition"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    SS.WriteString(NewTorrentFile.stopCondition.AsString);
    SS.WriteString(#$D#$A);

    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="skip_checking"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    SS.WriteString(cBoolToStr[NewTorrentFile.skip_Checking.AsBoolean]);
    SS.WriteString(#$D#$A);

    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="contentLayout"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    SS.WriteString((NewTorrentFile.contentLayout.AsString));
    SS.WriteString(#$D#$A);

    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="sequentialDownload"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    SS.WriteString(cBoolToStr[NewTorrentFile.sequentialDownload.AsBoolean]);
    SS.WriteString(#$D#$A);

    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="firstLastPiecePrio"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    SS.WriteString(cBoolToStr[NewTorrentFile.firstLastPiecePrio.AsBoolean]);
    SS.WriteString(#$D#$A);

    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="dlLimit"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    if NewTorrentFile.dlLimit.AsInteger < 0 then SS.WriteString('NaN') else SS.WriteString(NewTorrentFile.dlLimit.AsInteger.ToString);
    SS.WriteString(#$D#$A);

    SS.WriteString('--' + Boundary);
    SS.WriteString(#$D#$A);
    SS.WriteString('Content-Disposition: form-data; name="upLimit"');
    SS.WriteString(#$D#$A);
    SS.WriteString('');
    SS.WriteString(#$D#$A);
    if NewTorrentFile.upLimit.AsInteger < 0 then SS.WriteString('NaN') else SS.WriteString(NewTorrentFile.upLimit.AsInteger.ToString);
    SS.WriteString(#$D#$A);

    SS.WriteString('--' + Boundary+'--');
    SS.WriteString(#$D#$A);
    var Res := TStringStream.Create('', TEncoding.ASCII);
    Result := (qBCom('post', '/torrents/add', SS, Res, Format('multipart/form-data; boundary=%s', [Boundary])) = 200) and (Res.DataString = 'Ok.');
    Res.Free;
  finally
    SS.Free;
  end;
end;

function TqBitAPI.AddTrackersToTorrent(Hash, Urls: string): boolean;
begin
  var Body := Format('hash=%s&urls=%s', [Hash, URLEncodeDelimStr(Urls, #$A)]);
  Result := qBPost('/torrents/addTrackers', Body) = 200;
end;

function TqBitAPI.EditTracker(Hash, OrigUrl, NewUrl: string): boolean;
begin
  var Body := Format('hash=%s&origUrl=%s&newUrl=%s',[Hash, URLEncode(OrigUrl), URLEncode(NewUrl)]);
  Result := qBPost('/torrents/editTracker', Body) = 200;
end;

function TqBitAPI.RemoveTrackers(Hash, Urls: string): boolean;
begin
  var Body := Format('hash=%s&urls=%s', [Hash, URLEncodeDelimStr(Urls, '|')]);
  Result := qBPost('/torrents/removeTrackers', Body) = 200;
end;

function TqBitAPI.AddPeers(Hashes, Peers: string): boolean;
begin
  var Body := Format('hashes=%s&peers=%s', [Hashes, URLEncodeDelimStr(Peers, '|')]);
  Result := qBPost('/torrents/addPeers', Body) = 200;
end;

function TqBitAPI.IncreaseTorrentPriority(Hashes: string): boolean;
begin
  var Body := Format('hashes=%s', [Hashes]);
  Result := qBPost('/torrents/increasePrio', Body) = 200;
end;

function TqBitAPI.DecreaseTorrentPriority(Hashes: string): boolean;
begin
  var Body := Format('hashes=%s', [Hashes]);
  Result := qBPost('/torrents/decreasePrio', Body) = 200;
end;

function TqBitAPI.MaximalTorrentPriority(Hashes: string): boolean;
begin
  var Body := Format('hashes=%s', [Hashes]);
  Result := qBPost('/torrents/topPrio', Body) = 200;
  end;

function TqBitAPI.MinimalTorrentPriority(Hashes: string): boolean;
begin
  var Body := Format('hashes=%s', [Hashes]);
  Result := qBPost('/torrents/bottomPrio', Body) = 200;
end;

function TqBitAPI.SetFilePriority(Hash, Ids: string; Priority: integer): boolean;
begin
  var Body := Format('hash=%s&id=%s&priority=%d', [Hash, URLEncodeDelimStr(Ids, '|'), Priority]);
  Result := qBPost('/torrents/filePrio', Body) = 200;
end;

function TqBitAPI.GetTorrentDownloadLimit(Hashes: string): TqBitTorrentSpeedsLimitType;
begin
  Result := nil;
  var Body :=  Format('hashes=%s', [Hashes]);
  if (qBPost('/torrents/downloadLimit', Body) = 200) and (Body <> '')  then
    Result := TJX4Object.FromJSON<TqBitTorrentSpeedsLimitType>('{"speeds":' + Body + '}', []);
end;

function TqBitAPI.SetTorrentDownloadLimit(Hashes: string;  Limit: integer): boolean;
begin
  var Body := Format('hashes=%s&limit=%d', [Hashes, Limit]);
  Result := qBPost('/torrents/setDownloadLimit', Body) = 200;
end;

function TqBitAPI.SetTorrentShareLimit(Hashes: string; RatioLimit: double; SeedingTimeLimit: integer): boolean;
begin
  var Body := Format('hashes=%s&ratioLimit=%0.2f&seedingTimeLimit=%d', [Hashes, RatioLimit, SeedingTimeLimit]);
  Result := qBPost('/torrents/setShareLimits', Body) = 200;
end;

function TqBitAPI.GetTorrentUploadLimit(Hashes: string): TqBitTorrentSpeedsLimitType;
begin
  Result := nil;
  var Body :=   Format('hashes=%s', [Hashes]);
  if (qBPost('/torrents/uploadLimit', Body) = 200) and (Body <> '')  then
    Result := TJX4Object.FromJSON<TqBitTorrentSpeedsLimitType>('{"speeds":' + Body + '}', []);
end;

function TqBitAPI.SetTorrentUploadLimit(Hashes: string;  Limit: integer): boolean;
begin
  var Body := Format('hashes=%s&limit=%d', [Hashes, Limit]);
  Result := qBPost('/torrents/setUploadLimit', Body) = 200;
end;

function TqBitAPI.SetTorrentLocation(Hashes, Location: string): boolean;
begin
  var Body := Format('hashes=%s&location=%s', [Hashes, URLEncode(Location)]);
  Result := qBPost('/torrents/setLocation', Body) = 200;
end;

function TqBitAPI.SetTorrentName(Hash, Name: string): boolean;
begin
  var Body := Format('hash=%s&name=%s', [Hash, URLEncode(Name)]);
  Result := qBPost('/torrents/rename', Body) = 200;
end;

function TqBitAPI.SetTorrentCategory(Hashes, Category: string): boolean;
begin
  var Body := Format('hashes=%s&category=%s', [Hashes, URLEncode(Category)]);
  Result := qBPost('/torrents/setCategory', Body) = 200;
end;

function TqBitAPI.GetAllCategories: TqBitCategoriesType;
begin
  Result := nil;
  var Body :=   '';
  if (qBGet('/torrents/categories', Body) = 200) and (Body <> '')  then
    Result := TJX4Object.FromJSON<TqBitCategoriesType>('{"categories":' + Body + '}', []);
end;

function TqBitAPI.AddNewCategory(Category, SavePath: string): boolean;
begin
  var Body := Format('category=%s&savePath=%s', [URLEncode(Category), URLEncode(SavePath)]);
  Result := qBPost('/torrents/createCategory', Body) = 200;;
end;

function TqBitAPI.EditCategory(Category, SavePath: string): boolean;
begin
  var Body := Format('category=%s&savePath=%s', [URLEncode(Category), URLEncode(SavePath)]);
  Result := qBPost('/torrents/editCategory', Body) = 200;
end;

function TqBitAPI.RemoveCategories(Categories: string): boolean;
begin
  var Body := Format('categories=%s', [URLEncodeDelimStr(Categories, #$A)]);
  Result := qBPost('/torrents/removeCategories', Body) = 200;
end;

function TqBitAPI.AddTorrentTags(Hashes, Tags: string): boolean;
begin
  var Body := Format('hashes=%s&tags=%s', [Hashes, URLEncodeDelimStr(Tags, '|')]);
  Result := qBPost('/torrents/addTags', Body) = 200;
end;

function TqBitAPI.RemoveTorrentTags(Hashes, Tags: string): boolean;
begin
  var Body := Format('hashes=%s&tags=%s', [Hashes, URLEncodeDelimStr(Tags, '|')]);
  Result := qBPost('/torrents/removeTags', Body) = 200;
end;

function TqBitAPI.GetAllTags: TqBitTagsType;
begin
  Result := nil;
  var Body :=   '';
  if (qBGet('/torrents/tags', Body) = 200) and (Body <> '')  then
    Result := TJX4Object.FromJSON<TqBitTagsType>('{"tags":' + Body + '}', []);
end;

function TqBitAPI.CreateTags(Tags: string): boolean;
begin
  var Body := Format('tags=%s', [URLEncodeDelimStr(Tags, ',')]);
  Result := qBPost('/torrents/createTags', Body) = 200;
end;

function TqBitAPI.DeleteTags(Tags: string): boolean;
begin
  var Body := Format('tags=%s', [URLEncodeDelimStr(Tags, ',')]);
  Result := qBPost('/torrents/deleteTags', Body) = 200;
end;

function TqBitAPI.SetAutomaticTorrentManagement(Hashes: string; Enable: boolean): boolean;
begin
  var Body := Format('hashes=%s&enable=%s', [Hashes, cBoolToStr[Enable]]);
  Result := qBPost('/torrents/setAutoManagement', Body) = 200;
end;

function TqBitAPI.ToggleSequentialDownload(Hashes: string): boolean;
begin
  var Body := Format('hashes=%s', [Hashes]);
  Result := qBPost('/torrents/toggleSequentialDownload', Body) = 200;
end;

function TqBitAPI.SetFirstLastPiecePriority(Hashes: string): boolean;
begin
  var Body := Format('hashes=%s', [Hashes]);
  Result := qBPost('/torrents/toggleFirstLastPiecePrio', Body) = 200;
end;

function TqBitAPI.SetForceStart(Hashes: string; value: boolean): boolean;
begin
  var Body := Format('hashes=%s&value=%s', [Hashes, cBoolToStr[Value]]);
  Result := qBPost('/torrents/setForceStart', Body) = 200;
end;

function TqBitAPI.SetSuperSeeding(Hashes: string; value: boolean): boolean;
begin
  var Body := Format('hashes=%s&value=%s', [Hashes, cBoolToStr[Value]]);
  Result := qBPost('/torrents/setSuperSeeding', Body) = 200;
end;

function TqBitAPI.RenameFile(Hash, OldPath, NewPath: string): boolean;
begin
  var Body := Format('hash=%s&oldPath=%s&newPath=%s', [Hash, URLEncode(OldPath), URLEncode(NewPath)]);
  Result := qBPost('/torrents/renameFile', Body) = 200;
end;

function TqBitAPI.RenameFolder(Hash, OldPath, NewPath: string): boolean;
begin
  var Body := Format('hash=%s&origUrl=%s&newUrl=%s', [Hash, URLEncode(OldPath), URLEncode(NewPath)]);
  Result := qBPost('/torrents/renameFolder', Body) = 200;
end;

function TqBitAPI.RSSAddFolder(Path: string): boolean;
begin
  var Body := Format('path=%s', [URLEncode(Path)]);
  Result := qBPost('/rss/addFolder', Body) = 200;
end;

function TqBitAPI.RSSAddFeed(Url, Path: string): boolean;
begin
  var Body := Format('url=%s&path=%s', [URLEncode(Url), URLEncode(Path)]);
  Result := qBPost('/rss/addFeed', Body) = 200;
end;

function TqBitAPI.RSSRemoveItem(Path: string): boolean;
begin
  var Body := Format('path=%s', [URLEncode(Path)]);
  Result := qBPost('/rss/removeItem', Body) = 200;
end;

function TqBitAPI.RSSMoveItem(ItemPath, DestPath: string): boolean;
begin
  var Body := Format('itemPath=%s&destPath=%s', [URLEncode(ItemPath), URLEncode(DestPath)]);
  Result := qBPost('/rss/moveItem', Body) = 200;
end;

function TqBitAPI.RSSGetAllItems(WithData: boolean): TqBitRSSAllItemsType;
begin
  Result := nil;
  var Body :=   Format('withData=%s', [URLEncode(cBoolToStr[WithData])]);
  if (qBPost('/rss/items', Body) = 200) and (Body <> '')  then
    Result := TJX4Object.FromJSON<TqBitRSSAllItemsType>('{"items":' + Body + '}', []);
end;

function TqBitAPI.RSSMarkAsRead(ItemPath, ArticleId: string): boolean;
begin
  var Body := Format('itemPath=%s&articleId=%s', [URLEncode(ItemPath), URLEncode(ArticleId)]);
  Result := qBPost('/rss/markAsRead', Body) = 200;
end;

function TqBitAPI.RSSRefreshItem(ItemPath: string): boolean;
begin
  var Body := Format('itemPath=%s', [URLEncode(ItemPath)]);
  Result := qBPost('/rss/refreshItem', Body) = 200;
end;

function TqBitAPI.RSSSetAutoDownloadingRules(RuleName: string;
  RuleDef: TqBitRSSRuleType): boolean;
begin
  var Body := Format('ruleName=%s&ruleDef={}', [URLEncode(RuleName)]);
  if assigned(RuleDef) then
    Body :=  Format('ruleName=%s&ruleDef=%s', [URLEncode(RuleName), URLEncode(RuleDef.ToJSON)]);
  Result := qBPost('/rss/setRule', Body) = 200;
end;

function TqBitAPI.RSSRenameAutoDownloadingRules(RuleName, NewRuleName: string): boolean;
begin
  var Body := Format('ruleName=%s&newRuleName=%s', [URLEncode(RuleName), URLEncode(NewRuleName)]);
  Result := qBPost('/rss/renameRule', Body) = 200;
end;

function TqBitAPI.RSSRemoveAutoDownloadingRules(RuleName: string): boolean;
begin
  var Body := Format('ruleName=%s', [URLEncode(RuleName)]);
  Result := qBPost('/rss/removeRule', Body) = 200;
end;

function TqBitAPI.RSSGetAllAutoDownloadingRules: TqBitAutoDownloadingRulesType;
begin
  Result := nil;
  var Body := '';
  if (qBPost('/rss/rules', Body) = 200) and (Body <> '')  then
    Result := TJX4Object.FromJSON<TqBitAutoDownloadingRulesType>('{"rules":' + Body + '}', []);
end;

function TqBitAPI.RSSGetMatchingArticles(RuleName: string): TqBitRSSArticlesType;
begin
  Result := nil;
  var Body := Format('ruleName=%s', [URLEncode(RuleName)]);
  if (qBPost('/rss/matchingArticles', Body) = 200) and (Body <> '')  then
    Result := TJX4Object.FromJSON<TqBitRSSArticlesType>('{"articles":' + Body + '}', []);
end;

end.
