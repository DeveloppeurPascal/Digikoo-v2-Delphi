/// <summary>
/// ***************************************************************************
///
/// Digikoo
///
/// Copyright 2012-2025 Patrick Pr�martin under AGPL 3.0 license.
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
/// File last update : 2025-01-12T19:10:14.000+01:00
/// Signature : 29cb86b6e7da9eea66858cfb457da55a7115f9de
/// ***************************************************************************
/// </summary>

unit fGameScreen;

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
  FMX.Layouts,
  FMX.ImgList,
  cNumberButton,
  _ButtonsAncestor,
  cImageButton;

type
  TNumberButtonGrid = array [1 .. 9, 1 .. 9] of TNumberButton;
  TNumberButtonArray = array [1 .. 9] of TNumberButton;

  TGameScreen = class(T__SceneAncestor)
    glPlayerGrid: TGridLayout;
    flNumbers: TFlowLayout;
    gTitle: TGlyph;
    Layout2: TLayout;
    slGameZone: TScaledLayout;
    slImageButtons: TLayout;
    Layout3: TLayout;
    btnPause: TImageButton;
    btnMusicOnOff: TImageButton;
    btnSoundsOnOff: TImageButton;
    procedure FrameResized(Sender: TObject);
    procedure btnMusicOnOffClick(Sender: TObject);
    procedure btnPauseClick(Sender: TObject);
    procedure btnSoundsOnOffClick(Sender: TObject);
  private
    CurrentNumber: integer;
    Grid: TNumberButtonGrid;
    BtnTab: TNumberButtonArray;
    NbCases: integer;
    procedure SelectANumberClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure PutANumberClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure TestGridValidity;
  public
    procedure ShowScene; override;
    procedure HideScene; override;
    procedure RefreshGameGridSize;
  end;

implementation

{$R *.fmx}

uses
  System.Messaging,
  uConsts,
  uScene,
  uUIElements,
  Gamolf.RTL.UIElements,
  Gamolf.FMX.Joystick,
  Gamolf.RTL.Joystick,
  uDigikooGameData,
  uBackgroundMusic,
  uConfig,
  uSoundEffects;

{ TGameScreen }

procedure TGameScreen.btnMusicOnOffClick(Sender: TObject);
begin
  if TConfig.Current.BackgroundMusicOnOff then
  begin
    TBackgroundMusic.Current.OnOff(false);
    btnMusicOnOff.ButtonType := TImageButtonType.MusicOff;
  end
  else
  begin
    TBackgroundMusic.Current.OnOff(true);
    btnMusicOnOff.ButtonType := TImageButtonType.MusicOn;
  end;
end;

procedure TGameScreen.btnPauseClick(Sender: TObject);
begin
  TDigikooGameData.DefaultGameData.PauseGame;
  TScene.Current := TSceneType.Home;
end;

procedure TGameScreen.btnSoundsOnOffClick(Sender: TObject);
begin
  if TConfig.Current.SoundEffectsOnOff then
  begin
    TConfig.Current.SoundEffectsOnOff := false;
    TSoundEffects.Current.StopAll;
    btnSoundsOnOff.ButtonType := TImageButtonType.AudioOff;
  end
  else
  begin
    TConfig.Current.SoundEffectsOnOff := true;
    btnSoundsOnOff.ButtonType := TImageButtonType.AudioOn;
  end;
end;

procedure TGameScreen.FrameResized(Sender: TObject);
begin
  RefreshGameGridSize;
end;

procedure TGameScreen.HideScene;
begin
  inherited;
  TUIItemsList.Current.RemoveLayout;
end;

