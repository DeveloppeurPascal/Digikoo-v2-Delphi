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
/// File last update : 2024-11-02T16:16:00.000+01:00
/// Signature : 3248b4259410032c7a7732f9fb009c27ba6be76e
/// ***************************************************************************
/// </summary>

unit fHomeScreen;

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
  _ScenesAncestor,
  udmv1_pictures,
  FMX.ImgList,
  FMX.Layouts,
  _ButtonsAncestor,
  _SporglooButtonAncestor;

type
  THomeScreen = class(T__SceneAncestor)
    gTitle: TGlyph;
    lMenuButtonsArray: TLayout;
    lMenuButtons: TLayout;
    btnTraining: T__SporglooButtonAncestor;
    btnQuitter: T__SporglooButtonAncestor;
    btnCredits: T__SporglooButtonAncestor;
    btnOptions: T__SporglooButtonAncestor;
    btnHallOfFame: T__SporglooButtonAncestor;
    btnPlay: T__SporglooButtonAncestor;
    btnContinue: T__SporglooButtonAncestor;
    VertScrollBox1: TVertScrollBox;
    procedure btnQuitterClick(Sender: TObject);
    procedure btnContinueClick(Sender: TObject);
    procedure btnCreditsClick(Sender: TObject);
    procedure btnHallOfFameClick(Sender: TObject);
    procedure btnOptionsClick(Sender: TObject);
    procedure btnPlayClick(Sender: TObject);
    procedure btnTrainingClick(Sender: TObject);
    procedure FrameResized(Sender: TObject);
  private
    procedure CenterTheButtonsLayout;
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
{$IF Defined(IOS) or Defined(ANDROID)}
{$ELSE}
  uDMHelpBarManager,
  Gamolf.FMX.HelpBar,
  USVGInputPrompts,
{$ENDIF}
  uDigikooGameData,
  uConfig,
  uSoundEffects;

procedure THomeScreen.BeforeFirstShowScene;
begin
  inherited;
{$IF Defined(IOS) or Defined(ANDROID)}
{$ELSE}
  THelpBarManager.Current.Height := 100;
  THelpBarManager.Current.TextSettings.Font.Size :=
    THelpBarManager.Current.TextSettings.Font.Size * 2;
  THelpBarManager.Current.TextSettings.FontColor := talphacolors.Whitesmoke;
  THelpBarManager.Current.HorzAlign := TDGEFMXHelpBarHorzAlign.Center;
{$ENDIF}
  TDigikooGameData(TDigikooGameData.DefaultGameData).Load;
end;

procedure THomeScreen.CenterTheButtonsLayout;
begin
  // center the buttons layout
  lMenuButtonsArray.margins.Top := (Height - lMenuButtonsArray.Height) / 2 -
    (gTitle.position.y + gTitle.Height + gTitle.margins.Bottom);
  if lMenuButtonsArray.margins.Top < 0 then
    lMenuButtonsArray.margins.Top := gTitle.margins.Bottom;
end;

procedure THomeScreen.FrameResized(Sender: TObject);
begin
  CenterTheButtonsLayout;
end;

procedure THomeScreen.btnContinueClick(Sender: TObject);
begin
  TDigikooGameData.DefaultGameData.ContinueGame;
  tscene.Current := TSceneType.Game;
end;

procedure THomeScreen.btnCreditsClick(Sender: TObject);
begin
  tscene.Current := TSceneType.Credits;
end;

procedure THomeScreen.btnHallOfFameClick(Sender: TObject);
begin
  tscene.Current := TSceneType.HallOfFame;
end;

procedure THomeScreen.btnOptionsClick(Sender: TObject);
begin
  tscene.Current := TSceneType.Options;
end;

procedure THomeScreen.btnPlayClick(Sender: TObject);
begin
  TDigikooGameData.DefaultGameData.StartANewGame;
  tscene.Current := TSceneType.Game;
end;

procedure THomeScreen.btnQuitterClick(Sender: TObject);
begin
  tscene.Current := TSceneType.Exit;
end;

procedure THomeScreen.btnTrainingClick(Sender: TObject);
begin
  tscene.Current := TSceneType.Training;
end;

procedure THomeScreen.HideScene;
begin
  inherited;
  TUIItemsList.Current.RemoveLayout;
  TSoundEffects.StopAll;
end;

