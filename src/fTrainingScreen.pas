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
/// File last update : 2024-11-02T18:03:24.000+01:00
/// Signature : 34c65a596fd3f3dbe4bb3e1d93a79bcb5192cbc6
/// ***************************************************************************
/// </summary>

unit fTrainingScreen;

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
  FMX.Layouts,
  udmv1_pictures,
  FMX.ImgList,
  _ButtonsAncestor,
  _SporglooButtonAncestor;

type
  TTrainingScreen = class(T__SceneAncestor)
    VertScrollBox1: TVertScrollBox;
    Glyph1: TGlyph;
    lNumbersParent: TLayout;
    lNumbers: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    btnBack: T__SporglooButtonAncestor;
    procedure btnBackClick(Sender: TObject);
  private
    procedure btnNumberClick(Sender: TObject);
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
  uConfig,
  cNumberButton,
  uDigikooGameData;

procedure TTrainingScreen.BeforeFirstShowScene;
var
  i: integer;
  btn: TNumberButton;
  y: single;
begin
  inherited;
  y := 0;
  for i := 3 to 9 do
  begin
    btn := TNumberButton.Create(self);
    btn.Parent := lNumbers;
    btn.Position.y := y;
    btn.OnClick := btnNumberClick;
    btn.Color := TNumberButtonColor.Grey;
    btn.Number := i;
    y := y + btn.Height + 10;
  end;
  lNumbersParent.Height := y - 10;
end;

procedure TTrainingScreen.btnBackClick(Sender: TObject);
begin
  tscene.Current := TSceneType.Home;
end;

procedure TTrainingScreen.btnNumberClick(Sender: TObject);
begin
  if (Sender is TNumberButton) then
  begin
    TDigikooGameData(TDigikooGameData.DefaultGameData)
      .StartTraining((Sender as TNumberButton).Number);
    tscene.Current := TSceneType.Game;
  end;
end;

procedure TTrainingScreen.HideScene;
begin
  inherited;
  TUIItemsList.Current.RemoveLayout;
end;

procedure TTrainingScreen.ShowScene;
var
  NewBtn, PrevBtn: TNumberButton;
  i: integer;
begin
  inherited;
  TUIItemsList.Current.NewLayout;
  PrevBtn := nil;
  for i := 0 to lNumbers.ChildrenCount - 1 do
    if (lNumbers.Children[i] is TNumberButton) then
    begin
      NewBtn := lNumbers.Children[i] as TNumberButton;
      if not assigned(PrevBtn) then
        TUIItemsList.Current.AddControl(NewBtn, nil, nil, nil, nil)
      else
        TUIItemsList.Current.AddControl(NewBtn, PrevBtn, nil, nil, nil);
      TUIItemsList.Current.GetElementByTagObject(NewBtn)
        .KeyShortcuts.Add(0, char(ord('0') + NewBtn.Number), []);
      PrevBtn := NewBtn;
    end;
  TUIItemsList.Current.AddControl(btnBack, PrevBtn, nil, nil, nil, true, true);
end;

procedure TTrainingScreen.TranslateTexts(const Language: string);
begin
  inherited;
  if (Language = 'fr') then
  begin
    btnBack.Text := 'Retour';
  end
  else
  begin
    btnBack.Text := 'Back';
  end;
end;

initialization

TMessageManager.DefaultManager.SubscribeToMessage(TSceneFactory,
  procedure(const Sender: TObject; const Msg: TMessage)
  var
    NewScene: TTrainingScreen;
  begin
    if (Msg is TSceneFactory) and
      ((Msg as TSceneFactory).SceneType = TSceneType.Training) then
    begin
      NewScene := TTrainingScreen.Create(application.mainform);
      NewScene.Parent := application.mainform;
      tscene.RegisterScene(TSceneType.Training, NewScene);
    end;
  end);

end.
