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

unit uTorrentFileReader;

interface

uses
  System.Classes, System.Generics.Collections, System.Generics.Defaults,
  DateUtils, SysUtils;

const
  TORRENTREADER_PATH_SEPARATOR = '\';

type
  TBEncoded = class;

  TBEncodedFormat = (befEmpty, befString, befInteger, befList, befDictionary);

  TBEncodedData = class(TObject)
  public
    Data: TBEncoded;
    Header: AnsiString;
    constructor Create(Data: TBEncoded);
    destructor Destroy; override;
  end;

  TBEncodedDataList = class(TObjectList<TBEncodedData>)
    function FindElement(Header: AnsiString): TBEncoded;
  end;

  TBEncoded = class(TObject)
  private
    FBufferEndPtr: NativeUInt;
    FBufferStartPtr: NativeUInt;
    FFormat: TBEncodedFormat;
  public
    IntegerData: Int64;
    ListData: TBEncodedDataList;
    StringData: AnsiString;
    class procedure Encode(Encoded: TBEncoded; Output: TStringBuilder);
    constructor Create(var BufferPtr: PAnsiChar; BufferEndPtr: PAnsiChar); overload;
    constructor Create; overload;
    destructor Destroy; override;
    property Format: TBEncodedFormat read FFormat write FFormat;
    property BufferStartPtr: NativeUInt read FBufferStartPtr;
    property BufferEndPtr: NativeUInt read FBufferEndPtr;
  end; 
  
  TTorrentFileOptions = set of (
    trRaiseException,     // Will raise Exception on error (Default), silent otherwise will return nil on error
    trNoHash,             // Do Not Calculate Hashes (Default is False)
    trNoPiece             // Do not return torrent pieces/PieceLayers (Default is false)
  );

  TFileData = class(TObject)
    FullPath: string;
    Length: Int64;
    PathList: TStringList;
    PiecesRoot: AnsiString; // V2 Only
    PiecesCount: Int64; // V2 Only
    constructor Create; overload;
    destructor Destroy; override;
  end;

  TTorrentDataInfo = class(TObject)
    FileList: TObjectList<TFileData>;
    FilesSize: Int64;
    HasMultipleFiles: Boolean;
    IsHybrid: Boolean;
    IsPrivate: Boolean;
    Length: Int64;
    MetaVersion: Int64;
    Name: string;
    Pieces: AnsiString; // V1 Only
    PiecesCount: Int64; // V1 Only;
    PieceLength: Int64;
    constructor Create; overload;
    destructor Destroy; override;
  end;

  TTTorrentFileData = class(TObject)
  public
    Announce: string;
    AnnouncesDict : TDictionary<Integer, TStringList>;
    Comment: TStringList;
    CreatedBy: string;
    CreationDate: TDateTime;
    HashV1: string;
    HashV2: string;
    Info: TTorrentDataInfo;
    NiceName: string; // Helper
    PieceLayers: TStringList; // V2 Only
    KeyHash: string; // Helper
    WebSeeds: TStringList;
    constructor Create; overload;
    destructor Destroy; override;
  end;

  TTorrentFile = class(TObject)
  private
    FBe: TBEncoded;
    FData: TTTorrentFileData;
    FProcessingTimeMS: UInt64;
    function GetSHA1(Enc: TBEncoded): string;
    function GetSHA2(Enc: TBEncoded): string;
    procedure Parse(Be: TBEncoded; Options: TTorrentFileOptions);
  public
    class function FromBufferPtr(BufferPtr, BufferEndPtr: PAnsiChar; Options: TTorrentFileOptions = [trRaiseException]): TTorrentFile;
    class function FromMemoryStream(MemStream: TMemoryStream; Options: TTorrentFileOptions = [trRaiseException]): TTorrentFile;
    class function FromFile(Filename: string; Options: TTorrentFileOptions = [trRaiseException]): TTorrentFile;
    class function FromAnsiString(var AnsiStr: AnsiString; Options: TTorrentFileOptions = [trRaiseException]): TTorrentFile;

    constructor Create; overload;
    destructor Destroy; override;
    property BEncoded: TBEncoded read FBe;
    property Data: TTTorrentFileData read FData;
    property ProcessingTimeMS: UInt64 read FProcessingTimeMS;
  end;

