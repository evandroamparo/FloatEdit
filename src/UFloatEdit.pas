unit UFloatEdit;

interface

uses
  StdCtrls;

type
   TFloatEdit = class
   private
      FEdit: TEdit;
      FValue: double;
      FInteiros: boolean;
      FCasasDecimais: cardinal;
      procedure EditKeyPress(Sender: TObject; var Key: char);
      procedure Formatar;
      function GetValue: double;
   public
      property Value: double read GetValue;
      constructor Create(Edit: TEdit; const SomenteInteiros: boolean = false; const CasasDecimais: cardinal = 2);
   end;

implementation

uses
  SysUtils, Math, Windows;

{ TFloatEdit }

constructor TFloatEdit.Create(Edit: TEdit; const SomenteInteiros: boolean = false; const CasasDecimais: cardinal = 2);
begin
   FEdit := Edit;
   FEdit.OnKeyPress := EditKeyPress;
   FInteiros := SomenteInteiros;
   FCasasDecimais := CasasDecimais;
   GetValue;
   Formatar;
end;

procedure TFloatEdit.EditKeyPress(Sender: TObject; var Key: char);
var
  Fator: double;
begin
   GetValue;
   Fator := 1 / Power(10, FCasasDecimais);
   if FInteiros or (FCasasDecimais = 0) then begin
      Fator := 1;
   end;
   if Key in ['0'..'9'] then begin
      FValue := FValue * 10 + (ord(Key) - Ord('0')) * Fator;
   end
   else if Ord(key) = VK_BACK then begin
      FValue := Trunc(FValue * Power(10, FCasasDecimais-1)) / Power(10, FCasasDecimais);
   end;
   Formatar;
   Key := #0;
end;

procedure TFloatEdit.Formatar;
var
  CasasDecimais: cardinal;
begin
   CasasDecimais := FCasasDecimais;
   if FInteiros then begin
      CasasDecimais := 0;
   end;
   FEdit.Text := Format('%.' + IntToStr(CasasDecimais) + 'f', [FValue]);
   FEdit.SelStart := Length(FEdit.Text);
end;

function TFloatEdit.GetValue: double;
var
  CasasDecimais: Cardinal;
begin
   CasasDecimais := FCasasDecimais;
   if FInteiros then begin
      CasasDecimais := 0;
   end;
   FValue := StrToFloatDef(FEdit.Text, 0);
   FValue := RoundTo(FValue, -CasasDecimais);
   result := FValue;
end;

end.
