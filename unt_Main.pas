{***********************************************************************************
**  SISTEMA........: AdminSys_Delphi - Tela Admin para uso em Sistemas Delphi     **
**  USO............: Liberado para cópia e alteração                                 **
**  LINGUAGEM......: Delphi 10.3 Rio / Componentes Nativos                 **
** ------------------------------------------------------------------------------ **
**  DESENVOLVEDOR..: Bruno Batista                                         **
**  E-MAIL.........: batista.bjs@gmail.com                                 **** ------------------------------------------------------------------------------ *************************************************************************************}

unit unt_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, System.Actions, Vcl.ActnList,
  Vcl.CategoryButtons, System.ImageList, Vcl.ImgList, Vcl.Menus,
  Vcl.Imaging.jpeg, System.JSON, IdHTTP, dxGDIPlusClasses,
  IniFiles;

type
  Tfrm_main = class(TForm)
    panel_central: TPanel;
    panel_conteudo: TPanel;
    panel_img_centro: TPanel;
    img_centro: TImage;
    panel_top: TPanel;
    panel_maximize: TPanel;
    panel_img: TPanel;
    img_logo: TImage;
    panel_top_conteudo: TPanel;
    panel_bottom: TPanel;
    sp_menu: TSplitView;
    al_menu_main: TActionList;
    ImageList: TImageList;
    cb_menu_main: TCategoryButtons;
    act_favoritos: TAction;
    act_base: TAction;
    act_financeiro: TAction;
    act_estoque: TAction;
    act_vendas: TAction;
    act_entregas: TAction;
    panel_user_config: TPanel;
    img_user: TImage;
    lb_user: TLabel;
    lb_name_user: TLabel;
    lb_hora: TLabel;
    lb_data: TLabel;
    lb_server: TLabel;
    lb_on_offline: TLabel;
    lb_cidade: TLabel;
    sp_sec: TSplitView;
    al_menu_base: TActionList;
    cb_menu_sec: TCategoryButtons;
    pessoa_fisica: TAction;
    pessoa_juridica: TAction;
    config_empresa: TAction;
    user_sistema: TAction;
    grupos_usuario: TAction;
    al_menu_favoritos: TActionList;
    ac_add_favorito: TAction;
    al_financeiro: TActionList;
    ac_contaspagar: TAction;
    ac_contasreceber: TAction;
    ac_configfinanceira: TAction;
    ac_movimentacoes: TAction;
    ac_relatorios: TAction;
    tm_hora: TTimer;
    img_config: TImage;
    PopupMenu1: TPopupMenu;
    Configuraes1: TMenuItem;
    Sair1: TMenuItem;
    img_info: TImage;
    img_notification: TImage;
    PopupMenu2: TPopupMenu;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    PopupMenu3: TPopupMenu;
    MenuItem9: TMenuItem;
    MenuItem10: TMenuItem;
    img_clima: TImage;
    Label1: TLabel;
    Label2: TLabel;
    lbtempo_condition: TLabel;
    tm_clima: TTimer;
    lb_temperatura: TLabel;
    sp_sub: TSplitView;
    cb_menu_sub: TCategoryButtons;
    panel_hora: TPanel;
    panel_clima: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure panel_maximizeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure img_logoClick(Sender: TObject);
    procedure act_favoritosExecute(Sender: TObject);
    procedure tm_horaTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cb_menu_mainHotButton(Sender: TObject; const Button: TButtonItem);
    procedure panel_conteudoClick(Sender: TObject);
    procedure cb_menu_secHotButton(Sender: TObject; const Button: TButtonItem);
    procedure cb_menu_secClick(Sender: TObject);
    procedure img_configClick(Sender: TObject);
    procedure img_notificationClick(Sender: TObject);
    procedure img_infoClick(Sender: TObject);
    procedure tm_climaTimer(Sender: TObject);
    procedure cb_menu_subHotButton(Sender: TObject; const Button: TButtonItem);
    procedure cb_menu_subClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_main: Tfrm_main;
  button_menu_sec, button_menu_sub: TButtonItem;
  //variaveis do arquivo ini
  cidade_cod, clima_url, clima_dir : string;

implementation

{$R *.dfm}

uses unt_configempresa;

//form create: responsável por capturar variáveis setadas no arquivo config.ini
//o arquivo config.ini está no mesmo diretório da aplicação
procedure Tfrm_main.FormCreate(Sender: TObject);
var
  ArquivoINI: TIniFile;
  Mensagem : string;
