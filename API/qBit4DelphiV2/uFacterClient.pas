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
// Use a server running facter, a webserver and php
// create a php script:  <?php passthru('facter --json mountpoints'); ?>
// TEST IT with your web browser (the passthru function may have been disbled in php.ini)
// then provide the full URL to the class function FromURL
// You'll get a TMountPoint which contains all the mount points size (nil if it fails)
//

unit uFacterClient;

interface
uses RTTI, uJX4Object, uJX4Dict, uJX4List;

type

  TMountPoint = class(TJX4Object)
    available: TValue; // string;,
    available_bytes: TValue; // Int64
    capacity: TValue; // string
    device: TValue; // string
    filesystem: TValue; // string
    aptios: TJX4ListOfValues;
    size: TValue; // string
    size_bytes: TValue; // Int64
    used: TValue; // string
    used_bytes: TValue; // Int64
  end;

  TFacterClient = class(TJX4Object)
    mountpoints: TJX4Dict<TMountPoint>;
    class function FromURL(URL: string): TFacterClient;
    function GetMountPoint(MntPoint: string = '/'): TMountPoint;
  end;


implementation
uses
    System.Net.HttpClient
  , Classes
  ;

class function TFacterClient.FromURL(URL: string): TFacterClient;
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
      Result := TJX4Object.FromJSON<TFacterClient>(ReqSS.DataString);
    end;
  finally
    ReqSS.Free;
    Http.Free;
  end;
  except
    Result := nil;
  end;
end;

function TFacterClient.GetMountPoint(MntPoint: string): TMountPoint;
begin
  Result := nil;
  try
   if not mountpoints.TryGetValue(MntPoint, Result) then Exit;
  except
  end;
end;

end.
