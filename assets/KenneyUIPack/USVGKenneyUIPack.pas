/// <summary>
/// ***************************************************************************
///
/// Digikoo
///
/// Copyright 2012-2025 Patrick Prémartin under AGPL 3.0 license.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
/// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
/// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
/// DEALINGS IN THE SOFTWARE.
///
/// ***************************************************************************
///
/// Author(s) :
/// Patrick PREMARTIN
///
/// Site :
/// https://digikoo.gamolf.fr/
///
/// Project site :
/// https://github.com/DeveloppeurPascal/Digikoo-v2-Delphi
///
/// ***************************************************************************
/// File last update : 2025-01-12T17:21:17.396+01:00
/// Signature : d66e4f7e33ba2c3953060af5547a0e181e766a26
/// ***************************************************************************
/// </summary>

unit USVGKenneyUIPack;

// ****************************************
// * SVG from folder :
// * C:\Users\patrickpremartin\Documents\Embarcadero\Studio\Projets\Digikoo-v2\assets\KenneyUIPack\uSVGKenneyUIPack.pas
// ****************************************
//
// This file contains a list of contants and 
// an enumeration to access to SVG source codes 
// from the generated array of strings.
//
// ****************************************
// File generator : SVG Folder to Delphi Unit v1.0
// Website : https://svgfolder2delphiunit.olfsoftware.fr/
// Generation date : 2025-01-12T17:21:17.396Z
//
// Don't do any change on this file.
// They will be erased by next generation !
// ****************************************

interface

const
  CSVGButtonSquareDepthFlat = 0;
  CSVGButtonSquareFlat = 1;

type
{$SCOPEDENUMS ON}
  TSVGKenneyUIPackIndex = (
    ButtonSquareDepthFlat = CSVGButtonSquareDepthFlat,
    ButtonSquareFlat = CSVGButtonSquareFlat);

  TSVGKenneyUIPack = class
  private
  class var
    FTag: integer;
    FTagBool: Boolean;
    FTagFloat: Single;
    FTagObject: TObject;
    FTagString: string;
    class procedure SetTag(const Value: integer); static;
    class procedure SetTagBool(const Value: Boolean); static;
    class procedure SetTagFloat(const Value: Single); static;
    class procedure SetTagObject(const Value: TObject); static;
    class procedure SetTagString(const Value: string); static;
  public const
    ButtonSquareDepthFlat = CSVGButtonSquareDepthFlat;
    ButtonSquareFlat = CSVGButtonSquareFlat;
    class property Tag: integer read FTag write SetTag;
    class property TagBool: Boolean read FTagBool write SetTagBool;
    class property TagFloat: Single read FTagFloat write SetTagFloat;
    class property TagObject: TObject read FTagObject write SetTagObject;
    class property TagString: string read FTagString write SetTagString;
    class function SVG(const Index: Integer): string; overload;
    class function SVG(const Index: TSVGKenneyUIPackIndex) : string; overload;
    class function Count : Integer;
    class constructor Create;
  end;

var
  SVGKenneyUIPack : array of String;

implementation

uses
  System.SysUtils;

{ TSVGKenneyUIPack }

class constructor TSVGKenneyUIPack.Create;
begin
  inherited;
  FTag := 0;
  FTagBool := false;
  FTagFloat := 0;
  FTagObject := nil;
  FTagString := '';
end;

class procedure TSVGKenneyUIPack.SetTag(const Value: integer);
begin
  FTag := Value;
end;

class procedure TSVGKenneyUIPack.SetTagBool(const Value: Boolean);
begin
  FTagBool := Value;
end;

class procedure TSVGKenneyUIPack.SetTagFloat(const Value: Single);
begin
  FTagFloat := Value;
end;

class procedure TSVGKenneyUIPack.SetTagObject(const Value: TObject);
begin
  FTagObject := Value;
end;

class procedure TSVGKenneyUIPack.SetTagString(const Value: string);
begin
  FTagString := Value;
end;

class function TSVGKenneyUIPack.SVG(const Index: Integer): string;
begin
  if (index < Count) then
    result := SVGKenneyUIPack[index]
  else
    raise Exception.Create('SVG not found. Index out of range.');
end;

class function TSVGKenneyUIPack.SVG(const Index : TSVGKenneyUIPackIndex): string;
begin
  result := SVG(ord(index));
end;

class function TSVGKenneyUIPack.Count: Integer;
begin
  result := length(SVGKenneyUIPack);
end;

initialization

SetLength(SVGKenneyUIPack, 2);

