unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  Flag: Boolean = False;
  Test: Boolean;
  Input: Real;

implementation

{$R *.lfm}

{ TForm1 }

function c2f(c: real): real;
begin
     result := c * 9 / 5 + 32;
end;

function f2c(f: real): real;
begin
     result := (f - 32) * 5 / 9;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
     if (Flag = False) then
        begin
             Test := TryStrToFloat(Edit1.Caption, Input);
             if (Test = False) then exit;
             Flag := True;
             Edit2.Caption := FloatToStr(c2f(Input));
             exit;
        end;
        Flag := False;
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
     if (Flag = False) then
        begin
             Test := TryStrToFloat(Edit2.Caption, Input);
             if (Test = False) then exit;
             Flag := True;
             Edit1.Caption := FloatToStr(f2c(Input));
             exit;
        end;
        Flag := False;
end;

end.