implementation
uses
  System.Diagnostics
{$IFDEF MSWINDOWS}
  , Windows
{$ELSE}
  , System.Types
  , System.Hash
{$ENDIF}
  ;
{$IFDEF MSWINDOWS}
function CryptAcquireContextA(var phProv: ULONG_PTR; pszContainer: LPCSTR; pszProvider: LPCSTR; dwProvType: DWORD; dwFlags: DWORD): BOOL; stdcall;
  external 'advapi32.dll' Name 'CryptAcquireContextA';
function CryptReleaseContext(hProv: ULONG_PTR; dwFlags: ULONG_PTR): BOOL; stdcall;
  external 'advapi32.dll' Name 'CryptReleaseContext';
function CryptCreateHash(hProv: ULONG_PTR; Algid: DWORD; hKey: ULONG_PTR; dwFlags: DWORD; var phHash: ULONG_PTR): BOOL; stdcall;
  external 'advapi32.dll' Name 'CryptCreateHash';
function CryptGetHashParam(hHash: ULONG_PTR; dwParam: DWORD; pbData: LPBYTE; var pdwDataLen: DWORD; dwFlags: DWORD): BOOL; stdcall;
  external 'advapi32.dll' Name 'CryptGetHashParam';
function CryptHashData(hHash: ULONG_PTR; pbData: LPBYTE; dwDataLen, dwFlags: DWORD): BOOL; stdcall;
  external 'advapi32.dll' Name 'CryptHashData';
function CryptDeriveKey(hProv: ULONG_PTR; Algid: DWORD; hBaseData: ULONG_PTR; dwFlags: DWORD; var phKey: ULONG_PTR): BOOL;
  external 'advapi32.dll' Name 'CryptDeriveKey';
function CryptDestroyHash(hHash: ULONG_PTR): BOOL; stdcall;
  external 'advapi32.dll' Name 'CryptDestroyHash';
function CryptDestroyKey(hKey: ULONG_PTR): BOOL; stdcall;
  external 'advapi32.dll' Name 'CryptDestroyKey';

// AlgoID : SHA1 = $8004, SHA2-256 = $800C
function WinCryptSHA(AlgoID: DWORD; Buffer: Pointer; Size: DWORD): AnsiString;
var
  phProv: ULONG_PTR ;
  phHash: ULONG_PTR ;
  ByteBuffer: Array[0..31] of Byte;
  Len: DWORD;
begin
  phProv := 0; phHash := 0;
  try
    if not CryptAcquireContextA(phProv, nil, nil, 24, DWORD($F0000000)) then exit;
    if not CryptCreateHash(phProv, AlgoID, 0, 0, phHash) then exit;
    if not CryptHashData(phHash, LPBYTE(Buffer), Size,0) then exit;
    Len := Length(ByteBuffer);
    if not CryptGetHashParam(phHash, 2, @ByteBuffer, Len, 0) then exit;
    SetLength(Result, Len * 2);
    BinToHex(@ByteBuffer, PAnsiChar(@Result[1]), Len);
  finally
    if phHash <> 0 then CryptReleaseContext(phProv, 0);
    if phProv <> 0 then CryptDestroyHash(phHash);
  end;
end;
{$ENDIF}

destructor TBEncodedData.Destroy;
begin
  Data.Free;
  inherited Destroy;
end;

constructor TBEncodedData.Create(Data: TBEncoded);
begin
  inherited Create;
  Self.Data := Data;
end;

{ TBEncoded }

constructor TBEncoded.Create;
begin
  inherited Create;
end;

destructor TBEncoded.Destroy;
begin
  ListData.Free;
  inherited Destroy;
end;

procedure IncPtrCheck(var BufferPtr, BufferEndPtr: PAnsiChar); inline;
begin
  if BufferPtr + 1 > BufferEndPtr then
    raise Exception.Create('IncPtrCheck: Erroneous Pointer');
  Inc(BufferPtr);
end;

