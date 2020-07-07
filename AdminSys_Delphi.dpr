program AdminSys_Delphi;

uses
  Vcl.Forms,
  unt_Main in 'unt_Main.pas' {frm_main},
  unt_configempresa in 'unt_configempresa.pas' {frm_configempresa};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_main, frm_main);
  Application.Run;
end.
