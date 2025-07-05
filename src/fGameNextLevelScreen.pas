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
  File last update : 2025-07-05T09:43:26.000+02:00
  Signature : fc25e874430e26c89c2bba99e1d6cb34e28dd3d7
  ***************************************************************************
*)

unit fGameNextLevelScreen;

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
  FMX.Layouts,
  udmv1_pictures,
  FMX.Objects,
  FMX.ImgList,
  _ButtonsAncestor,
  _SporglooButtonAncestor;

type
  TGameNextLevelScreen = class(T__SceneAncestor)
    VertScrollBox1: TVertScrollBox;
    Glyph1: TGlyph;
    Text1: TText;
    Layout1: TLayout;
    Layout2: TLayout;
    btnNextLevel: T__SporglooButtonAncestor;
    btnPause: T__SporglooButtonAncestor;
    procedure btnNextLevelClick(Sender: TObject);
    procedure FrameResized(Sender: TObject);
    procedure btnPauseClick(Sender: TObject);
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
  uDigikooGameData,
  uSoundEffects;

procedure TGameNextLevelScreen.BeforeFirstShowScene;
begin
  inherited;
  Text1.Font.Size := Text1.Font.Size * 2;
end;

procedure TGameNextLevelScreen.btnNextLevelClick(Sender: TObject);
begin
  TScene.Current := TSceneType.game;
end;

procedure TGameNextLevelScreen.btnPauseClick(Sender: TObject);
begin
  TDigikooGameData.Current.PauseGame;
  TScene.Current := TSceneType.Home;
end;

procedure TGameNextLevelScreen.FrameResized(Sender: TObject);
var
  w: single;
begin
  if width > 500 then
    w := 500
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

procedure TGameNextLevelScreen.HideScene;
begin
  inherited;
  TUIItemsList.Current.RemoveLayout;
end;

procedure TGameNextLevelScreen.ShowScene;
begin
  inherited;
  VertScrollBox1.ViewportPosition := TPointF.Create(0, 0);

  TUIItemsList.Current.NewLayout;
  TUIItemsList.Current.AddControl(btnPause, nil, nil, btnNextLevel, nil,
    false, true);
  TUIItemsList.Current.AddControl(btnNextLevel, btnPause, nil, nil, nil, true);

  TSoundEffects.StopAll;
  TSoundEffects.Current.Play(TSoundEffectType.Victoire);

  FrameResized(self);
end;

procedure TGameNextLevelScreen.TranslateTexts(const Language: string);
var
  s: string;
begin
  inherited;
  if (Language = 'fr') then
  begin
    btnPause.Text := 'Pause';
    btnNextLevel.Text := 'Niveau suivant';
    s := 'Bien joué !' + slinebreak + slinebreak;
    if (TDigikooGameData.Current.score > 0) then
      s := s + 'Votre score : ' + TDigikooGameData.Current.score.ToString +
        slinebreak + slinebreak;
    s := s + 'Passons à la grille suivante.';
  end
  else
  begin
    btnPause.Text := 'Pause';
    btnNextLevel.Text := 'Next level';
    s := 'Well done !' + slinebreak + slinebreak;
    if (TDigikooGameData.Current.score > 0) then
      s := s + 'Your score : ' + TDigikooGameData.Current.score.ToString +
        slinebreak + slinebreak;
    s := s + 'Go to next grid.';
  end;
  Text1.Text := s;
end;

initialization

TScene.RegisterScene<TGameNextLevelScreen>(TSceneType.GameNextLevel);

end.
