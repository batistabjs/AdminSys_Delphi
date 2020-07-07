unit unt_configempresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, System.Actions, Vcl.ActnList,
  Vcl.CategoryButtons, System.ImageList, Vcl.ImgList;

type
  Tfrm_configempresa = class(TForm)
    panel_top: TPanel;
    panel_maximize: TPanel;
    panel_top_conteudo: TPanel;
    btn_close: TImage;
    btn_maximize: TImage;
    btn_minimize: TImage;
    btn_bug: TImage;
    Label1: TLabel;
    panel_bottom: TPanel;
    Image5: TImage;
    panel_conteudo: TPanel;
    procedure btn_closeClick(Sender: TObject);
    procedure panel_maximizeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_configempresa: Tfrm_configempresa;

implementation

{$R *.dfm}

uses unt_Main;

procedure Tfrm_configempresa.btn_closeClick(Sender: TObject);
begin
  frm_configempresa.close;
end;

procedure Tfrm_configempresa.FormCreate(Sender: TObject);
begin
  Left:=(Screen.Width-Width)  div 2;
  Top:=(Screen.Height-Height) div 2;
end;

procedure Tfrm_configempresa.panel_maximizeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  SendMessage(frm_configempresa.Handle, WM_SYSCOMMAND, 61458, 0) ;
end;

initialization
  RegisterClass(Tfrm_configempresa);
finalization
  UnRegisterClass(Tfrm_configempresa);

end.
