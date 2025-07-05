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
  File last update : 2025-07-05T09:43:32.000+02:00
  Signature : 46d8942615db24b5efff172ba971dea1e45d3849
  ***************************************************************************
*)

unit fGameOverWinScreen;

interface

// TODO : changer couleur d'affichage du text des crédits
// TODO : ajouter saisie du pseudo pour enregistrement du score

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
  _ButtonsAncestor,
  _SporglooButtonAncestor,
  FMX.Layouts,
  FMX.Objects,
  FMX.ImgList,
  udmv1_pictures;

type
  TGameOverWinScreen = class(T__SceneAncestor)
    VertScrollBox1: TVertScrollBox;
    Glyph1: TGlyph;
    Text1: TText;
    Layout1: TLayout;
    Layout2: TLayout;
    btnEndGame: T__SporglooButtonAncestor;
    procedure FrameResized(Sender: TObject);
    procedure btnEndGameClick(Sender: TObject);
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

{ TGameOverWinScreen }

procedure TGameOverWinScreen.BeforeFirstShowScene;
begin
  inherited;
  Text1.Font.Size := Text1.Font.Size * 2;
end;

procedure TGameOverWinScreen.btnEndGameClick(Sender: TObject);
begin
  TScene.Current := TSceneType.home; // TODO : à remplacer par HallOfFame;
end;

procedure TGameOverWinScreen.FrameResized(Sender: TObject);
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

procedure TGameOverWinScreen.HideScene;
begin
  inherited;
  TUIItemsList.Current.RemoveLayout;
end;

procedure TGameOverWinScreen.ShowScene;
begin
  inherited;
  VertScrollBox1.ViewportPosition := TPointF.Create(0, 0);

  TUIItemsList.Current.NewLayout;
  TUIItemsList.Current.AddControl(btnEndGame, nil, nil, nil, nil, true, true);

  TSoundEffects.StopAll;
  TSoundEffects.Current.Play(TSoundEffectType.Victoire);
  // TODO : remplacer par quelque chose d'extraordinaire

  FrameResized(self);

  TDigikooGameData.Current.StopGame;
end;

procedure TGameOverWinScreen.TranslateTexts(const Language: string);
var
  s: string;
begin
  inherited;
  if (Language = 'fr') then
  begin
    btnEndGame.Text := 'Menu'; // TODO : à remplacer par "Hall Of Fame"
    s := 'Bravo !' + slinebreak + slinebreak;
    s := s + 'Rares sont ceux qui sont arrivés au bout...' + slinebreak +
      slinebreak;
    if (TDigikooGameData.Current.score > 0) then
      s := s + 'Votre score : ' + TDigikooGameData.Current.score.ToString;
  end
  else
  begin
    btnEndGame.Text := 'Menu'; // TODO : à remplacer par "Hall Of Fame"
    s := 'Bravo !' + slinebreak + slinebreak;
    s := s + 'Few have ever reached the end...' + slinebreak + slinebreak;
    if (TDigikooGameData.Current.score > 0) then
      s := s + 'Your score : ' + TDigikooGameData.Current.score.ToString;
  end;
  Text1.Text := s;
end;

initialization

TScene.RegisterScene<TGameOverWinScreen>(TSceneType.GameOverWin);

end.
