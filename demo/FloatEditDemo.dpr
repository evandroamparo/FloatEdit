program FloatEditDemo;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  UFloatEdit in '..\src\UFloatEdit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
