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
