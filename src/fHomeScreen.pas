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
    Glyph1: TGlyph;
    Layout1: TLayout;
    Layout2: TLayout;
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
  uDMHelpBarManager,
  Gamolf.FMX.HelpBar,
  USVGInputPrompts,
  uDigikooGameData,
  uConfig;

procedure THomeScreen.BeforeFirstShowScene;
begin
  inherited;
  THelpBarManager.Current.Height := 100;
  THelpBarManager.Current.TextSettings.Font.Size :=
    THelpBarManager.Current.TextSettings.Font.Size * 2;
  THelpBarManager.Current.TextSettings.FontColor := talphacolors.Whitesmoke;
  THelpBarManager.Current.HorzAlign := TDGEFMXHelpBarHorzAlign.Center;
end;

procedure THomeScreen.btnContinueClick(Sender: TObject);
begin
  // TODO : à compléter
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
  // TODO : à compléter
end;

procedure THomeScreen.btnQuitterClick(Sender: TObject);
begin
  tscene.Current := TSceneType.Exit;
end;

procedure THomeScreen.btnTrainingClick(Sender: TObject);
begin
  // TODO : à compléter
end;

procedure THomeScreen.HideScene;
begin
  inherited;
  TUIItemsList.Current.RemoveLayout;
end;

procedure THomeScreen.ShowScene;
var
  s: string;
begin
  inherited;
  TUIItemsList.Current.NewLayout;
  if TDigikooGameData.DefaultGameData.IsPaused then
  begin
    btnContinue.visible := true;
    TUIItemsList.Current.AddControl(btnTraining, nil, nil, btnContinue, nil);
    TUIItemsList.Current.AddControl(btnContinue, btnTraining, nil, btnPlay,
      nil, true);
    TUIItemsList.Current.AddControl(btnPlay, btnContinue, nil,
      btnHallOfFame, nil);
  end
  else
  begin
    btnContinue.visible := false;
    TUIItemsList.Current.AddControl(btnTraining, nil, nil, btnPlay, nil);
    TUIItemsList.Current.AddControl(btnPlay, btnTraining, nil, btnHallOfFame,
      nil, true);
  end;

  TUIItemsList.Current.AddControl(btnHallOfFame, btnPlay, nil, btnOptions, nil);
  TUIItemsList.Current.AddControl(btnOptions, btnHallOfFame, nil,
    btnCredits, nil);
{$IF Defined(IOS) or Defined(Android)}
  btnQuitter.visible := false;
{$ELSE}
  btnQuitter.visible := true;
{$ENDIF}
  if btnQuitter.visible then
  begin
    TUIItemsList.Current.AddControl(btnCredits, btnOptions, nil,
      btnQuitter, nil);
    TUIItemsList.Current.AddControl(btnQuitter, btnCredits, nil, nil, nil,
      false, true);
  end
  else
    TUIItemsList.Current.AddControl(btnCredits, btnOptions, nil, nil, nil);

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
