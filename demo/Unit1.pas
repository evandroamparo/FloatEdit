unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UFloatEdit;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FFloatEdit1: TFloatEdit;
    FFloatEdit2: TFloatEdit;
    FFloatEdit3: TFloatEdit;
    FFloatEdit4: TFloatEdit;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
   FFloatEdit1 := TFloatEdit.Create(Edit1, false);
   FFloatEdit2 := TFloatEdit.Create(Edit2, true);
   FFloatEdit3 := TFloatEdit.Create(Edit3, false, 0);
   FFloatEdit4 := TFloatEdit.Create(Edit4, false, 3);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
   FreeAndNil(FFloatEdit1);
   FreeAndNil(FFloatEdit2);
   FreeAndNil(FFloatEdit3);
   FreeAndNil(FFloatEdit4);
end;

end.
