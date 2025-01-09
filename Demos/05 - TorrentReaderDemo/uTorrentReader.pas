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
unit uTorrentReader;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uTorrentFileReader,
  DateUtils, System.Generics.Defaults, System.Generics.Collections,
  Vcl.ExtCtrls;
type
  TForm2 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    FileOpenDialog1: TFileOpenDialog;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end; 
var
  Form2: TForm2;
implementation
{$R *.dfm}

{ Helpers }

const
  cBoolToStr: array[boolean] of string = ('False','True');

function Int64FormatBKM(v: Int64): string;
var
  x: Double;
begin
    Result := '0 B';
    x := v;
    if x < 0 then
    begin
      Result := 'N/A';
      Exit;
    end else
    if (x / 1099511627776 >= 1) then
    begin
      Result := Format('%.2f', [x / 1099511627776 ])+ ' TiB';
      Exit;
    end else
    if (x / (1024 * 1024 * 1024) >= 1) then
    begin
      Result := Format('%.2f', [x /(1024 * 1024 * 1024)] )+ ' GiB';
      Exit;
    end else
    if (x / (1024 * 1024)>= 1) then
    begin
      Result := Format('%.2f', [x /(1024 * 1024)] )+ ' MiB';
      Exit;
    end else
    if (x / (1024)) >= 1 then
    begin
      Result := Format('%.2f', [x /(1024)] )+ ' KiB';
    end else begin
      Result := Format('%.0f', [x] )+ ' B';
    end;
end;

procedure TForm2.Button1Click(Sender: TObject);
var
  Torrent: TTorrentFile;
  StringBuilder: TStringBuilder;
begin
  Torrent := nil; StringBuilder := nil;
  Memo1.Clear;
  if not FileOpenDialog1.Execute then exit;
  try
    Torrent := TTorrentFile.FromFile(FileOpenDialog1.FileName, []);
    if Torrent = nil then
    begin
      Memo1.Text := 'Invalid Torrent File Format';
      Exit;
    end;
    StringBuilder := TStringBuilder.Create;
    StringBuildeR.AppendLine( 'Filename : ' + FileOpenDialog1.FileName);
    StringBuildeR.AppendLine( 'Parsing Duration : ' + (Torrent.ProcessingTimeMS).ToString + 'ms');
    StringBuildeR.AppendLine( 'Version : ' + Torrent.Data.Info.MetaVersion.ToString );
    StringBuildeR.AppendLine( 'Hybrid : ' + cBoolToStr[Torrent.Data.Info.IsHybrid]);
    StringBuildeR.AppendLine( 'HashV1 : ' + Torrent.Data.HashV1 );
    StringBuildeR.AppendLine( 'HashV2 : ' + Torrent.Data.HashV2 );
    StringBuildeR.AppendLine( 'Announce : ' + Torrent.Data.Announce); // AnnounceList for multiple Annouces
    StringBuildeR.AppendLine( 'Created By : ' + Torrent.Data.CreatedBy);
    StringBuildeR.AppendLine( 'Creation Date : ' + DateTimeToStr(Torrent.Data.CreationDate));
    StringBuildeR.AppendLine( 'Comments : ');
    StringBuildeR.AppendLine(  Torrent.Data.Comment.Text);
    StringBuildeR.AppendLine( 'Private : ' + cBoolToStr[Torrent.Data.Info.IsPrivate]);
    StringBuildeR.AppendLine( '' );
    StringBuildeR.AppendLine( 'Announce Tier/URLs : ');
    for var Tier in Torrent.Data.AnnouncesDict do
    begin
      StringBuildeR.AppendLine( '  Tier : ' + Tier.Key.ToString  );
      for var Url in Tier.Value do
        StringBuildeR.AppendLine( '         ' +  Url );
    end;
    StringBuildeR.AppendLine( '' );
    StringBuildeR.AppendLine( 'Web Seeds : ');
    for var Url in Torrent.Data.WebSeeds do StringBuildeR.AppendLine(Url);
    StringBuildeR.AppendLine( '' );
    StringBuildeR.AppendLine( 'Root Folder : ' + Torrent.Data.Info.Name );
    StringBuildeR.AppendLine( 'Files Count : ' + Torrent.Data.Info.FileList.Count.ToString);
    StringBuildeR.AppendLine( 'Pieces Length : ' + Int64FormatBKM(Torrent.Data.Info.PieceLength));
    StringBuildeR.AppendLine( 'Pieces Count (Total): ' + Torrent.Data.Info.PiecesCount.ToString);
    StringBuildeR.AppendLine( 'Files Size (Total): ' + Int64FormatBKM(Torrent.Data.Info.FilesSize));
    StringBuildeR.AppendLine;
    for var FileData in Torrent.Data.Info.FileList do
    begin
      StringBuildeR.AppendLine('   -> ' + FileData.FullPath);
      StringBuildeR.AppendLine( '       Size :' + Int64FormatBKM(FileData.Length));
    end;
    Memo1.Text := StringBuilder.ToString;
    Memo1.Lines.Insert(0, '');
  finally
    StringBuilder.Free;
    Torrent.Free;
  end;
end;

end.
