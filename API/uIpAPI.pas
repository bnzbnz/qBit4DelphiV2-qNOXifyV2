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

unit uIpAPI;

interface
uses RTTI, uJX4Object;

type

  TIpAPI = class(TJX4Object)
    status: TValue; // string;
    &message: TValue; // string;
    continent: TValue; // string;
    country: TValue; // string;
    countryCode: TValue; // string;
    region: TValue; // string;
    regionName: TValue; // string;
    city: TValue; // string;
    district: TValue; // string;
    zip: TValue; // string;
    lat: TValue; // real;
    lon: TValue; // real;
    timezone: TValue; // string;
    offset: TValue; // int64;
    currency: TValue; // string;
    isp: TValue; // string;
    org: TValue; // string;
    &as: TValue; // string;
    asname: TValue; // string;
    reverse: TValue; // string;
    mobile: TValue; // boolean;
    proxy: TValue; // boolean;
    hosting: TValue; // boolean;
    query: TValue; // string;
    class function FromJSON(JSONStr: string): TIpAPI;
    class function FromURL(
      IPorDomain: string = '';
      Fields: string = 'status,message,continent,country,countryCode,region,regionName,city,zip,lat,lon,timezone,offset,currency,isp,org,as,asname,reverse,mobile,proxy,hosting,query';
      URL: String = 'http://ip-api.com/json/'
    ): TIpAPI;
  end;

implementation
uses
      System.Net.HttpClient,
      System.SysUtils, System.DateUtils, System.Classes;


class function TIpAPI.FromJSON(JSONStr: string): TIpAPI;
begin
  try
    Result := TJX4.FromJSON<TIpAPI>(JSONStr);
  except
    Result := nil;
  end;
end;

// IPorDomain = '' is your External IP  - Fields description at https://ip-api.com/docs/api:json
class function TIpAPI.FromURL(IPorDomain: string; Fields: string; URL: string): TIpAPI;
var
  Http: THTTPClient;
  ReqSS: TStringStream;
begin
  Result := nil; Http := nil; ReqSS := nil;
  try
    try
      ReqSS := TStringStream.Create('', TEncoding.UTF8);
      Http := THTTPClient.Create;
      var Res := Http.Get(URL+ '/' + IPorDomain + '?fields=' + Fields, ReqSS);
      if Res.StatusCode = 200 then
        Result := TIpAPI.FromJSON(ReqSS.DataString);
    except
      Result := nil;
    end;
  finally
    ReqSS.Free;
    Http.Free;
  end;
end;

end.
