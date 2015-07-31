unit TestFloatEdit;

interface

uses
  TestFramework, UFloatEdit, Controls, StdCtrls, Forms, Messages, Windows;
type
  // Test methods for class TFloatEdit

  TestTFloatEdit = class(TTestCase)
  strict private
    FFloatEdit: TFloatEdit;
    FForm: TForm;
    FEdit: TEdit;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure ValorInicialDeveSerIgualAoValorDoEdit;
    procedure ValorInicialInvalidoDeveRetornarZero;
    procedure DigitoDeveAcrescentarCentavos;
    procedure DigitoDeveAcrescentarCasasDecimais;
    procedure BackSpaceDeveRetirarCentavos;
    procedure BackSpaceDeveRetirarCasasDecimais;
    procedure OutrasTeclasDevemSerIgnoradas;
    procedure TextoAlteradoDeveAtualizarValor;
    procedure SomenteInteirosNaoDeveAlterarCentavos;
    procedure SomenteInteirosDeveArredondar;
    procedure FormatacaoPadraoCom2CasasDecimais;
    procedure FormatacaoSemCasasDecimaisDeveArredondar;
    procedure FormatacaoSemCasasDecimaisNaoDeveAlterarCentavos;
    procedure FormatacaoComCasasDecimaisDiferenteDoPadrao;

//  valor mínimo e máximo
//  separador de milhares e decimal
  end;

implementation

uses
  SysUtils;

procedure TestTFloatEdit.SetUp;
begin
   Application.CreateForm(TForm, FForm);
   FEdit := TEdit.Create(FForm);
   FEdit.Parent := FForm;
end;

procedure TestTFloatEdit.TearDown;
begin
   FreeAndNil(FFloatEdit);
   FreeAndNil(FForm);
end;

procedure TestTFloatEdit.BackSpaceDeveRetirarCasasDecimais;
var
  ValorInicial, ProximoValor: double;
begin
   ValorInicial := 1.999;
   ProximoValor := 0.199;
   FEdit.Text := FloatToStr(ValorInicial);
   FFloatEdit := TFloatEdit.Create(FEdit, false, 3);
   SendMessage(FEdit.Handle, WM_CHAR, VK_BACK, 0);
   CheckEquals(ProximoValor, FFloatEdit.Value);
end;

procedure TestTFloatEdit.BackSpaceDeveRetirarCentavos;
var
  ValorInicial, ProximoValor: double;
begin
   ValorInicial := 1.99;
   ProximoValor := 0.19;
   FEdit.Text := FloatToStr(ValorInicial);
   FFloatEdit := TFloatEdit.Create(FEdit);
   SendMessage(FEdit.Handle, WM_CHAR, VK_BACK, 0);
   CheckEquals(ProximoValor, FFloatEdit.Value);
end;

procedure TestTFloatEdit.SomenteInteirosDeveArredondar;
var
  ValorInicial, ValorArredondado: double;
begin
   ValorInicial := 1.99;
   ValorArredondado := 2;
   FEdit.Text := FloatToStr(ValorInicial);
   FFloatEdit := TFloatEdit.Create(FEdit, true);
   CheckEquals(ValorArredondado, FFloatEdit.Value);
end;

procedure TestTFloatEdit.SomenteInteirosNaoDeveAlterarCentavos;
var
  ValorInicial, ProximoValor: double;
begin
   ValorInicial :=  100.00;
   ProximoValor := 1001.00;
   FEdit.Text := FloatToStr(ValorInicial);
   FFloatEdit := TFloatEdit.Create(FEdit, true);
   SendMessage(FEdit.Handle, WM_CHAR, ord('1'), 0);
   CheckEquals(ProximoValor, FFloatEdit.Value);
end;

procedure TestTFloatEdit.DigitoDeveAcrescentarCasasDecimais;
var
  ValorInicial, ProximoValor: double;
