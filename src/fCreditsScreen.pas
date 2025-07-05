(* C2PP
  ***************************************************************************

  Digikoo

  Copyright 2012-2025 Patrick Prémartin under AGPL 3.0 license.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  DEALINGS IN THE SOFTWARE.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://digikoo.gamolf.fr/

  Project site :
  https://github.com/DeveloppeurPascal/Digikoo-v2-Delphi

  ***************************************************************************
  File last update : 2025-07-05T09:42:56.000+02:00
  Signature : 3943003ceae2673867c65b9268ac7b91165ad265
  ***************************************************************************
*)

unit fCreditsScreen;

interface

// TODO : changer couleur d'affichage du text des crédits

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
  _ScenesAncestor,
  udmv1_pictures,
  FMX.Layouts,
  FMX.Objects,
  FMX.ImgList,
  _ButtonsAncestor,
  _SporglooButtonAncestor;

type
  TCreditsScreen = class(T__SceneAncestor)
    VertScrollBox1: TVertScrollBox;
    Glyph1: TGlyph;
    Text1: TText;
    Layout1: TLayout;
    Layout2: TLayout;
    btnBack: T__SporglooButtonAncestor;
    procedure btnBackClick(Sender: TObject);
    procedure FrameResized(Sender: TObject);
  private
  public
    procedure TranslateTexts(const Language: string); override;
    procedure ShowScene; override;
    procedure HideScene; override;
    procedure BeforeFirstShowScene; override;
  end;

implementation

{$R *.fmx}

uses
  uConsts,
  uScene,
  uUIElements,
  uTxtAboutDescription,
  uTxtAboutLicense;

{ TCreditsScreen }

procedure TCreditsScreen.BeforeFirstShowScene;
begin
  inherited;
  Text1.Font.Size := Text1.Font.Size * 2;
end;

procedure TCreditsScreen.btnBackClick(Sender: TObject);
begin
  tscene.Current := TSceneType.Home;
end;

procedure TCreditsScreen.FrameResized(Sender: TObject);
var
  w: single;
begin
  if width > 700 then
    w := 700
  else
    w := width - 20;

  if Text1.width > w then
  begin
    Text1.margins.Left := (width - w) / 2;
    Text1.margins.right := Text1.margins.Left;
  end
  else
  begin
    Text1.margins.Left := (width - Text1.width) / 2;
    Text1.margins.right := Text1.margins.Left;
  end;
end;

procedure TCreditsScreen.HideScene;
begin
  inherited;
  TUIItemsList.Current.RemoveLayout;
end;

procedure TCreditsScreen.ShowScene;
begin
  inherited;
  VertScrollBox1.ViewportPosition := TPointF.Create(0, 0);

  TUIItemsList.Current.NewLayout;
  TUIItemsList.Current.AddControl(btnBack, nil, nil, nil, nil, true, true);

  FrameResized(self);
end;

procedure TCreditsScreen.TranslateTexts(const Language: string);
var
  txtLicense: string;
begin
  inherited;
  if (Language = 'fr') then
  begin
    txtLicense := 'Licence';
    btnBack.Text := 'Retour';
  end
  else
  begin
    txtLicense := 'License';
    btnBack.Text := 'Back';
  end;

  Text1.Text := GetTxtAboutDescription(Language).trim + sLineBreak + sLineBreak
    + '**********' + sLineBreak + '* ' + txtLicense + sLineBreak + sLineBreak +
    GetTxtAboutLicense(Language).trim + sLineBreak + sLineBreak +
    application.MainForm.Caption + ' ' + CAboutCopyright + sLineBreak;
end;

initialization

tscene.RegisterScene<TCreditsScreen>(TSceneType.Credits);

end.
