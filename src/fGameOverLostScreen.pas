﻿/// <summary>
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
/// File last update : 2025-01-12T16:01:06.000+01:00
/// Signature : 8effd4f55d9292ec234fcc9779d67a453619381c
/// ***************************************************************************
/// </summary>

unit fGameOverLostScreen;

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
  TGameOverLostScreen = class(T__SceneAncestor)
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
  System.Messaging,
  uConsts,
  uScene,
  uUIElements,
  uDigikooGameData,
  uSoundEffects;

{ TGameOverLostScreen }

procedure TGameOverLostScreen.BeforeFirstShowScene;
begin
  inherited;
  Text1.Font.Size := Text1.Font.Size * 2;
end;

procedure TGameOverLostScreen.btnEndGameClick(Sender: TObject);
begin
  TScene.Current := TSceneType.home; // TODO : à remplacer par HallOfFame;
end;

procedure TGameOverLostScreen.FrameResized(Sender: TObject);
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

procedure TGameOverLostScreen.HideScene;
begin
  inherited;
  TUIItemsList.Current.RemoveLayout;
end;

procedure TGameOverLostScreen.ShowScene;
begin
  inherited;
  TUIItemsList.Current.NewLayout;
  TUIItemsList.Current.AddControl(btnEndGame, nil, nil, nil, nil, true, true);

  TSoundEffects.StopAll;
  TSoundEffects.Current.Play(TSoundEffectType.Defaite);

  FrameResized(self);

  TDigikooGameData.DefaultGameData.StopGame;
end;

procedure TGameOverLostScreen.TranslateTexts(const Language: string);
var
  s: string;
begin
  inherited;
  if (Language = 'fr') then
  begin
    btnEndGame.Text := 'Menu'; // TODO : à remplacer par "Hall Of Fame"
    s := 'Mauvaise nouvelle !' + slinebreak + slinebreak;
    s := s + 'Vous avez perdu sur cette grille.' + slinebreak + slinebreak;
    if (TDigikooGameData.DefaultGameData.score > 0) then
      s := s + 'Votre score : ' + TDigikooGameData.DefaultGameData.
        score.ToString;
  end
  else
  begin
    btnEndGame.Text := 'Menu'; // TODO : à remplacer par "Hall Of Fame"
    s := 'Bad news !' + slinebreak + slinebreak;
    s := 'You lost on this grid.' + slinebreak + slinebreak;
    if (TDigikooGameData.DefaultGameData.score > 0) then
      s := s + 'Your score : ' + TDigikooGameData.DefaultGameData.
        score.ToString;
  end;
  Text1.Text := s;
end;

initialization

TMessageManager.DefaultManager.SubscribeToMessage(TSceneFactory,
  procedure(const Sender: TObject; const Msg: TMessage)
  var
    NewScene: TGameOverLostScreen;
  begin
    if (Msg is TSceneFactory) and
      ((Msg as TSceneFactory).SceneType = TSceneType.GameOverLost) then
    begin
      NewScene := TGameOverLostScreen.Create(application.mainform);
      NewScene.Parent := application.mainform;
      TScene.RegisterScene(TSceneType.GameOverLost, NewScene);
    end;
  end);

end.