constructor TBEncoded.Create(var BufferPtr: PAnsiChar; BufferEndPtr: PAnsiChar);

  procedure DecodeString(var AnsiStr: AnsiString);
  var
    Len: NativeUInt;
  begin
    Len := PByte(BufferPtr)^ - 48;
    repeat
      IncPtrCheck(BufferPtr, BufferEndPtr);
      if BufferPtr^ = ':' then
      begin
        if BufferPtr + (Len + 1) > BufferEndPtr then
           raise Exception.Create('TBEncoded/DecodeString: Erroneous Pointer');
        Inc(BufferPtr);
        SetLength(AnsiStr, Len);
        if Len > 0 then Move(BufferPtr^, AnsiStr[1], Len);
        Inc(BufferPtr, Len);
        Break;
      end
      else
      begin
        if not (BufferPtr^ in ['0'..'9']) then
          raise Exception.Create('TBEncoded/DecodeString: Erroneous Value');
        Len := (Len * 10) + PByte(BufferPtr)^ - 48;
      end;
    until False;
  end;

  procedure DecodeInt64(var IntValue: Int64);
  begin
    IntValue := 0;
    while (BufferPtr^ <> 'e') do
    begin
      if not (BufferPtr^ in ['0'..'9']) then
        raise Exception.Create('TBEncoded/DecodeInt64: Erroneous Value');
      if BufferPtr^= '-' then
        IntValue := IntValue * -1
      else
        IntValue := (IntValue * 10) +  (PByte(BufferPtr)^ - 48);
      IncPtrCheck(BufferPtr, BufferEndPtr);
    end;
    IncPtrCheck(BufferPtr, BufferEndPtr);
  end;

var
  Header: AnsiString;
  Data: TBEncodedData;

begin
  inherited Create;
  FBufferStartPtr := NativeUInt(BufferPtr);

  case BufferPtr^ of
  'd':
    begin
      FFormat := befDictionary;
      ListData := TBEncodedDataList.Create;
      IncPtrCheck(BufferPtr, BufferEndPtr);
      repeat
        if BufferPtr^ = 'e' then begin Inc(BufferPtr); Break; end;
        DecodeString(Header);
        Data := TBEncodedData.Create(TBEncoded.Create(BufferPtr, BufferEndPtr));
        Data.Header := Header;
        ListData.Add(Data);
      until False;
    end;
  'l':
    begin
      FFormat := befList;
      ListData := TBEncodedDataList.Create;
      IncPtrCheck(BufferPtr, BufferEndPtr);
      repeat
        if BufferPtr^ = 'e' then begin IncPtrCheck(BufferPtr, BufferEndPtr); Break; end;
        ListData.Add(TBEncodedData.Create(TBEncoded.Create(BufferPtr, BufferEndPtr)));
      until False;
    end;
  'i':
    begin
      FFormat := befInteger;
      IncPtrCheck(BufferPtr, BufferEndPtr);
      DecodeInt64(IntegerData);
    end;
  else
    FFormat := befString;
    DecodeString(StringData);
  end;

  FBufferEndPtr := NativeUInt(BufferPtr);
end;

class procedure TBEncoded.Encode(Encoded: TBEncoded; Output: TStringBuilder);
begin
  with Encoded do
  begin
    case Format of
      befString:
          Output.Append(Length(StringData)).Append(':').Append(StringData);
      befInteger:
          Output.Append('i').Append(IntegerData).Append('e');
      befList:
        begin
          Output.Append('l');
          for var i := 0 to ListData.Count - 1 do
            Encode(TBEncoded(ListData[i].Data), Output);
          Output.Append('e');
        end;
      befDictionary:
        begin
          Output.Append( 'd');
          for var i := 0 to ListData.Count - 1 do
          begin
            Output.Append(Length(ListData[i].Header)).Append(':').Append(ListData[i].Header);
            Encode(TBEncoded(ListData[i].Data), Output);
          end;
          Output.Append( 'e');
        end;
    end;
  end;
end;

{ TBEncodedDataList }

function TBEncodedDataList.FindElement(Header: AnsiString): TBEncoded;
begin
  for var Item in Self do
    if Item.Header = Header then
    begin
      Result := Item.Data;
      exit;
    end;
  Result := nil;
end;

{ TTTorrentFileData }

constructor TTTorrentFileData.Create;
begin
  inherited;
  Info := TTorrentDataInfo.Create;
  AnnouncesDict := TDictionary<Integer, TStringList>.Create;
  PieceLayers := TStringList.Create;
  WebSeeds := TStringList.Create;
  Comment := TStringList.Create;
  Comment.QuoteChar := #0;
  Comment.StrictDelimiter := True;
  Comment.Delimiter := #$A;
end;

