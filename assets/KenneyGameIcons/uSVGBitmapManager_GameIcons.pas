unit uSVGBitmapManager_GameIcons;

interface

uses
  FMX.Graphics,
  USVGKenneyGameIcons;

/// <summary>
/// Returns a bitmap from a SVG image
/// </summary>
function getBitmapFromSVG(const Index: TSVGKenneyGameIconsIndex;
  const width, height: single; const BitmapScale: single): tbitmap; overload;

implementation

uses
  Olf.Skia.SVGToBitmap;

function getBitmapFromSVG(const Index: TSVGKenneyGameIconsIndex;
  const width, height: single; const BitmapScale: single): tbitmap; overload;
begin
  result := TOlfSVGBitmapList.Bitmap(ord(Index) + TSVGKenneyGameIcons.Tag,
    round(width), round(height), BitmapScale);
end;

procedure RegisterSVGImages;
begin
  TSVGKenneyGameIcons.Tag := TOlfSVGBitmapList.AddItem(SVGKenneyGameIcons);
end;

initialization

RegisterSVGImages;

end.