procedure TGameScreen.PutANumberClick(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  btn: TNumberButton;
  i, j, k: integer;
  Found: boolean;
  DigikooGameData: TDigikooGameData;
begin
  if (Sender is TNumberButton) then
  begin
    btn := Sender as TNumberButton;
    DigikooGameData := TDigikooGameData(TDigikooGameData.DefaultGameData);

    if (btn.Color <> TNumberButtonColor.Grey) and (btn.Number >= 0) and
      (btn.Number <= 9) then
    begin
      if (btn.Number > 0) then
      begin
        if btn.Color = TNumberButtonColor.Red then
          for i := 1 to NbCases do
            for j := 1 to NbCases do
              if (btn <> Grid[i, j]) and (btn.Number = Grid[i, j].Number) and
                (Grid[i, j].Color = TNumberButtonColor.Red) then
              begin
                Found := false;
                for k := 1 to NbCases do
                begin
                  Found := ((Grid[k, j] <> Grid[i, j]) and (Grid[k, j] <> btn)
                    and (btn.Number = Grid[k, j].Number)) or
                    ((Grid[i, k] <> Grid[i, j]) and (Grid[i, k] <> btn) and
                    (btn.Number = Grid[i, k].Number));
                  if Found then
                    break;
                end;
                if not Found then
                begin
                  Grid[i, j].Color := TNumberButtonColor.Green;
                  DigikooGameData.PlayerGrid[i, j].Color :=
                    TNumberButtonColor.Green;
                end;
              end;
        BtnTab[btn.Number].count := BtnTab[btn.Number].count + 1;
        btn.tag := btn.Number;
        btn.Number := 0;
      end
      else
        btn.tag := 0;

      if (CurrentNumber > 0) and (CurrentNumber <> btn.tag) then
      begin
        btn.Number := CurrentNumber;
        Found := false;
        for k := 1 to NbCases do
        begin
          if (k <> btn.col) and (btn.Number = Grid[k, btn.row].Number) then
          begin
            Found := true;
            if not(Grid[k, btn.row].Color = TNumberButtonColor.Grey) then
            begin
              Grid[k, btn.row].Color := TNumberButtonColor.Red;
              DigikooGameData.PlayerGrid[k, btn.row].Color :=
                TNumberButtonColor.Red;
            end;
          end;
          if (k <> btn.row) and (btn.Number = Grid[btn.col, k].Number) then
          begin
            Found := true;
            if not(Grid[btn.col, k].Color = TNumberButtonColor.Grey) then
            begin
              Grid[btn.col, k].Color := TNumberButtonColor.Red;
              DigikooGameData.PlayerGrid[btn.col, k].Color :=
                TNumberButtonColor.Red;
            end;
          end;
        end;
        if Found then
          btn.Color := TNumberButtonColor.Red
        else
          btn.Color := TNumberButtonColor.Green;
        BtnTab[CurrentNumber].count := BtnTab[CurrentNumber].count - 1;
        if (BtnTab[CurrentNumber].count < 1) then
          CurrentNumber := 0;
      end;
      DigikooGameData.PlayerGrid[btn.col, btn.row].Number := btn.Number;
      DigikooGameData.PlayerGrid[btn.col, btn.row].Color := btn.Color;
    end;
    TestGridValidity;
  end;
end;

procedure TGameScreen.RefreshGameGridSize;
var
  r: Single;
begin
  slGameZone.Width := slGameZone.OriginalWidth;
  slGameZone.Height := slGameZone.OriginalHeight;
  while (slGameZone.Width >= Width - 20) or
    (slGameZone.Height >= Height - 20) do
  begin
    r := (slGameZone.Width - 10) / slGameZone.OriginalWidth;
    slGameZone.Width := slGameZone.Width - 10;
    slGameZone.Height := slGameZone.OriginalHeight * r;
  end;

  gTitle.visible := (slGameZone.Position.Y > gTitle.Position.Y + gTitle.Height +
    gTitle.margins.Bottom);
end;

procedure TGameScreen.TestGridValidity;
var
  Finished: boolean;
  HasRed: boolean;
  i: integer;
  j: integer;
  DigikooGameData: TDigikooGameData;
begin
  DigikooGameData := TDigikooGameData(TDigikooGameData.DefaultGameData);

  // Test de la validit� de la grille
  // => V�rifier s'il reste des emplacements � remplir
  // => V�rifier dans ce cas s'il y a des �l�ments rouges
  Finished := true;
  HasRed := false;
  for i := 1 to NbCases do
    for j := 1 to NbCases do
    begin
      Finished := Finished and (Grid[i, j].Number <> 0);
      if not Finished then
        break;
      HasRed := HasRed or (Grid[i, j].Color = TNumberButtonColor.Red);
    end;
  if Finished then
  begin
    DigikooGameData.SaveToFile(DigikooGameData.GetFilePath);
    if HasRed then
      TScene.Current := TSceneType.GameOverLost
    else
    begin
      if DigikooGameData.ModeDeJeu = tgamemode.game then
      begin
        DigikooGameData.score := DigikooGameData.score + 1;
        if (DigikooGameData.Level = DigikooGameData.NbCases) then
        begin
          if (DigikooGameData.NbCases < 9) then
          begin
            DigikooGameData.NbCases := DigikooGameData.NbCases + 1;
            DigikooGameData.Level := 1;
          end
          else
            TScene.Current := TSceneType.GameOverWin;
        end
        else
          DigikooGameData.Level := DigikooGameData.Level + 1;
      end;
      DigikooGameData.NewGrid;
      TScene.Current := TSceneType.GameNextLevel;
    end;
  end;
end;

procedure TGameScreen.SelectANumberClick(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  btn: TNumberButton;
  i: integer;
begin
  if Sender is TNumberButton then
  begin
    btn := Sender as TNumberButton;
    if CurrentNumber = btn.Number then
    begin
      btn.Color := TNumberButtonColor.Yellow;
      CurrentNumber := 0;
    end
    else
    begin
      if CurrentNumber > 0 then
        for i := 0 to flNumbers.ChildrenCount - 1 do
          if (flNumbers.Children[i] is TNumberButton) and
            ((flNumbers.Children[i] as TNumberButton).Number = CurrentNumber)
          then
          begin
            (flNumbers.Children[i] as TNumberButton).Color :=
              TNumberButtonColor.Yellow;
            break;
          end;
      btn.Color := TNumberButtonColor.Green;
      CurrentNumber := btn.Number;
    end;
  end;
end;

procedure TGameScreen.ShowScene;
var
  item: TUIElement;
  btn: TNumberButton;
  i, j: integer;
  FirstTime: boolean;
  DigikooGameData: TDigikooGameData;
begin
  inherited;
  TUIItemsList.Current.NewLayout;
  item := TUIItemsList.Current.AddUIItem(
    procedure(const Sender: TObject)
    begin
      TDigikooGameData.DefaultGameData.PauseGame;
      TScene.Current := TSceneType.Home;
    end);
  item.KeyShortcuts.Add(vkEscape, #0, []);
  item.KeyShortcuts.Add(vkHardwareBack, #0, []);
  item.GamePadButtons := [TJoystickButtons.X];
  item.TagObject := self;

  while (glPlayerGrid.ChildrenCount > 0) do
    glPlayerGrid.Children[0].Free;
  while (flNumbers.ChildrenCount > 0) do
    flNumbers.Children[0].Free;

  DigikooGameData := TDigikooGameData(TDigikooGameData.DefaultGameData);
  NbCases := DigikooGameData.NbCases;
  FirstTime := true;
  for i := 1 to NbCases do
  begin
    btn := TNumberButton.Create(self);
    if (FirstTime) then
    begin
      FirstTime := false;
      flNumbers.Height := btn.Height;
      slGameZone.OriginalWidth := NbCases * btn.Width;
      slGameZone.OriginalHeight := NbCases * btn.Height + flNumbers.Height;
      glPlayerGrid.ItemWidth := btn.Width;
      glPlayerGrid.ItemHeight := btn.Height;
    end;
    btn.parent := flNumbers;
    btn.Color := TNumberButtonColor.Yellow;
    btn.Number := i;
    btn.OnMouseDown := SelectANumberClick;
    btn.count := NbCases;
    BtnTab[i] := btn;
  end;

  for j := 1 to NbCases do
    for i := 1 to NbCases do
    begin
      btn := TNumberButton.Create(self);
      btn.parent := glPlayerGrid;
      btn.Color := DigikooGameData.PlayerGrid[i, j].Color;
      btn.Number := DigikooGameData.PlayerGrid[i, j].Number;
      btn.OnMouseDown := PutANumberClick;
      btn.col := i;
      btn.row := j;
      Grid[i, j] := btn;
      if btn.Number in [1 .. 9] then
        BtnTab[btn.Number].count := BtnTab[btn.Number].count - 1;
    end;

  // TODO : g�rer les �l�ments au clavier (UIElements pour grille et chiffres � placer dessus)

  CurrentNumber := 0;

  RefreshGameGridSize;

  if TConfig.Current.SoundEffectsOnOff then
    btnMusicOnOff.ButtonType := TImageButtonType.MusicOn
  else
    btnMusicOnOff.ButtonType := TImageButtonType.MusicOff;
  if TConfig.Current.SoundEffectsOnOff then
    btnSoundsOnOff.ButtonType := TImageButtonType.AudioOn
  else
    btnSoundsOnOff.ButtonType := TImageButtonType.AudioOff;
  btnPause.ButtonType := TImageButtonType.Pause;

  TestGridValidity;
end;

initialization

TMessageManager.DefaultManager.SubscribeToMessage(TSceneFactory,
  procedure(const Sender: TObject; const Msg: TMessage)
  var
    NewScene: TGameScreen;
  begin
    if (Msg is TSceneFactory) and
      ((Msg as TSceneFactory).SceneType = TSceneType.game) then
    begin
      NewScene := TGameScreen.Create(application.mainform);
      NewScene.parent := application.mainform;
      TScene.RegisterScene(TSceneType.game, NewScene);
    end;
  end);

end.