destructor TTTorrentFileData.Destroy;
begin
  PieceLayers.Free;
  Comment.Free;
  WebSeeds.Free;
  for var Tier in AnnouncesDict do Tier.Value.Free;
  AnnouncesDict.Free;
  Info.Free;
  inherited;
end;

{ TTorrentFile }

constructor TTorrentFile.Create;
begin
  inherited;
  FBe := nil;
  FData := TTTorrentFileData.Create;
  FProcessingTimeMS := 0;
end;

destructor TTorrentFile.Destroy;
begin
  FBe.Free;
  FData.Free;
  inherited;
end;

function TTorrentFile.GetSHA1(Enc: TBEncoded): string;
begin
{$IFDEF MSWINDOWS}
  Result := LowerCase(string(WinCryptSHA($8004, Pointer(Enc.BufferStartPtr), Enc.BufferEndPtr - Enc.BufferStartPtr)));
{$ELSE}
  var SHA := THashSHA1.Create;
  SHA.Update( PByte(Enc.BufferStartPtr)^ , Enc.BufferEndPtr - Enc.BufferStartPtr);
  Result := SHA.HashAsString;
{$ENDIF}
end;

function TTorrentFile.GetSHA2(Enc: TBEncoded): string;
begin
{$IFDEF MSWINDOWS}
  Result := LowerCase(string(WinCryptSHA($800C, Pointer(Enc.BufferStartPtr), Enc.BufferEndPtr - Enc.BufferStartPtr)));
{$ELSE}
  var SHA := THashSHA2.Create;
  SHA.Update( PByte(Enc.BufferStartPtr)^ , Enc.BufferEndPtr - Enc.BufferStartPtr);
  Result := SHA.HashAsString;
{$ENDIF}
end;

class function TTorrentFile.FromBufferPtr(BufferPtr, BufferEndPtr: PAnsiChar; Options: TTorrentFileOptions = [trRaiseException]): TTorrentFile;
begin
  Result := nil;
  try
    Result := TTorrentFile.Create;
    var Sw := TStopWatch.StartNew;
    Result.FBe := TBEncoded.Create(BufferPtr, BufferEndPtr);
    Result.Parse(Result.FBe, Options);
    Result.FProcessingTimeMS := Sw.ElapsedMilliseconds;
  except
    on E : Exception do
    begin
      FreeAndNil(Result);
      if trRaiseException in Options then raise;
    end;
  end;
end;

class function TTorrentFile.FromMemoryStream(MemStream: TMemoryStream; Options: TTorrentFileOptions = [trRaiseException]): TTorrentFile;
begin
  var BufferPtr := PAnsiChar(MemStream.Memory);
  Var EndPosPtr := PAnsiChar(NativeUInt(MemStream.Memory) + NativeUInt(MemStream.Size));
  Result := FromBufferPtr(BufferPtr, EndPosPtr, Options);
end;

class function TTorrentFile.FromFile(Filename: string; Options: TTorrentFileOptions = [trRaiseException]): TTorrentFile;
var
  MemStream: TMemoryStream;
begin
  MemStream := nil;
  try
    MemStream := TMemoryStream.Create;
    MemStream.LoadFromFile(Filename);
    Result := FromMemoryStream(MemStream, Options);
  finally
    MemStream.Free;
  end;
end;

class function TTorrentFile.FromAnsiString(var AnsiStr: AnsiString; Options: TTorrentFileOptions = [trRaiseException]): TTorrentFile;
begin
  Result := FromBufferPtr(@AnsiStr[1], PAnsiChar( NativeUInt(@AnsiStr[1]) + NativeUInt(Length(AnsiStr)) ), Options);
end;

