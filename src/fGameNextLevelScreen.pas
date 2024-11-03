/// <summary>
/// ***************************************************************************
///
/// Digikoo
///
/// Copyright 2012-2024 Patrick Prémartin under AGPL 3.0 license.
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
/// File last update : 2024-11-02T19:37:20.000+01:00
/// Signature : 08cf3544404f13cf9373a0a198de6533f7de7627
/// ***************************************************************************
/// </summary>

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
    procedure btnNextLevelClick(Sender: TObject);
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

procedure TGameNextLevelScreen.BeforeFirstShowScene;
begin
  inherited;
  Text1.Font.Size := Text1.Font.Size * 2;
end;

procedure TGameNextLevelScreen.btnNextLevelClick(Sender: TObject);
begin
  TScene.Current := TSceneType.game;
end;

procedure TGameNextLevelScreen.HideScene;
begin
  inherited;
  TUIItemsList.Current.RemoveLayout;
end;

procedure TGameNextLevelScreen.ShowScene;
begin
  inherited;
  TUIItemsList.Current.NewLayout;
  TUIItemsList.Current.AddControl(btnNextLevel, nil, nil, nil, nil, true, true);

  if Text1.Width > 500 then
  begin
    Text1.margins.Left := (Width - 500) / 2;
    Text1.margins.right := Text1.margins.Left;
  end;

  TSoundEffects.Current.Play(TSoundEffectType.Victoire);
end;

procedure TGameNextLevelScreen.TranslateTexts(const Language: string);
begin
  inherited;
  if (Language = 'fr') then
  begin
    btnNextLevel.Text := 'Niveau suivant';
    Text1.Text := 'Bien joué !' + slinebreak + slinebreak + 'Votre score : ' +
      TDigikooGameData.DefaultGameData.score.ToString + slinebreak + slinebreak
      + 'Passons à la suivante.';
  end
  else
  begin
    btnNextLevel.Text := 'Next level';
    Text1.Text := 'Well done !' + slinebreak + slinebreak + 'Your score : ' +
      TDigikooGameData.DefaultGameData.score.ToString + slinebreak + slinebreak
      + 'Go to next grid.';
  end;
end;

initialization

TMessageManager.DefaultManager.SubscribeToMessage(TSceneFactory,
  procedure(const Sender: TObject; const Msg: TMessage)
  var
    NewScene: TGameNextLevelScreen;
  begin
    if (Msg is TSceneFactory) and
      ((Msg as TSceneFactory).SceneType = TSceneType.GameNextLevel) then
    begin
      NewScene := TGameNextLevelScreen.Create(application.mainform);
      NewScene.Parent := application.mainform;
      TScene.RegisterScene(TSceneType.GameNextLevel, NewScene);
    end;
  end);

end.