{$TEXTBLOCK NATIVE XML}
SVGKenneyUIPack[CSVGButtonSquareDepthFlat] := '''
<svg width="64" height="64" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
  <defs/>
  <g>
    <path stroke="none" fill="#FFEA9C" d="M27.45 4.05 L27.2 4.05 26.8 4.05 26.55 4.05 26 4 6 4 Q4.35 4 4.1 5.3 L4.05 5.5 4 6 4 24 4.05 24.55 4.05 24.8 4.05 25.2 4.05 25.45 4 26 4 54 Q4 56 6 56 L26 56 26.55 56 26.8 55.95 27.2 55.95 27.45 56 28 56 58 56 Q60 56 60 54 L60 26 60 25.45 59.95 25.2 59.95 24.8 60 24.55 60 24 60 6 59.95 5.3 60 5.35 Q59.65 4 58 4 L28 4 27.45 4.05 M61.95 25.2 L62 26 62 54 Q62 58 58 58 L28 58 27.2 57.95 26.8 57.95 26 58 6 58 Q2 58 2 54 L2 26 2.05 25.2 2.05 24.8 2 24 2 6 2.1 5.05 Q2.5 2 6 2 L26 2 26.8 2.05 27.2 2.05 28 2 58 2 Q61.5 2 61.95 5.05 L62 6 62 24 61.95 24.8 61.95 25.2"/>
    <path stroke="none" fill="#FFCC00" d="M27.45 4.05 L28 4 58 4 Q59.65 4 60 5.35 L59.95 5.3 60 6 60 24 60 24.55 59.95 24.8 59.95 25.2 60 25.45 60 26 60 54 Q60 56 58 56 L28 56 27.45 56 27.2 55.95 26.8 55.95 26.55 56 26 56 6 56 Q4 56 4 54 L4 26 4.05 25.45 4.05 25.2 4.05 24.8 4.05 24.55 4 24 4 6 4.05 5.5 4.1 5.3 Q4.35 4 6 4 L26 4 26.55 4.05 26.8 4.05 27.2 4.05 27.45 4.05"/>
    <path stroke="none" fill="#DEA312" d="M0 24.75 L0 6 Q0 0 6 0 L26 0 27 0.05 28 0 58 0 Q64 0 64 6 L64 24.75 63.95 25 64 25.4 64 54.25 Q63.85 60 58 60 L28 60 27 59.95 26 60 6 60 Q0.15 60 0 54.25 L0 25.4 0.05 25 0 24.75 M61.95 25.2 L61.95 24.8 62 24 62 6 61.95 5.05 Q61.5 2 58 2 L28 2 27.2 2.05 26.8 2.05 26 2 6 2 Q2.5 2 2.1 5.05 L2 6 2 24 2.05 24.8 2.05 25.2 2 26 2 54 Q2 58 6 58 L26 58 26.8 57.95 27.2 57.95 28 58 58 58 Q62 58 62 54 L62 26 61.95 25.2"/>
    <path stroke="none" fill="#FF0000" d="M64 24.75 L64 25.4 63.95 25 64 24.75 M0 25.4 L0 24.75 0.05 25 0 25.4"/>
    <path stroke="none" fill="#B48000" d="M64 54.25 L64 58 Q64 64 58 64 L28 64 27 63.95 26 64 6 64 Q0 64 0 58 L0 54.25 Q0.15 60 6 60 L26 60 27 59.95 28 60 58 60 Q63.85 60 64 54.25"/>
  </g>
</svg>
''';
SVGKenneyUIPack[CSVGButtonSquareFlat] := '''
<svg width="64" height="64" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
  <defs/>
  <g>
    <path stroke="none" fill="#FFEA9C" d="M62 6 L62 58 Q62 62 58 62 L28 62 27.2 61.95 26.8 61.95 26 62 6 62 Q2 62 2 58 L2 6 2.1 5.05 Q2.5 2 6 2 L26 2 26.8 2.05 27.2 2.05 28 2 58 2 Q61.5 2 61.95 5.05 L62 6 M27.45 4.05 L27.2 4.05 26.8 4.05 26.55 4.05 26 4 6 4 Q4.35 4 4.1 5.3 L4.05 5.5 4 6 4 58 Q4 60 6 60 L26 60 26.55 60 26.8 59.95 27.2 59.95 27.45 60 28 60 58 60 Q60 60 60 58 L60 24.55 60 24 60 6 59.95 5.3 60 5.35 Q59.65 4 58 4 L28 4 27.45 4.05"/>
    <path stroke="none" fill="#FFCC00" d="M27.45 4.05 L28 4 58 4 Q59.65 4 60 5.35 L59.95 5.3 60 6 60 24 60 24.55 60 58 Q60 60 58 60 L28 60 27.45 60 27.2 59.95 26.8 59.95 26.55 60 26 60 6 60 Q4 60 4 58 L4 6 4.05 5.5 4.1 5.3 Q4.35 4 6 4 L26 4 26.55 4.05 26.8 4.05 27.2 4.05 27.45 4.05"/>
    <path stroke="none" fill="#DEA312" d="M62 6 L61.95 5.05 Q61.5 2 58 2 L28 2 27.2 2.05 26.8 2.05 26 2 6 2 Q2.5 2 2.1 5.05 L2 6 2 58 Q2 62 6 62 L26 62 26.8 61.95 27.2 61.95 28 62 58 62 Q62 62 62 58 L62 6 M0 58.25 L0 6 Q0 0 6 0 L26 0 27 0.05 28 0 58 0 Q64 0 64 6 L64 58.25 Q63.85 64 58 64 L28 64 27 63.95 26 64 6 64 Q0.15 64 0 58.25"/>
  </g>
</svg>
''';

end.
