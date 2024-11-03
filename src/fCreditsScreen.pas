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
/// File last update : 2024-11-02T19:37:22.000+01:00
/// Signature : 1e48baa190e958b0a9f35269c21bc9a0c936e776
/// ***************************************************************************
/// </summary>

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
  System.Messaging,
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
  TUIItemsList.Current.NewLayout;
  TUIItemsList.Current.AddControl(btnBack, nil, nil, nil, nil, true, true);

  FrameResized(self);
end;

procedure TCreditsScreen.TranslateTexts(const Language: string);
begin
  inherited;
  Text1.Text := GetTxtAboutDescription(Language) + slinebreak + slinebreak +
    GetTxtAboutLicense(Language) + slinebreak + slinebreak;
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
    NewScene: TCreditsScreen;
  begin
    if (Msg is TSceneFactory) and
      ((Msg as TSceneFactory).SceneType = TSceneType.Credits) then
    begin
      NewScene := TCreditsScreen.Create(application.mainform);
      NewScene.Parent := application.mainform;
      tscene.RegisterScene(TSceneType.Credits, NewScene);
    end;
  end);

end.
