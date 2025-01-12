/// <summary>
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
/// File last update : 2024-11-03T15:36:28.000+01:00
/// Signature : 723a48f6e31ed34845d5d13c28f86e335b8714cf
/// ***************************************************************************
/// </summary>

unit fOptionsScreen;

interface

// TODO : ajouter les options à activer / désactiver

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
  _ButtonsAncestor,
  _SporglooButtonAncestor;

type
  TOptionsScreen = class(T__SceneAncestor)
    VertScrollBox1: TVertScrollBox;
    Glyph1: TGlyph;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    btnBack: T__SporglooButtonAncestor;
    procedure btnBackClick(Sender: TObject);
  private
  public
    procedure TranslateTexts(const Language: string); override;
    procedure ShowScene; override;
    procedure HideScene; override;
  end;

implementation

{$R *.fmx}

uses
  System.Messaging,
  uConsts,
  uScene,
  uUIElements;

{ TOptionsScreen }

procedure TOptionsScreen.btnBackClick(Sender: TObject);
begin
  tscene.Current := TSceneType.Home;
end;

procedure TOptionsScreen.HideScene;
begin
  inherited;
  TUIItemsList.Current.RemoveLayout;
end;

procedure TOptionsScreen.ShowScene;
begin
  inherited;
  TUIItemsList.Current.NewLayout;
  TUIItemsList.Current.AddControl(btnBack, nil, nil, nil, nil, true, true);
end;

procedure TOptionsScreen.TranslateTexts(const Language: string);
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
    NewScene: TOptionsScreen;
  begin
    if (Msg is TSceneFactory) and
      ((Msg as TSceneFactory).SceneType = TSceneType.Options) then
    begin
      NewScene := TOptionsScreen.Create(application.mainform);
      NewScene.Parent := application.mainform;
      tscene.RegisterScene(TSceneType.Options, NewScene);
    end;
  end);

end.
