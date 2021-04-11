unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ProgressBar1: TProgressBar;
    TrackBar1: TTrackBar;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public
    procedure Refresh(Sender: TObject; Increment: Boolean);
    procedure Reset(Sender: TObject);
end;

var
  Form1: TForm1;
  DECASECONDS: Integer;

implementation

{$R *.lfm}

function MapRange(n: real; a: real; b: real; y: real; z: real): real;
begin
     if ((b - a) + y = 0) then
     begin
         Result := 100;
         exit;
     end;
     Result := (n - a) * (z - y) / (b - a) + y;
end;

procedure TForm1.Refresh(Sender: TObject; Increment: Boolean);
var
  a: Real;
  b: Real;
  y: Real;
  z: Real;
  seconds: Real;
  percentage: Integer;
begin
  a := Real(TrackBar1.Min);
  b := Real(TrackBar1.Position);
  y := Real(ProgressBar1.Min);
  z := Real(ProgressBar1.Max);
  If (Increment = True) then
  begin
      if ((DECASECONDS / 10) < b) then
      begin
           DECASECONDS := DECASECONDS + 1;
      end;
  end;
  Seconds := Real(Real(DECASECONDS) / Real(10));
  Percentage := Round(MapRange(Seconds, a, b, y, z));
  ProgressBar1.Position := Percentage;
  DecimalSeparator := ',';
  Label2.Caption := Format('%2.1ns / %2.0ns', [Seconds, b]);
end;

procedure TForm1.Reset(Sender: TObject);
begin
  DECASECONDS := 0;
  Refresh(Sender, False);
end;

{ TForm1 }

procedure TForm1.Timer1Timer(Sender: TObject);
begin
   Refresh(Sender, true);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Reset(Sender);
end;

end.