procedure THomeScreen.ShowScene;
var
  i: integer;
  y: single;
{$IF Defined(IOS) or Defined(ANDROID)}
{$ELSE}
  s: string;
{$ENDIF}
begin
  inherited;
  TUIItemsList.Current.NewLayout;
  if TDigikooGameData.DefaultGameData.IsPaused then
  begin
    btnContinue.visible := true;
    TUIItemsList.Current.AddControl(btnTraining, nil, nil, btnContinue, nil);
    TUIItemsList.Current.AddControl(btnContinue, btnTraining, nil, btnPlay,
      nil, true);
    TUIItemsList.Current.AddControl(btnPlay, btnContinue, nil, btnCredits, nil);
    // TUIItemsList.Current.AddControl(btnPlay, btnContinue, nil,
    // btnHallOfFame, nil);
  end
  else
  begin
    btnContinue.visible := false;
    TUIItemsList.Current.AddControl(btnTraining, nil, nil, btnPlay, nil);
    TUIItemsList.Current.AddControl(btnPlay, btnTraining, nil, btnCredits,
      nil, true);
    // TUIItemsList.Current.AddControl(btnPlay, btnTraining, nil, btnHallOfFame,
    // nil, true);
  end;

  btnHallOfFame.visible := false; // TODO : à réactiver quand l'écran sera fini
  // TUIItemsList.Current.AddControl(btnHallOfFame, btnPlay, nil, btnOptions, nil);
  btnOptions.visible := false; // TODO : à réactiver quand l'écran sera fini
  // TUIItemsList.Current.AddControl(btnOptions, btnHallOfFame, nil, btnCredits, nil);
{$IF Defined(IOS) or Defined(Android)}
  btnQuitter.visible := false;
{$ELSE}
  btnQuitter.visible := true;
{$ENDIF}
  if btnQuitter.visible then
  begin
    TUIItemsList.Current.AddControl(btnCredits, btnPlay, nil, btnQuitter, nil);
    // TUIItemsList.Current.AddControl(btnCredits, btnOptions, nil,
    // btnQuitter, nil);
    TUIItemsList.Current.AddControl(btnQuitter, btnCredits, nil, nil, nil,
      false, true);
  end
  else
    TUIItemsList.Current.AddControl(btnCredits, btnOptions, nil, nil, nil);

{$IF Defined(IOS) or Defined(ANDROID)}
{$ELSE}
  THelpBarManager.Current.OpenHelpBar;
  THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardArrowUp +
    TSVGInputPrompts.Tag, TSVGInputPrompts.SteamDpadUpOutline +
    TSVGInputPrompts.Tag);
  if tconfig.Current.Language = 'fr' then
    s := 'Déplacer'
  else
    s := 'Move';
  THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardArrowDown +
    TSVGInputPrompts.Tag, TSVGInputPrompts.SteamDpadDownOutline +
    TSVGInputPrompts.Tag, s);
  if tconfig.Current.Language = 'fr' then
    s := 'Choisir'
  else
    s := 'Select';
  THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardSpace +
    TSVGInputPrompts.Tag, TSVGInputPrompts.SteamButtonColorAOutline +
    TSVGInputPrompts.Tag, s);
  if btnQuitter.visible then
    THelpBarManager.Current.AddItem(TSVGInputPrompts.KeyboardEscape +
      TSVGInputPrompts.Tag, TSVGInputPrompts.SteamButtonColorXOutline +
      TSVGInputPrompts.Tag, btnQuitter.Text);
{$ENDIF}
  // resize the buttons list and change their Y position
  y := 0;
  for i := 0 to lMenuButtons.ChildrenCount - 1 do
    if (lMenuButtons.Children[i] is TControl) and
      (lMenuButtons.Children[i] as TControl).visible then
    begin
      (lMenuButtons.Children[i] as TControl).position.y := y;
      y := y + (lMenuButtons.Children[i] as TControl).margins.Top +
        (lMenuButtons.Children[i] as TControl).Height +
        (lMenuButtons.Children[i] as TControl).margins.Bottom;
    end;
  lMenuButtonsArray.Height := y;

  CenterTheButtonsLayout;
end;

procedure THomeScreen.TranslateTexts(const Language: string);
begin
  inherited;
  if (Language = 'fr') then
  begin
    btnTraining.Text := 'Entrainement';
    btnQuitter.Text := 'Quitter';
    btnCredits.Text := 'Crédits';
    btnOptions.Text := 'Options';
    btnHallOfFame.Text := 'Scores';
    btnPlay.Text := 'Jouer';
    btnContinue.Text := 'Continuer';
  end
  else
  begin
    btnTraining.Text := 'Training';
    btnQuitter.Text := 'Quit';
    btnCredits.Text := 'Credits';
    btnOptions.Text := 'Options';
    btnHallOfFame.Text := 'Hall of fame';
    btnPlay.Text := 'Play';
    btnContinue.Text := 'Continue';
  end;
end;

initialization

TMessageManager.DefaultManager.SubscribeToMessage(TSceneFactory,
  procedure(const Sender: TObject; const Msg: TMessage)
  var
    NewScene: THomeScreen;
  begin
    if (Msg is TSceneFactory) and
      ((Msg as TSceneFactory).SceneType = TSceneType.Home) then
    begin
      NewScene := THomeScreen.Create(application.mainform);
      NewScene.Parent := application.mainform;
      tscene.RegisterScene(TSceneType.Home, NewScene);
    end;
  end);

end.