begin
  //centraliza o form antes do Show na tela baseado no monitor
  Left:=(Screen.Width-Width)  div 2;
  Top:=(Screen.Height-Height) div 2;

  try
    try
      ArquivoINI := TIniFile.Create(ExtractFilePath(Application.ExeName)+'config.ini');
      cidade_cod := ArquivoINI.ReadString('cidade', 'codigo', 'Erro ao ler o valor cod cidade');
      clima_url := ArquivoINI.ReadString('clima', 'clima_url', 'Erro ao ler o valor url clima');
      clima_dir := ArquivoINI.ReadString('clima', 'clima_dir', 'Erro ao ler o valor dir clima');

    finally
      ArquivoINI.Free;
    end;

  except
    on E : Exception do
    begin
      ShowMessage('Erro ao abrir arquivo de Configuração' + sLineBreak + E.ClassName + sLineBreak + E.Message);
    end;
end;

procedure Tfrm_main.FormShow(Sender: TObject);
begin
  tm_hora.OnTimer(Self);  //setado para 15 segundos
  tm_clima.OnTimer(Self); //setado para 30 minutos
end;

//timer responsavel por atualizar os labels de hora e data
procedure Tfrm_main.tm_horaTimer(Sender: TObject);
begin
  lb_hora.Caption:=formatdatetime('hh:mm',now);
  lb_data.Caption:=formatdatetime('dd/mm/yyyy',now);
  //if server off lb_on_offline.caption:='Offline';  lb_on_offline.caption:='Online';
end;

//timer responsavel pela conexão a API do Clima Tempo e capturar dados do clima
procedure Tfrm_main.tm_climaTimer(Sender: TObject);
var
  idhttp1: TIdHTTP;
  json: string;
  obj: TJSONObject;
  data: TJSONValue;
  id_img_clima, temperatura: string;
  png: TPngImage;
begin
  IdHTTP1 := TIdHTTP.Create;
  try
    try
      //criação do request a API (uso necessário do atributo UserAgent)
      IdHTTP1.Request.UserAgent := 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0';
      //popula o json com os dados vindos da API
      json := IdHTTP1.Get(clima_url);
    finally
      IdHTTP1.Free;
    end;

    //Parse e Encode do Json para faciliar a captura de valores
    obj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(json),0) as TJSONObject;

    //captura dos dados relacionados a cidade e estado
    lb_cidade.Caption := obj.GetValue<string>('name')+'/'+obj.GetValue<string>('state');
    //dados relaciondos ao clima do atributo 'data'
    data := obj.Get('data').JsonValue;

    if data = nil then raise Exception.Create('Error parsing JSON');
    try
      //preenchimento dos labels e imgs do Form relacinados ao clima
      temperatura:= data.GetValue<string>('temperature');
      if temperatura.Length>2 then begin
        lb_temperatura.Caption := temperatura.Remove(temperatura.Length-2)+'º';
      end else begin
        lb_temperatura.Caption := temperatura+'º';
      end;
      lbtempo_condition.Caption := data.GetValue<string>('condition');
      id_img_clima:= data.GetValue<string>('icon');

      png := TPNGImage.Create;
      try
        png.LoadFromFile(ExtractFilePath(Application.ExeName)+clima_dir+'/'+id_img_clima+'.png');
        img_clima.Picture.Assign(png);
      finally
        png.Free;
      end;
    finally
      obj.Free;
    end;
  except
    on E : Exception do
    begin
      ShowMessage('Error' + sLineBreak + E.ClassName + sLineBreak + E.Message);
    end;
  end;
end;

procedure Tfrm_main.act_favoritosExecute(Sender: TObject);
begin
  //Showmessage('Em construção');
end;

//Popula o menu lateral Principal. O uso dos arrays é temporário (somente para os testes)
procedure Tfrm_main.cb_menu_mainHotButton(Sender: TObject;
  const Button: TButtonItem);
