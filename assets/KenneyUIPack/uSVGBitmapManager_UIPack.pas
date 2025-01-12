unit uSVGBitmapManager_UIPack;

interface

uses
  FMX.Graphics,
  USVGKenneyUIPack;

/// <summary>
/// Returns a bitmap from a SVG image
/// </summary>
function getBitmapFromSVG(const Index: TSVGKenneyUIPackIndex;
  const width, height: single; const BitmapScale: single): tbitmap; overload;

implementation

uses
  Olf.Skia.SVGToBitmap;

function getBitmapFromSVG(const Index: TSVGKenneyUIPackIndex;
  const width, height: single; const BitmapScale: single): tbitmap; overload;
begin
  result := TOlfSVGBitmapList.Bitmap(ord(Index) + TSVGKenneyUIPack.Tag,
    round(width), round(height), BitmapScale);
end;

procedure RegisterSVGImages;
begin
  TSVGKenneyUIPack.Tag := TOlfSVGBitmapList.AddItem(SVGKenneyUIPack);
end;

initialization

RegisterSVGImages;

end.
