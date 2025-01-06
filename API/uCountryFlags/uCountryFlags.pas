unit uCountryFlags;

(*****************************************************************************
The MIT License (MIT)

Copyright (c) 2020-2025 Laurent Meyer JsonX3@ea4d.com

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
*******************************************************************************)

///
///  !!! PLEASE ADD >>>> CountryFlags.rc <<<< TO YOUR PROJECT !!!
///

interface
uses Vcl.Graphics;

function LoadCountryFlags(Picture: TPicture; CountryCode: string): Boolean;

implementation
uses Vcl.Imaging.pngimage, Classes, windows;

function LoadCountryFlags(Picture: TPicture; CountryCode: string):Boolean;
var
  RS: TResourceStream;
  JPGImage: TPNGImage;
begin
  Result := False;
  RS := Nil;
  JPGImage := TPNGImage.Create;
  try
  try
    RS := TResourceStream.Create(hInstance, CountryCode, RT_RCDATA);
    JPGImage.LoadFromStream(RS);
    Picture.Graphic := JPGImage;
    Result := True;
  except end;
  finally
    RS.Free;
    JPGImage.Free;
  end;
end;

end.
