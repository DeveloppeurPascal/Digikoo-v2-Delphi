unit uDigikooGameData;

interface

uses
  uGameData;

type
  TDigikooGameData = class(TGameData)
  private
  protected
  public
    class function DefaultGameData: TGameData; override;
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

initialization

LDefaultGameData := nil;

finalization

LDefaultGameData.Free;

end.
