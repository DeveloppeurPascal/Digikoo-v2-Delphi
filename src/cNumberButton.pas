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
/// File last update : 2024-11-03T15:30:24.000+01:00
/// Signature : cf336d86bad2b541b9d6e02be10a754fb47b2fb9
/// ***************************************************************************
/// </summary>

unit cNumberButton;

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
  udmv1_pictures,
  FMX.ImgList,
  FMX.Objects;

type
{$SCOPEDENUMS ON}
  TNumberButtonColor = (Yellow, Grey, Red, Green);

  TNumberButton = class(T__ButtonAncestor)
    Glyph1: TGlyph;
    Rectangle1: TRectangle;
  private
    FColor: TNumberButtonColor;
    FNumber: integer;
    FCol: integer;
    FRow: integer;
    FCount: byte;
    procedure SetColor(const Value: TNumberButtonColor);
    procedure SetNumber(const Value: integer);
    procedure SetCol(const Value: integer);
    procedure SetRow(const Value: integer);
    procedure SetCount(const Value: byte);
  public
    property Number: integer read FNumber write SetNumber;
    property Color: TNumberButtonColor read FColor write SetColor;
    property Col: integer read FCol write SetCol;
    property Row: integer read FRow write SetRow;
    property Count: byte read FCount write SetCount;
    constructor Create(AOwner: TComponent); override;
    procedure Repaint; override;
  end;

implementation

{$R *.fmx}
{ TNumberButton }

constructor TNumberButton.Create(AOwner: TComponent);
begin
  inherited;
  FCol := -1;
  FRow := -1;
  FNumber := 0;
  FColor := TNumberButtonColor.Yellow;
  FCount := 1;
  Repaint;
end;

procedure TNumberButton.Repaint;
begin
  visible := (FCount > 0);
  if visible then
  begin
    case FNumber of
      - 1:
        Glyph1.ImageIndex := 37; // croix
      0:
        Glyph1.ImageIndex := 36; // vide
      1 .. 9:
        Glyph1.ImageIndex := (FNumber - 1) * 4 + ord(FColor);
    else
      raise Exception.Create('Wrong number value.');
    end;
    Rectangle1.visible := IsFocused;
  end;
end;

procedure TNumberButton.SetCol(const Value: integer);
begin
  FCol := Value;
end;

procedure TNumberButton.SetColor(const Value: TNumberButtonColor);
begin
  FColor := Value;
  Repaint;
end;

procedure TNumberButton.SetCount(const Value: byte);
begin
  FCount := Value;
  if FCount < 1 then
    FColor := TNumberButtonColor.Yellow;
  Repaint;
end;

procedure TNumberButton.SetNumber(const Value: integer);
begin
  if not((Value in [0 .. 9]) or (Value = -1)) then
    FNumber := 0
  else
    FNumber := Value;

  if (FNumber < 1) then
    FColor := TNumberButtonColor.Yellow;

  Repaint;
end;

procedure TNumberButton.SetRow(const Value: integer);
begin
  FRow := Value;
end;

end.
