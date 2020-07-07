unit unt_padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, System.Actions, Vcl.ActnList,
  Vcl.CategoryButtons, System.ImageList, Vcl.ImgList;

type
  Tfrm_padrao = class(TForm)
    panel_central: TPanel;
    panel_conteudo: TPanel;
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
    procedure btn_minimizeClick(Sender: TObject);
    procedure btn_maximizeClick(Sender: TObject);
    procedure btn_closeClick(Sender: TObject);
    procedure btn_bugClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure panel_maximizeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure img_logoClick(Sender: TObject);
    procedure act_favoritosExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_main: Tfrm_padrao;

implementation

{$R *.dfm}

procedure Tfrm_main.btn_closeClick(Sender: TObject);
begin
  frm_main.Close;
end;

procedure Tfrm_padrao.panel_maximizeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
   SendMessage(frm_main.Handle, WM_SYSCOMMAND, 61458, 0) ;
end;

end.
