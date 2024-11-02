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
/// File last update : 2024-11-02T20:13:12.000+01:00
/// Signature : 75cbc2991d1457a70bce3b746502a4c1c8cbbcc7
/// ***************************************************************************
/// </summary>

unit uDigikooGameData;

interface

uses
  System.Classes,
  uGameData,
  cNumberButton;

type
  TGridCell = record
    Number: integer;
    Color: TNumberButtonColor;
  end;

  TDigikooGrid = array [1 .. 9, 1 .. 9] of TGridCell;

{$SCOPEDENUMS ON}
  TGameMode = (Training, Game);

  TDigikooGameData = class(TGameData)
  private
    FModeDeJeu: TGameMode;
    function GetModeDeJeu: int64;
    function GetNbCases: int64;
    procedure SetNbCases(const Value: int64);
    procedure SetModeDeJeu(const Value: TGameMode);
  protected
  public
    /// <summary>
    /// Contains the on screen player grid
    /// </summary>
    PlayerGrid: TDigikooGrid;
    /// <summary>
    /// Cells numbers
    /// </summary>
    property NbCases: int64 read GetNbCases write SetNbCases;
    /// <summary>
    /// Training (0) or Game (1)
    /// </summary>
    property ModeDeJeu: TGameMode read FModeDeJeu write SetModeDeJeu;
    class function DefaultGameData: TGameData; override;
    procedure StartANewGame; override;
    procedure StartTraining(const ANbCases: int64);
    procedure NewGrid;
    procedure SaveToStream(const AStream: TStream); override;
    procedure LoadFromStream(const AStream: TStream); override;
  end;

implementation

var
  LDefaultGameData: TDigikooGameData;

  { TDigikooGameData }

class function TDigikooGameData.DefaultGameData: TGameData;
begin
  if not assigned(LDefaultGameData) then
    LDefaultGameData := TDigikooGameData.Create;
  result := LDefaultGameData;
end;

function TDigikooGameData.GetModeDeJeu: int64;
begin
  result := Score;
end;

function TDigikooGameData.GetNbCases: int64;
begin
  result := NbLives;
end;

procedure TDigikooGameData.NewGrid;
var
  i, j, k: integer;
  r, n: integer;
  found: boolean;
begin
  // remplissage avec des valeurs aléatoires
  for i := 1 to NbCases do
    for j := 1 to NbCases do
    begin
      r := random(NbCases) + 1;
      n := r;
      repeat
        k := 1;
        found := false;
        while ((k < i) or (k < j)) and (not found) do
        begin
          found := ((k < i) and (PlayerGrid[k, j].Number = n)) or
            ((k < j) and (PlayerGrid[i, k].Number = n));
          inc(k);
        end;
        if found then
          if (n < NbCases) then
            inc(n)
          else
            n := 1;
      until (not found) or (r = n);
      if not found then
      begin
        PlayerGrid[i, j].Number := n;
        PlayerGrid[i, j].Color := TNumberButtonColor.Yellow;
      end
      else
        PlayerGrid[i, j].Number := -1;
    end;

  // fixation de quelques cellules
  r := random(NbCases) + 1;
  while (r > 0) do
  begin
    i := random(NbCases) + 1;
    j := random(NbCases) + 1;
    if (PlayerGrid[i, j].Number < 0) or
      ((PlayerGrid[i, j].Number > 0) and
      (PlayerGrid[i, j].Color = TNumberButtonColor.Yellow)) then
    begin
      PlayerGrid[i, j].Color := TNumberButtonColor.grey;
      dec(r);
    end;
  end;

  // effacement des valeurs non figées hors cases en erreur
  for i := 1 to NbCases do
    for j := 1 to NbCases do
      if (PlayerGrid[i, j].Number > 0) and
        (PlayerGrid[i, j].Color = TNumberButtonColor.Yellow) then
        PlayerGrid[i, j].Number := 0;
end;

procedure TDigikooGameData.LoadFromStream(const AStream: TStream);
begin
  inherited;
  // TOdo : à compléter (grille + mode de jeu  à charger)
end;

procedure TDigikooGameData.SaveToStream(const AStream: TStream);
begin
  inherited;
  // TOdo : à compléter (grille + mode de jeu à archiver)
end;

procedure TDigikooGameData.SetModeDeJeu(const Value: TGameMode);
begin
  FModeDeJeu := Value;
end;

procedure TDigikooGameData.SetNbCases(const Value: int64);
begin
  // authorized values between 2 and 9 cells
  if (Value < 2) then
    NbLives := 2
  else if (Value > 9) then
    NbLives := 9
  else
    NbLives := Value;
end;

procedure TDigikooGameData.StartANewGame;
begin
  inherited;
  NbCases := 2; // 2x2 par défaut
  ModeDeJeu := TGameMode.Game;
  Level := 1;

  NewGrid;
end;

procedure TDigikooGameData.StartTraining(const ANbCases: int64);
begin
  StartANewGame;
  NbCases := ANbCases;
  ModeDeJeu := TGameMode.Training;

  NewGrid;
end;

initialization

LDefaultGameData := nil;
randomize;

finalization

LDefaultGameData.Free;

end.