procedure TTorrentFile.Parse(Be: TBEncoded; Options: TTorrentFileOptions);

  procedure ParseFileListV2(Dic: TBEncoded; const Path: string; FileData: TFileData);
  begin
    if not assigned(Dic.ListData) then exit;
    for var i := 0 to Dic.ListData.Count - 1 do
    begin
      var TmpDic := Dic.ListData.Items[i];
      if (TmpDic.Header = '') and (TmpDic.Data.StringData = '') then
      begin
        FileData := TFileData.Create;
        FData.Info.FileList.Add(FileData);
        FileData.FullPath := Path;
        FileData.PathList.Delimiter := TORRENTREADER_PATH_SEPARATOR;
        FileData.PathList.StrictDelimiter := True;
        FileData.PathList.DelimitedText := string(Path);
      end
      else if assigned(FileData) then
      begin
        if TmpDic.Header = 'length' then FileData.Length :=  TmpDic.Data.IntegerData;
        if TmpDic.Header = 'pieces root' then
        begin
          FileData.PiecesRoot := TmpDic.Data.StringData;
          FileData.PiecesCount := Length(TmpDic.Data.StringData) div 32;
        end;
      end;
      if assigned(TmpDic.data.ListData) then
        if Path <> '' then
          ParseFileListV2(TmpDic.Data, Path + TORRENTREADER_PATH_SEPARATOR + UTF8ToString(TmpDic.Header),  FileData)
        else
          ParseFileListV2(TmpDic.Data, UTF8ToString(TmpDic.Header),  FileData);
    end;
  end;

var
  Enc, Info: TBEncoded;
  EncStr: string;
  SList: TStringList;

