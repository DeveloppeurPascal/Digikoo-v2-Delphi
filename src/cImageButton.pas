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
/// File last update : 2025-01-12T19:14:34.000+01:00
/// Signature : a0437f3e938f6382fbfcd6cdafb09e901b987ec4
/// ***************************************************************************
/// </summary>

unit cImageButton;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  _ButtonsAncestor,
  FMX.Objects;

type
{$SCOPEDENUMS ON}
  TImageButtonType = (None, AudioOn, AudioOff, MusicOn, MusicOff, Pause, Share);

  TImageButton = class(T__ButtonAncestor)
    rBackground: TRectangle;
    rIcone: TRectangle;
  private
    FButtonType: TImageButtonType;
    procedure SetButtonType(const Value: TImageButtonType);
  public
    constructor Create(AOwner: TComponent); override;
    property ButtonType: TImageButtonType read FButtonType write SetButtonType;
    procedure Repaint; override;
  end;

var
  ImageButton: TImageButton;

implementation

{$R *.fmx}

uses
  uSVGBitmapManager_GameIcons,
  USVGKenneyGameIcons,
  uSVGBitmapManager_UIPack,
  USVGKenneyUIPack;

{ TImageButton }

constructor TImageButton.Create(AOwner: TComponent);
begin
  inherited;
  FButtonType := TImageButtonType.None;
end;

procedure TImageButton.Repaint;
var
  bmp: tbitmap;
begin
  if IsDown then
  begin
    rBackground.Fill.Bitmap.Bitmap.Assign
      (getBitmapFromSVG(tsvgkenneyuipackindex.ButtonSquareFlat,
      rBackground.width, rBackground.height,
      rBackground.Fill.Bitmap.Bitmap.bitmapscale));
    rIcone.margins.Top := 5;
    rIcone.margins.Right := 5;
    rIcone.margins.Bottom := 5;
    rIcone.margins.Left := 5;
  end
  else
  begin
    rBackground.Fill.Bitmap.Bitmap.Assign
      (getBitmapFromSVG(tsvgkenneyuipackindex.ButtonSquareDepthFlat,
      rBackground.width, rBackground.height,
      rBackground.Fill.Bitmap.Bitmap.bitmapscale));
    rIcone.margins.Top := 5;
    rIcone.margins.Right := 8;
    rIcone.margins.Bottom := 8;
    rIcone.margins.Left := 11;
  end;
  case FButtonType of
    TImageButtonType.None:
      bmp := nil;
    TImageButtonType.AudioOn:
      bmp := getBitmapFromSVG(TSVGKenneyGameIconsIndex.AudioOn, rIcone.width,
        rIcone.height, rIcone.Fill.Bitmap.Bitmap.bitmapscale);
    TImageButtonType.AudioOff:
      bmp := getBitmapFromSVG(TSVGKenneyGameIconsIndex.AudioOff, rIcone.width,
        rIcone.height, rIcone.Fill.Bitmap.Bitmap.bitmapscale);
    TImageButtonType.MusicOn:
      bmp := getBitmapFromSVG(TSVGKenneyGameIconsIndex.MusicOn, rIcone.width,
        rIcone.height, rIcone.Fill.Bitmap.Bitmap.bitmapscale);
    TImageButtonType.MusicOff:
      bmp := getBitmapFromSVG(TSVGKenneyGameIconsIndex.MusicOff, rIcone.width,
        rIcone.height, rIcone.Fill.Bitmap.Bitmap.bitmapscale);
    TImageButtonType.Pause:
      bmp := getBitmapFromSVG(TSVGKenneyGameIconsIndex.Pause, rIcone.width,
        rIcone.height, rIcone.Fill.Bitmap.Bitmap.bitmapscale);
    TImageButtonType.Share:
      bmp := getBitmapFromSVG(TSVGKenneyGameIconsIndex.Share, rIcone.width,
        rIcone.height, rIcone.Fill.Bitmap.Bitmap.bitmapscale);
  else
    raise Exception.Create('Unknow TImageButtonType value ' + ord(FButtonType)
      .ToString + '.');
  end;
  if assigned(bmp) then
  begin
    rIcone.visible := true;
    rIcone.Fill.Bitmap.Bitmap.Assign(bmp);
  end
  else
    rIcone.visible := false;
end;

procedure TImageButton.SetButtonType(const Value: TImageButtonType);
begin
  FButtonType := Value;
  Repaint;
end;

end.