const
  array_favoritos: array[0..0] of string = ('Inserir Favorito');
  array_favoritos_hint: array[0..0] of string = ('frm_favoritos');
  array_vendas: array[0..3] of string = ('','Nova','Listar','Ajustes');
  array_vendas_hint: array[0..3] of string = ('','frm_novavenda','frm_listarvenda','frm_ajustesvenda');
  array_faturamento: array[0..5] of string = ('','','Lançar','Importar','Exportar','Config. NF-E');
  array_faturamento_hint: array[0..5] of string = ('','','frm_lancarnfe','frm_importarnfe','frm_exportarnfe','frm_confignfe');
  array_financeiro: array[0..5] of string = ('','','','Caixa','Contas a Pagar','Contas a Receber');
  array_financeiro_hint: array[0..5] of string = ('','','','frm_caixa','frm_contaspagar','frm_contasreceber');
  array_estoque: array[0..6] of string = ('','','','','Produtos','Categorias','Ajustes');
  array_estoque_hint: array[0..6] of string = ('','','','','frm_produtos','frm_categorias','frm_ajustes');
  array_compras: array[0..7] of string = ('','','','','','Nova','Listar','Ajustes');
  array_compras_hint: array[0..7] of string = ('','','','','','frm_novavenda','frm_listarvenda','frm_ajustesvenda');
  array_transporte: array[0..8] of string = ('','','','','','','Listar','Categorias','Setores');
  array_transporte_hint: array[0..8] of string = ('','','','','','','frm_entregas','frm_entregascategoria','frm_entregascategoria');
  array_base: array[0..4] of string = ('Pessoa Física','Pessoa Jurídica','Funcionários','Usuários','Config. Empresa');
  array_base_hint: array[0..4] of string = ('frm_pessoafisica','frm_pessoajuridica','frm_funcionarios','frm_usuarios','frm_configempresa');
var
  I: Integer;
begin
   sp_sec.Open;

   if Assigned(Button) then
   begin
      cb_menu_sec.Categories[0].Index:=0;
      while cb_menu_sec.Categories[0].Items.Count > 0 do begin
        cb_menu_sec.Categories[0].Items.Delete(0);
      end;

      if Button.Hint = 'Favoritos' then begin
          for I := 0 to High(array_favoritos) do begin
            cb_menu_sec.Categories[0].Items.Add;
            cb_menu_sec.Categories[0].Items[I].Caption:=array_favoritos[I];
            cb_menu_sec.Categories[0].Items[I].Hint:=array_favoritos[I];
          end;
      end
      else if Button.Hint = 'Vendas' then begin
          for I := 0 to High(array_vendas) do begin
            cb_menu_sec.Categories[0].Items.Add;
            cb_menu_sec.Categories[0].Items[I].Caption:=array_vendas[I];
            cb_menu_sec.Categories[0].Items[I].hint:=array_vendas_hint[I];
          end;
      end
      else if Button.Hint = 'Faturamento' then begin
          for I := 0 to High(array_faturamento) do begin
            cb_menu_sec.Categories[0].Items.Add;
            cb_menu_sec.Categories[0].Items[I].Caption:=array_faturamento[I];
            cb_menu_sec.Categories[0].Items[I].hint:=array_faturamento_hint[I];
          end;
      end
      else if Button.Hint = 'Financeiro' then begin
          for I := 0 to High(array_financeiro) do begin
            cb_menu_sec.Categories[0].Items.Add;
            cb_menu_sec.Categories[0].Items[I].Caption:=array_financeiro[I];
            cb_menu_sec.Categories[0].Items[I].hint:=array_financeiro_hint[I];
          end;
      end
      else if Button.Hint = 'Estoque' then begin
          for I := 0 to High(array_estoque) do begin
            cb_menu_sec.Categories[0].Items.Add;
            cb_menu_sec.Categories[0].Items[I].Caption:=array_estoque[I];
            cb_menu_sec.Categories[0].Items[I].hint:=array_estoque_hint[I];
          end;
      end
      else if Button.Hint = 'Compras' then begin
          for I := 0 to High(array_compras) do begin
            cb_menu_sec.Categories[0].Items.Add;
            cb_menu_sec.Categories[0].Items[I].Caption:=array_compras[I];
            cb_menu_sec.Categories[0].Items[I].hint:=array_compras_hint[I];
          end;
      end
      else if Button.Hint = 'Transporte' then begin
          for I := 0 to High(array_transporte) do begin
            cb_menu_sec.Categories[0].Items.Add;
            cb_menu_sec.Categories[0].Items[I].Caption:=array_transporte[I];
            cb_menu_sec.Categories[0].Items[I].hint:=array_transporte_hint[I];
          end;
      end
      else begin //if Button.Hint = 'Base' then begin
          for I := 0 to High(array_base) do begin
            cb_menu_sec.Categories[0].Items.Add;
            cb_menu_sec.Categories[0].Items[I].Caption:=array_base[I];
            cb_menu_sec.Categories[0].Items[I].hint:=array_base_hint[I];
          end;
      end
  end;
end;

procedure Tfrm_main.cb_menu_secClick(Sender: TObject);
var
  TClasse : TPersistentClass;
  FrmClass: TFormClass;
  Frm: TForm;
  NomeFrm: string;
