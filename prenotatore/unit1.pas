unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ActnList, LCLType;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
  private

  public
    procedure validate(sender: Tobject);
    procedure prenotare(sender: Tobject);
    function dates_are_sorted(sender: Tobject): Boolean;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}


{ TForm1 }

procedure TForm1.Edit1Change(Sender: TObject);
begin
  validate(Sender);
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
  validate(Sender);
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  validate(Sender);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  prenotare(Sender);
end;

function TForm1.dates_are_sorted(sender: Tobject): Boolean;
var
  date1: TDateTime;
  date2: TDateTime;
  is_valid: Boolean;
begin
  FormatSettings.ShortDateFormat := 'dd.mm.yyyy';
  FormatSettings.DateSeparator := '.';
  is_valid := TryStrToDate(Edit1.text, date1, FormatSettings);
  if (not is_valid) then
  begin
       result := false;
       exit;
  end;
  is_valid := TryStrToDate(Edit2.text, date2, FormatSettings);
  if (not is_valid) then
  begin
    result := false;
    exit;
  end;
  result := date1 <= date2;
end;

procedure TForm1.validate(sender: Tobject);
var
  date: TDateTime;
  is_valid: Boolean;
begin
  FormatSettings.ShortDateFormat := 'dd.mm.yyyy';
  FormatSettings.DateSeparator := '.';
  is_valid := TryStrToDate(Edit1.text, date, FormatSettings);
  if (not is_valid) then
       Edit1.color := clRed
  else
       Edit1.color := clDefault;
  is_valid := TryStrToDate(Edit2.text, date, FormatSettings);
  if (not is_valid) then
       Edit2.color := clRed
  else
       Edit2.color := clDefault;
  if (ComboBox1.text = 'volo di sola andata') then
     begin
          Button1.enabled := (not (Edit1.color = clRed));
          Edit2.enabled := false;
     end
  else if (ComboBox1.text = 'volo di ritorno') then
      begin
           Button1.enabled := (Edit1.color = clDefault) and (Edit2.color = clDefault) and (dates_are_sorted(sender));
           Edit2.enabled := true;
      end;
end;

procedure TForm1.prenotare(sender: Tobject);
var
  message: PChar;
  message_title: PChar;
begin
  message_title := 'Prenotatore di Voli';
  if (ComboBox1.text = 'volo di sola andata') then
      begin
      message := PChar(format('Ha prenotato un volo il %s.', [Edit1.text]));
      end
  else
      begin
      message := PChar(format('Ha prenotato un volo di andata e ritorno dal %s al %s.', [Edit1.text, Edit2.text]));
      end;
  Application.MessageBox(message, message_title, MB_ICONINFORMATION);
end;

end.

