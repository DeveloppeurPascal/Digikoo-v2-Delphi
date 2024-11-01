unit cMenuButton;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  _ButtonsAncestor;

type
  TMenuButton = class(T__ButtonAncestor)
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  MenuButton: TMenuButton;

implementation

{$R *.fmx}

end.