begin
  NomeFrm:= button_menu_sec.Hint;
  {TClasse := GetClass('T'+NomeFrm);
  if (TClasse <> nil) and TClasse.InheritsFrom(TForm) then
    Frm:= TFormClass(TClasse).Create(nil);}

  Frm:=TForm(findclass('T'+NomeFrm)).create(self);

  if Assigned(Frm) then begin
    With Frm do
    try
      sp_sec.Close;
      Frm.ShowModal;
    finally
      Free;
    end;
  end
  else
  begin
    MessageDlg('Formulário '+button_menu_sec.Caption+' não encontrado!', mtError, [mbOK], 0)
  end;
end;

procedure Tfrm_main.cb_menu_secHotButton(Sender: TObject;
  const Button: TButtonItem);
const
  array_favoritos: array[0..0] of string = ('Inserir Favorito');
  array_favoritos_hint: array[0..0] of string = ('frm_favoritos');
  array_vendas: array[0..3] of string = ('','Nova','Listar','Ajustes');
  array_vendas_hint: array[0..3] of string = ('','frm_novavenda','frm_listarvenda','frm_ajustesvenda');
  array_faturamento: array[0..5] of string = ('','','Lançar','Importar','Exportar','Config. NF-E');
  array_faturamento_hint: array[0..5] of string = ('','','frm_lancarnfe','frm_importarnfe','frm_exportarnfe','frm_confignfe');
  array_financeiro: array[0..5] of string = ('','','','Caixa','Contas a Pagar','Contas a Receber');
  array_financeiro_hint: array[0..5] of string = ('','','','frm_caixa','frm_contaspagar','frm_contasreceber');
  array_estoque: array[0..6] of string = ('','','','','Produtos','Categorias','Ajustes');
  array_estoque_hint: array[0..6] of string = ('','','','','frm_produtos','frm_categorias','frm_ajustes');
  array_compras: array[0..7] of string = ('','','','','','Nova','Listar','Ajustes');
  array_compras_hint: array[0..7] of string = ('','','','','','frm_novavenda','frm_listarvenda','frm_ajustesvenda');
  array_transporte: array[0..8] of string = ('','','','','','','Listar','Categorias','Setores');
  array_transporte_hint: array[0..8] of string = ('','','','','','','frm_entregas','frm_entregascategoria','frm_entregascategoria');
  array_base: array[0..4] of string = ('Pessoa Física','Pessoa Jurídica','Funcionários','Usuários','Config. Empresa');
  array_base_hint: array[0..4] of string = ('frm_pessoafisica','frm_pessoajuridica','frm_funcionarios','frm_usuarios','frm_configempresa');
var
  I: Integer;
begin
   sp_sub.Open;

   if Assigned(Button) then
   begin
      cb_menu_sub.Categories[0].Index:=0;
      while cb_menu_sub.Categories[0].Items.Count > 0 do begin
        cb_menu_sub.Categories[0].Items.Delete(0);
      end;

      if Button.Caption = 'Pessoa Física' then begin
          for I := 0 to High(array_favoritos) do begin
            cb_menu_sub.Categories[0].Items.Add;
            cb_menu_sub.Categories[0].Items[I].Caption:=array_favoritos[I];
            cb_menu_sub.Categories[0].Items[I].Hint:=array_favoritos[I];
          end;
      end
      else if Button.Hint = 'Vendas' then begin
          for I := 0 to High(array_vendas) do begin
            cb_menu_sub.Categories[0].Items.Add;
            cb_menu_sub.Categories[0].Items[I].Caption:=array_vendas[I];
            cb_menu_sub.Categories[0].Items[I].hint:=array_vendas_hint[I];
          end;
      end
      else if Button.Hint = 'Faturamento' then begin
          for I := 0 to High(array_faturamento) do begin
            cb_menu_sub.Categories[0].Items.Add;
            cb_menu_sub.Categories[0].Items[I].Caption:=array_faturamento[I];
            cb_menu_sub.Categories[0].Items[I].hint:=array_faturamento_hint[I];
          end;
      end
      else if Button.Hint = 'Financeiro' then begin
          for I := 0 to High(array_financeiro) do begin
            cb_menu_sub.Categories[0].Items.Add;
            cb_menu_sub.Categories[0].Items[I].Caption:=array_financeiro[I];
            cb_menu_sub.Categories[0].Items[I].hint:=array_financeiro_hint[I];
          end;
      end
      else if Button.Hint = 'Estoque' then begin
          for I := 0 to High(array_estoque) do begin
            cb_menu_sub.Categories[0].Items.Add;
            cb_menu_sub.Categories[0].Items[I].Caption:=array_estoque[I];
            cb_menu_sub.Categories[0].Items[I].hint:=array_estoque_hint[I];
          end;
      end
      else if Button.Hint = 'Compras' then begin
          for I := 0 to High(array_compras) do begin
            cb_menu_sub.Categories[0].Items.Add;
            cb_menu_sub.Categories[0].Items[I].Caption:=array_compras[I];
            cb_menu_sub.Categories[0].Items[I].hint:=array_compras_hint[I];
          end;
      end
      else if Button.Hint = 'Transporte' then begin
          for I := 0 to High(array_transporte) do begin
            cb_menu_sub.Categories[0].Items.Add;
            cb_menu_sub.Categories[0].Items[I].Caption:=array_transporte[I];
            cb_menu_sub.Categories[0].Items[I].hint:=array_transporte_hint[I];
          end;
      end
      else begin //if Button.Hint = 'Base' then begin
          for I := 0 to High(array_base) do begin
            cb_menu_sub.Categories[0].Items.Add;
            cb_menu_sub.Categories[0].Items[I].Caption:=array_base[I];
            cb_menu_sub.Categories[0].Items[I].hint:=array_base_hint[I];
          end;
      end
  end;

   if Assigned(Button) then
   begin
     button_menu_sub:=Button;

     if button_menu_sec.Caption='' then begin
       cb_menu_sub.HotButtonColor:=$00707070;
       //cb_menu_sec.RegularButtonColor:=$00707070;
       //cb_menu_sec.SelectedButtonColor:=$00707070;
     end
     else
     begin
       cb_menu_sub.HotButtonColor:=$00FE8E67;
       cb_menu_sub.RegularButtonColor:=clNone;
       cb_menu_sub.SelectedButtonColor:=clHotLight;
     end;
   end;