begin
   ValorInicial :=  1.99;
   ProximoValor := 19.901;
   FEdit.Text := FloatToStr(ValorInicial);
   FFloatEdit := TFloatEdit.Create(FEdit, false, 3);
   SendMessage(FEdit.Handle, WM_CHAR, ord('1'), 0);
   CheckEquals(ProximoValor, FFloatEdit.Value);
end;

procedure TestTFloatEdit.DigitoDeveAcrescentarCentavos;
var
  ValorInicial, ProximoValor: double;
begin
   ValorInicial :=  1.99;
   ProximoValor := 19.91;
   FEdit.Text := FloatToStr(ValorInicial);
   FFloatEdit := TFloatEdit.Create(FEdit);
   SendMessage(FEdit.Handle, WM_CHAR, ord('1'), 0);
   CheckEquals(ProximoValor, FFloatEdit.Value);
end;

procedure TestTFloatEdit.FormatacaoComCasasDecimaisDiferenteDoPadrao;
var
  ValorInicial: double;
begin
   ValorInicial := 1.9999;
   FEdit.Text := FloatToStr(ValorInicial);
   FFloatEdit := TFloatEdit.Create(FEdit, false, 3);
   CheckEquals('2,000', FEdit.Text);   
end;

procedure TestTFloatEdit.FormatacaoPadraoCom2CasasDecimais;
var
  ValorInicial: double;
begin
   ValorInicial := 100.00;
   FEdit.Text := FloatToStr(ValorInicial);
   FFloatEdit := TFloatEdit.Create(FEdit);
   CheckEquals('100,00', FEdit.Text);
end;

procedure TestTFloatEdit.FormatacaoSemCasasDecimaisDeveArredondar;
var
  ValorInicial, ValorArredondado: double;
begin
   ValorInicial := 1.99;
   ValorArredondado := 2;
   FEdit.Text := FloatToStr(ValorInicial);
   FFloatEdit := TFloatEdit.Create(FEdit, false, 0);
   CheckEquals(ValorArredondado, FFloatEdit.Value);
end;

procedure TestTFloatEdit.FormatacaoSemCasasDecimaisNaoDeveAlterarCentavos;
var
  ValorInicial, ProximoValor: double;
begin
   ValorInicial := 1.99;
   ProximoValor := 21;
   FEdit.Text := FloatToStr(ValorInicial);
   FFloatEdit := TFloatEdit.Create(FEdit, false, 0);
   SendMessage(FEdit.Handle, WM_CHAR, ord('1'), 0);
   CheckEquals(ProximoValor, FFloatEdit.Value);
end;

procedure TestTFloatEdit.OutrasTeclasDevemSerIgnoradas;
var
  ValorInicial: double;
begin
   ValorInicial := 1.99;
   FEdit.Text := FloatToStr(ValorInicial);
   FFloatEdit := TFloatEdit.Create(FEdit);
   SendMessage(FEdit.Handle, WM_CHAR, ord('a'), 0);
   CheckEquals(ValorInicial, FFloatEdit.Value);
end;

procedure TestTFloatEdit.TextoAlteradoDeveAtualizarValor;
var
  ValorInicial, ValorAlterado: double;
begin
   ValorInicial := 123.46;
   ValorAlterado := 999;
   FEdit.Text := FloatToStr(ValorInicial);
   FFloatEdit := TFloatEdit.Create(FEdit);
   FEdit.Text := FloatToStr(ValorAlterado);
   CheckEquals(ValorAlterado, FFloatEdit.Value);
end;

procedure TestTFloatEdit.ValorInicialDeveSerIgualAoValorDoEdit;
var
  Valor: double;
begin
   Valor := 123.45;
   FEdit.Text := FloatToStr(Valor);
   FFloatEdit := TFloatEdit.Create(FEdit);
   CheckEquals(Valor, FFloatEdit.Value);
end;

procedure TestTFloatEdit.ValorInicialInvalidoDeveRetornarZero;
begin
   FEdit.Text := 'teste';
   FFloatEdit := TFloatEdit.Create(FEdit);
   CheckEquals(0, FFloatEdit.Value);
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTFloatEdit.Suite);
end.

