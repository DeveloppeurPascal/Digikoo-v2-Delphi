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
  File last update : 2025-07-03T10:43:50.000+02:00
  Signature : 1839964112b18e25989b5733c86acbface317c27
  ***************************************************************************
*)

program Digikoo;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Skia,
  fMain in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\fMain.pas' {frmMain},
  Olf.FMX.AboutDialog in '..\lib-externes\AboutDialog-Delphi-Component\src\Olf.FMX.AboutDialog.pas',
  Olf.FMX.AboutDialogForm in '..\lib-externes\AboutDialog-Delphi-Component\src\Olf.FMX.AboutDialogForm.pas' {OlfAboutDialogForm},
  u_urlOpen in '..\lib-externes\librairies\src\u_urlOpen.pas',
  uConsts in 'uConsts.pas',
  Olf.RTL.Language in '..\lib-externes\librairies\src\Olf.RTL.Language.pas',
  Olf.RTL.CryptDecrypt in '..\lib-externes\librairies\src\Olf.RTL.CryptDecrypt.pas',
  Olf.RTL.Params in '..\lib-externes\librairies\src\Olf.RTL.Params.pas',
  Olf.Skia.SVGToBitmap in '..\lib-externes\librairies\src\Olf.Skia.SVGToBitmap.pas',
  uDMAboutBox in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\uDMAboutBox.pas' {AboutBox: TDataModule},
  uDMAboutBoxLogoStorrage in 'uDMAboutBoxLogoStorrage.pas' {dmAboutBoxLogo: TDataModule},
  uTxtAboutLicense in 'uTxtAboutLicense.pas',
  uTxtAboutDescription in 'uTxtAboutDescription.pas',
  Gamolf.FMX.HelpBar in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.FMX.HelpBar.pas',
  Gamolf.FMX.Joystick in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.FMX.Joystick.pas',
  Gamolf.FMX.MusicLoop in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.FMX.MusicLoop.pas',
  Gamolf.RTL.GamepadDetected in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.GamepadDetected.pas',
  Gamolf.RTL.Joystick.DirectInput.Win in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.DirectInput.Win.pas',
  Gamolf.RTL.Joystick.Helpers in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.Helpers.pas',
  Gamolf.RTL.Joystick.Mac in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.Mac.pas',
  Gamolf.RTL.Joystick in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Joystick.pas',
  Gamolf.RTL.Scores in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Scores.pas',
  Gamolf.RTL.UIElements in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.UIElements.pas',
  iOSapi.GameController in '..\lib-externes\Delphi-Game-Engine\src\iOSapi.GameController.pas',
  Macapi.GameController in '..\lib-externes\Delphi-Game-Engine\src\Macapi.GameController.pas',
  uTranslate in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\uTranslate.pas',
  uConfig in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\uConfig.pas',
  _ScenesAncestor in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\_ScenesAncestor.pas' {__SceneAncestor: TFrame},
  uScene in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\uScene.pas',
  uUIElements in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\uUIElements.pas',
  uGameData in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\uGameData.pas',
  Olf.RTL.Streams in '..\lib-externes\librairies\src\Olf.RTL.Streams.pas',
  Olf.RTL.Maths.Conversions in '..\lib-externes\librairies\src\Olf.RTL.Maths.Conversions.pas',
  uBackgroundMusic in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\uBackgroundMusic.pas',
  uSoundEffects in 'uSoundEffects.pas',
  USVGInputPrompts in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\assets\kenney_nl\InputPrompts\USVGInputPrompts.pas',
  uDMGameControllerCenter in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\uDMGameControllerCenter.pas' {DMGameControllerCenter: TDataModule},
  uDMHelpBarManager in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\uDMHelpBarManager.pas' {HelpBarManager: TDataModule},
  _ButtonsAncestor in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\src\_ButtonsAncestor.pas' {__ButtonAncestor: TFrame},
  uSceneBackground in 'uSceneBackground.pas' {SceneBackground: TFrame},
  udmv1_pictures in '..\_PRIVATE\assets\v1_pictures\udmv1_pictures.pas' {dmv1_pictures: TDataModule},
  fHomeScreen in 'fHomeScreen.pas' {HomeScreen: TFrame},
  fGameScreen in 'fGameScreen.pas' {GameScreen: TFrame},
  fGameNextLevelScreen in 'fGameNextLevelScreen.pas' {GameNextLevelScreen: TFrame},
  fGameOverWinScreen in 'fGameOverWinScreen.pas' {GameOverWinScreen: TFrame},
  fCreditsScreen in 'fCreditsScreen.pas' {CreditsScreen: TFrame},
  fOptionsScreen in 'fOptionsScreen.pas' {OptionsScreen: TFrame},
  fHallOfFameScreen in 'fHallOfFameScreen.pas' {HallOfFameScreen: TFrame},
  fTrainingScreen in 'fTrainingScreen.pas' {TrainingScreen: TFrame},
  _SporglooButtonAncestor in '..\lib-externes\Gamolf-FMX-Game-Starter-Kit\Samples\_SampleGame\ButtonsSamples\Sporgloo\_SporglooButtonAncestor.pas' {__SporglooButtonAncestor: TFrame},
  uDigikooGameData in 'uDigikooGameData.pas',
  cNumberButton in 'cNumberButton.pas' {NumberButton: TFrame},
  fGameOverLostScreen in 'fGameOverLostScreen.pas' {GameOverLostScreen: TFrame},
  USVGKenneyGameIcons in '..\assets\KenneyGameIcons\USVGKenneyGameIcons.pas',
  cImageButton in 'cImageButton.pas' {ImageButton: TFrame},
  uSVGBitmapManager_GameIcons in '..\assets\KenneyGameIcons\uSVGBitmapManager_GameIcons.pas',
  USVGKenneyUIPack in '..\assets\KenneyUIPack\USVGKenneyUIPack.pas',
  uSVGBitmapManager_UIPack in '..\assets\KenneyUIPack\uSVGBitmapManager_UIPack.pas';

{$R *.res}

begin
  GlobalUseSkia := True;
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDMGameControllerCenter, DMGameControllerCenter);
  Application.CreateForm(Tdmv1_pictures, dmv1_pictures);
  Application.Run;
end.