end;

procedure Tfrm_main.cb_menu_subClick(Sender: TObject);
var
  TClasse : TPersistentClass;
  FrmClass: TFormClass;
  Frm: TForm;
  NomeFrm: string;
begin
  NomeFrm:= button_menu_sub.Hint;
  {TClasse := GetClass('T'+NomeFrm);
  if (TClasse <> nil) and TClasse.InheritsFrom(TForm) then
    Frm:= TFormClass(TClasse).Create(nil);}

  Frm:=TForm(findclass('T'+NomeFrm)).create(self);

  if Assigned(Frm) then begin
    With Frm do
    try
      sp_sub.Close;
      Frm.ShowModal;
    finally
      Free;
    end;
  end
  else
  begin
    MessageDlg('Formulário '+button_menu_sub.Caption+' não encontrado!', mtError, [mbOK], 0)
  end;
end;

procedure Tfrm_main.cb_menu_subHotButton(Sender: TObject;
  const Button: TButtonItem);
begin
   if Assigned(Button) then
   begin
     button_menu_sub:=Button;

     if button_menu_sec.Caption='' then begin
       cb_menu_sub.HotButtonColor:=$00707070;
       //cb_menu_sec.RegularButtonColor:=$00707070;
       //cb_menu_sec.SelectedButtonColor:=$00707070;
     end
     else
     begin
       cb_menu_sub.HotButtonColor:=$00FE8E67;
       cb_menu_sub.RegularButtonColor:=clNone;
       cb_menu_sub.SelectedButtonColor:=clHotLight;
     end;
   end;
end;

end;

procedure Tfrm_main.img_configClick(Sender: TObject);
var
  p: TPoint;
begin
  p:= img_config.ClientToScreen(Point(0,img_config.Height));
  PopupMenu1.Popup(p.X,p.Y);
end;

procedure Tfrm_main.img_infoClick(Sender: TObject);
var
  p: TPoint;
begin
  p:= img_info.ClientToScreen(Point(0,img_info.Height));
  PopupMenu2.Popup(p.X,p.Y);
end;

procedure Tfrm_main.img_logoClick(Sender: TObject);
begin
  if sp_menu.Opened then
    sp_menu.Close
  else
    sp_menu.Open;
end;

procedure Tfrm_main.img_notificationClick(Sender: TObject);
var
  p: TPoint;
begin
  p:= img_notification.ClientToScreen(Point(0,img_notification.Height));
  PopupMenu3.Popup(p.X,p.Y);
end;

procedure Tfrm_main.panel_conteudoClick(Sender: TObject);
begin
  //rotina para fechar os menus laterais quando clicar no panel central da janela Admin
  if sp_sec.Opened then
    sp_sec.Close;
  if sp_sub.Opened then
    sp_sub.Close;
end;

procedure Tfrm_main.panel_maximizeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  SendMessage(frm_main.Handle, WM_SYSCOMMAND, 61458, 0) ;
end;



end.