begin
  Info := Be.ListData.FindElement('info'); //Helper;
  try
    //MetaVersion
    FData.Info.MetaVersion := 1;
    Enc := Info.ListData.FindElement('meta version');
    if assigned(Enc) then FData.Info.MetaVersion:= Enc.IntegerData;

    //IsHybrid
    FData.Info.IsHybrid :=  (Be.ListData.FindElement('piece layers') <> nil)
                            and (Info.ListData.FindElement('pieces') <> nil);

    //Announce
    Enc := Be.ListData.FindElement('announce');
    if assigned(Enc) then FData.Announce := UTF8ToString(Enc.StringData);

    // AnnounceList : http://bittorrent.org/beps/bep_0012.html
    var AnnounceList := Be.ListData.FindElement('announce-list') as TBEncoded;
    if assigned(AnnounceList) then
    begin
      for var SubA := 0 to AnnounceList.ListData.Count - 1 do
        case AnnounceList.ListData[SubA].Data.Format of
          befList: // Multi Tiers
            begin
              if not FData.AnnouncesDict.TryGetValue( FData.AnnouncesDict.Count , SList) then
              begin
                SList := TStringList.Create;
                FData.AnnouncesDict.Add(FData.AnnouncesDict.Count, SList);
              end;
              for var SubL := 0 to  AnnounceList.ListData[SubA].Data.ListData.Count - 1 do
                SList.AddObject(UTF8ToString(AnnounceList.ListData[SubA].Data.ListData[SubL].Data.StringData), Pointer(FData.AnnouncesDict.Count - 1));
            end;
          befString: // Single Tier
            begin
              if not FData.AnnouncesDict.TryGetValue( 0, SList) then
              begin
                SList := TStringList.Create;
                FData.AnnouncesDict.Add(0, SList);
              end;
              SList.AddObject(UTF8ToString((AnnounceList.ListData[SubA].Data).StringData), Pointer(0));
            end;
        end;
    end;

    // Comment
    Enc := Be.ListData.FindElement('comment');
    if assigned(Enc) then FData.Comment.DelimitedText := UTF8ToString(Enc.StringData);

    // CreatedBy
    Enc := Be.ListData.FindElement('created by');
    if assigned(Enc) then FData.CreatedBy := UTF8ToString(Enc.StringData);

    // CreationDate
    Enc := Be.ListData.FindElement('creation date');
    if assigned(Enc) then FData.CreationDate := TTimeZone.Local.ToLocalTime(UnixToDateTime(Enc.IntegerData));

    // Hashes
    if ((FData.Info.MetaVersion = 1) or FData.Info.IsHybrid) and (not (trNoHash in Options)) then
    begin
      FData.HashV1 := GetSHA1(Info);
      FData.KeyHash := FData.HashV1;
    end;
    if ((FData.Info.MetaVersion = 2) or FData.Info.IsHybrid) and (not (trNoHash in Options)) then
    begin
      FData.HashV2 := GetSHA2(Info);
      FData.KeyHash := Copy(FData.HashV2, 1, 40);
    end;

    // Name:
    Enc := Info.ListData.FindElement('name') as TBEncoded;
    if assigned(Enc) then FData.Info.Name := UTF8ToString(Enc.StringData);

    // Length:
    Enc := Info.ListData.FindElement('length') as TBEncoded;
    if assigned(Enc) then FData.Info.Length := Enc.IntegerData;

    // PieceLength:
    Enc := Info.ListData.FindElement('piece length') as TBEncoded;
    if assigned(Enc) then FData.Info.PieceLength := Enc.IntegerData;

    // Pieces:
    Enc := Info.ListData.FindElement('pieces') as TBEncoded;
    if assigned(Enc) and (not (trNoPiece in Options)) then
    begin
      FData.Info.Pieces := Enc.StringData;
      FData.Info.PiecesCount := Length(FData.Info.Pieces) div 20;
    end;

    //PieceLayers
    if (Be.ListData.FindElement('piece layers') <> nil) and (not (trNoPiece in Options)) then
    begin
      var PieceLayerList :=  Be.ListData.FindElement('piece layers').ListData;
      if Be.ListData.FindElement('piece layers').Format = befDictionary then
        if PieceLayerList.Count > 0 then
          for var PieceLayer in PieceLayerList do
            FData.PieceLayers.Add(String(PieceLayer.Data.StringData));
    end;

    //Private
    FData.Info.IsPrivate := False;
    Enc := Info.ListData.FindElement('private') as TBEncoded;
    if assigned(Enc) then FData.Info.IsPrivate := Enc.IntegerData = 1;

    //UrlList:
    Enc := Be.ListData.FindElement('url-list') as TBEncoded;
    if assigned(Enc) then
      if Enc.ListData = nil then
        FData.WebSeeds.Add(String(Enc.StringData))
      else
        for var i := 0 to Enc.ListData.Count - 1 do
          FData.WebSeeds.Add(UTF8ToString(Enc.ListData[i].Data.StringData));

    // files :
    if FData.Info.MetaVersion = 1 then
    begin // V1
      var FL := Info.ListData.FindElement('files');
      if FL <> nil then
      for var FileItem in FL.ListData do
      begin
        // Multiple Files/Folders
        var FileData := TFileData.Create;
        FData.Info.FileList.Add(FileData);
        var FLD := FileItem.Data;
        FileData.Length := FLD.ListData.FindElement('length').IntegerData;
        var FLDP := FLD.ListData.FindElement('path');
        for var DataItem in FLDP.ListData do
          FileData.PathList.Add(UTF8ToString(DataItem.Data.StringData));
        FileData.PathList.Delimiter := TORRENTREADER_PATH_SEPARATOR;
        FileData.PathList.QuoteChar := #0;
        FileData.PathList.StrictDelimiter := True;
        FileData.FullPath := FileData.PathList.DelimitedText;
      end else begin
        // A Single File
        var FileData := TFileData.Create;
        FData.Info.FileList.Add(FileData);
        FileData.Length := FData.Info.Length;
        FileData.FullPath := FData.Info.Name;
        FileData.PathList.Add(FData.Info.Name);
      end;
    end else // V2
      ParseFileListV2(Info.ListData.FindElement('file tree'), EncStr, nil);

    // **************** Helpers **************** //

    // HasMultipleFiles
    FData.Info.HasMultipleFiles := True;
    if FData.Info.FileList.Count = 1  then
      if  FData.Info.Name =  FData.Info.FileList[0].FullPath then
      begin
        FData.Info.Name := '';
        FData.Info.HasMultipleFiles := False;
      end;

    // FilesSize & PiecesCount
    Data.Info.FilesSize := 0;
    for var fle in Data.Info.FileList do
    begin
      Data.Info.FilesSize := Data.Info.FilesSize + fle.Length;
      if Data.Info.MetaVersion > 1 then
        Data.Info.PiecesCount := Data.Info.PiecesCount + fle.PiecesCount;
    end;

    // NiceName : Custom Helper
    if Data.Info.HasMultipleFiles then
      FData.NiceName := Data.Info.Name
    else
      FData.NiceName := Data.Info.FileList[0].FullPath;

  except
    raise Exception.Create('Invalid Torrent File');
  end;
end;

{ TTorrentDataInfo }

constructor TTorrentDataInfo.Create;
begin
  inherited;
  FileList := TObjectList<TFileData>.Create(True);
end;

destructor TTorrentDataInfo.Destroy;
begin
  FileList.Free;
  inherited;
end;

{ TFileData }

constructor TFileData.Create;
begin
  inherited;
  PathList := TStringList.Create;
end;

destructor TFileData.Destroy;
begin
  PathList.Free;
  inherited;
end;

end.
