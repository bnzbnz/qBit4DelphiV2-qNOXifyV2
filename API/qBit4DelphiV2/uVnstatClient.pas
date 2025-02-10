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


// Usage: Please Read !!!
//
// Use a server running vnstat, a webserver(nginx, lighthttpd, apache...), php
// create a php script:  <?php passthru('vnstat --json'); ?>
// TEST IT with your web browser (the passthru function may have been disbled in php.ini)
// then provide the full URL to the class function FromURL
// You'll get a TvnStatClient which contains all the stats (nil if it fails)
//

unit uVnstatClient;

interface
uses

    uJX4Object
  , uJX4List
  , RTTI
  ;

type

  TvnsDate = class(TJX4OBject)
    year: TValue; // Int64;
    month: TValue; // Int64;
    day: TValue; // Int64;
    function GetDate: TDate;
  end;

  TvnsTime = class(TJX4OBject)
    hour: TValue; // Int64;
    minute: TValue; // Int64;
    function GetTime: TTime;
  end;

  TvnsDateCtx = class(TJX4OBject)
    date: TvnsDate;
    function GetDate: TDate;
  end;

  TvnsRxTx = class(TJX4OBject)
    rx: TValue; // Int64;
    tx: TValue; // Int64;
  end;

  TvnsInfo= class(TvnsRxTx)
    id: TValue; // Int64;
    date: TvnsDate;
    time: TvnsTime;
    function GetDateTime: TDateTime;
  end;

  TvnsTraffic = class(TJX4OBject)
    total: TvnsRxTx;
    fiveminute: TJX4List<TvnsInfo>;
    hour: TJX4List<TvnsInfo>;
    day: TJX4List<TvnsInfo>;
    month: TJX4List<TvnsInfo>;
    year: TJX4List<TvnsInfo>;
    top: TJX4List<TvnsInfo>;
  end;

  TvnsInterface = class(TJX4OBject)
    name: TValue; // string;
    alias: TValue; // string;
    created: TvnsDateCtx;
    updated: TvnsDateCtx;
     traffic: TvnsTraffic;
  end;

  TvnStatClient = class(TJX4OBject)
  public
    [TJX4Excluded]
    RawJSON: string; // Custom not a json field
    vnstatversion: TValue; // string;
    jsonversion: TValue; // string;
    interfaces: TJX4List<TvnsInterface>;

    class function FromJSON(JSONStr: string): TvnStatClient;
    class function FromURL(URL: string): TvnStatClient;
    function GetInterface(NetInterface: string): TvnsInterface;
    function GetYear(Intf: string; Year: Int64): TvnsInfo;
    function GetMonth(Intf: string; Year, Month: Int64): TvnsInfo;
    function GetDay(Intf: string; Year, Month, Day: Int64): TvnsInfo;
    function GetCurrentYear(Intf: string): TvnsInfo;
    function GetCurrentMonth(Intf: string): TvnsInfo;
    function GetCurrentDay(Intf: string): TvnsInfo;
  end;

implementation
uses
    System.Net.HttpClient
  , System.SysUtils
  , System.DateUtils
  , System.Classes
  ;

{ TvnStatClient }

function TvnStatClient.GetYear(Intf: string; Year : Int64): TvnsInfo;
begin
  Result := nil;
  var Intrface := Self.GetInterface(Intf);
  if Intrface = nil then exit;
  for var i in Intrface.traffic.year do
    if (i.date.year.AsInt64 = Year) then
    begin
      Result := i;
      Break;
    end;
end;

function TvnStatClient.GetMonth(Intf: string; Year, Month: Int64): TvnsInfo;
begin
  Result := nil;
  var Intrface := Self.GetInterface(Intf);
  if Intrface = nil then exit;
  for var i in Intrface.traffic.month do
    if (i.date.year.AsInt64 = Year) and (i.date.month.AsInt64 = Month) then
    begin
      Result := i;
      Break;
    end;
end;

function TvnStatClient.GetDay(Intf: string; Year, Month, Day: Int64): TvnsInfo;
begin
  Result := nil;
  var Intrface := Self.GetInterface(Intf);
  if Intrface = nil then exit;
  for var i in Intrface.traffic.month do
    if (i.date.year.AsInt64 = Year) and (i.date.month.AsInt64 = Month) and (i.date.day.AsInt64 = Day) then
    begin
      Result := i;
      Break;
    end;
end;

function TvnStatClient.GetCurrentMonth(Intf: string): TvnsInfo;
var
  AYear, AMonth, ADay: Word;
begin
  Result := nil;
  var Intrface := Self.GetInterface(Intf);
  if Intrface = nil then exit;
  DecodeDate(Now, AYear, AMonth, ADay);
  Result := GetMonth(Intf, AYear, AMonth);
end;

function TvnStatClient.GetCurrentYear(Intf: string): TvnsInfo;
var
  AYear, AMonth, ADay: Word;
begin
  Result := nil;
  var Intrface := Self.GetInterface(Intf);
  if Intrface = nil then exit;
  DecodeDate(Now, AYear, AMonth, ADay);
  Result := GetMonth(Intf, AYear, AMonth);
end;

function TvnStatClient.GetCurrentDay(Intf: string): TvnsInfo;
var
  AYear, AMonth, ADay: Word;
begin
  Result := nil;
  var Intrface := Self.GetInterface(Intf);
  if Intrface = nil then exit;
  DecodeDate(Now, AYear, AMonth, ADay);
  Result := GetDay(Intf, AYear, AMonth, ADay);
end;

function TvnStatClient.GetInterface(NetInterface: string): TvnsInterface;
begin
  for var i in interfaces do
    if i.name.AsString = NetInterface then
    begin
      Result := i;
      Exit;
    end;
  Result := nil;
end;

class function TvnStatClient.FromJSON(JSONStr: string): TvnStatClient;
begin
  try
    Result := TJX4Object.FromJSON<TvnStatClient>(JSONStr, [joNullToEmpty]);
  except
    Result := nil;
  end;
end;

class function TvnStatClient.FromURL(URL: string): TvnStatClient;
var
  Http: THTTPClient;
  ReqSS: TStringStream;
begin
  Result := nil; Http := nil; ReqSS := nil;
  try
  try
    ReqSS := TStringStream.Create('');
    Http := THTTPClient.Create;
    var Res :=  Http.Get(URL, ReqSS);
    if Res.StatusCode = 200 then
    begin
      Result := FromJSON(ReqSS.DataString);
      if Result <> nil then Result.RawJSON := ReqSS.DataString;
    end;
  finally
    ReqSS.Free;
    Http.Free;
  end;
  except
  end;
end;

{ TvnsDate }

function TvnsDate.GetDate: TDate;
begin
  Result := EncodeDate(year.AsInt64, month.AsInt64, day.AsInt64);
end;

{ TvnsTime }

function TvnsTime.GetTime: TTime;
begin
  Result := EncodeTime(hour.AsInt64, minute.AsInt64, 0, 0);
end;

{ TvnsDateCtx }

function TvnsDateCtx.GetDate: TDate;
begin
  Result := EncodeDate(date.year.AsInt64, date.month.AsInt64, date.day.AsInt64);
end;

{ TvnsInfo }

function TvnsInfo.GetDateTime: TDateTime;
begin
  Result := EncodeDateTime(
    Self.date.year.AsInt64,
    Self.date.month.AsInt64,
    Self.date.day.AsInt64,
    Self.time.hour.AsInt64,
    Self.time.minute.AsInt64,
    0,
    0
  );
end;

end.
