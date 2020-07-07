object frm_padrao: Tfrm_padrao
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Sistema de Gest'#227'o'
  ClientHeight = 504
  ClientWidth = 730
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object panel_central: TPanel
    Left = 0
    Top = 105
    Width = 730
    Height = 378
    Align = alClient
    BevelOuter = bvNone
    Caption = 'div_windows'
    Color = clBtnShadow
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 1215
    ExplicitHeight = 517
    object panel_conteudo: TPanel
      Left = 0
      Top = 0
      Width = 730
      Height = 378
      Align = alClient
      BevelOuter = bvNone
      Caption = 'div_conteudo'
      TabOrder = 0
      ExplicitWidth = 1121
      ExplicitHeight = 517
    end
  end
  object panel_top: TPanel
    Left = 0
    Top = 25
    Width = 730
    Height = 80
    Align = alTop
    BevelOuter = bvNone
    Caption = 'panel_top'
    Color = clBtnShadow
    ParentBackground = False
    TabOrder = 1
    ExplicitWidth = 1215
    object panel_top_conteudo: TPanel
      Left = 0
      Top = 0
      Width = 730
      Height = 80
      Align = alClient
      BevelOuter = bvNone
      Caption = 'panel_top_conteudo'
      Color = 3487029
      ParentBackground = False
      TabOrder = 0
      ExplicitHeight = 65
    end
  end
  object panel_maximize: TPanel
    Left = 0
    Top = 0
    Width = 730
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    Caption = 'panel_maximize'
    Color = clMenuHighlight
    ParentBackground = False
    TabOrder = 2
    OnMouseDown = panel_maximizeMouseDown
    ExplicitWidth = 1215
    object btn_close: TImage
      Left = 690
      Top = 0
      Width = 40
      Height = 25
      Align = alRight
      Center = True
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000150000
        00140806000000624B7633000000017352474200AECE1CE90000015249444154
        78DABD954D2B445118C7CF6390298A051FC06676B29215C94B439289854C498A
        92351F82B5142529B2604C43C6CB94B2D2ACA6D9F90A3614651A2FD7EF70D4E9
        BA26C661EAD7FFCC799EE757D33D73AE789ED7AC94DA806911B952657EF04488
        359814BE9CB1E8816BE8459C2F43D842684F1364B4B491C529B4C20D4411677F
        206C238EA10172D027A6504FA4A11DEE6010F1C537841DC421D4C125F433772B
        56432D91822E7880180D27258451220161388721FAEF754D7C8D35C41E0C4011
        C668DC0F10C6881DA8862318A1AFF0519780812A621B46E1E9ED698A6C59F5B8
        7A3F2D95B00BE3D41F6DC727A9190C11EB30012F30CBE02AFB33AC57A0023661
        8AFD67FF7CA0D488756D590BCD561286CD5A8BE7107A41B35F4A2DF922316F6D
        2D215B2835F3BF52E73FDFF983727EA49C1F7EE77FD35F5C289DC481F25F287F
        72F5B19961D1AD1C5FD2CE5F27AF29FDCDE764E05C1D0000000049454E44AE42
        6082}
      Proportional = True
      OnClick = btn_closeClick
      ExplicitLeft = 1190
    end
    object btn_maximize: TImage
      Left = 650
      Top = 0
      Width = 40
      Height = 25
      Align = alRight
      Center = True
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000150000
        00140806000000624B7633000000017352474200AECE1CE90000005649444154
        78DA63644003FFFFFF3F03A48C1928008CF436D4979191710BB10601F54902A9
        67B43314C8F94F895781E02CD07213BA1A2A05947C4E82777D80D4E65143470D
        1D22866280416B28D8FB7435945C401F430143C2CBD52D9FB3D6000000004945
        4E44AE426082}
      Proportional = True
      OnClick = btn_maximizeClick
      ExplicitLeft = 1152
    end
    object btn_minimize: TImage
      Left = 610
      Top = 0
      Width = 40
      Height = 25
      Align = alRight
      Center = True
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000150000
        00020806000000B7C497B5000000017352474200AECE1CE90000001249444154
        78DA63FC0F040C54068CB4301400E5EE07FB5FD4C2ED0000000049454E44AE42
        6082}
      Proportional = True
      OnClick = btn_minimizeClick
      ExplicitLeft = 1114
    end
    object btn_bug: TImage
      Left = 570
      Top = 0
      Width = 40
      Height = 25
      Align = alRight
      Center = True
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000140000
        001408060000008D891D0D000000017352474200AECE1CE9000000C649444154
        78DA63FC0F040C54048C34339011082831086E0EB28140263B90690564EE872A
        720452C780FC9F503E4E790C03818005883703B11B104743C59602F12E20F685
        F2F1C9FFC1E6C27A20B30188FF42353083F840A946A88B70CA63F53254D36A20
        1502D5B006281C8A165658E57185610490B9046A3303D425D140A995504D38E5
        7185E15920D6877A8B014A5F046263281F9F3CD63014057907C89C0E755126D4
        5BAFA17C9CF238C390AAE9902606929A15D1F5D1DEC0C11F8683D7406A01AA1B
        0800731CE3C53897222E0000000049454E44AE426082}
      Proportional = True
      OnClick = btn_bugClick
      ExplicitLeft = 1072
    end
    object Image5: TImage
      Left = 0
      Top = 0
      Width = 40
      Height = 25
      Align = alLeft
      Center = True
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000140000
        001408060000008D891D0D000000017352474200AECE1CE9000000C649444154
        78DA63FC0F040C54048C34339011082831086E0EB28140263B90690564EE872A
        720452C780FC9F503E4E790C03818005883703B11B104743C59602F12E20F685
        F2F1C9FFC1E6C27A20B30188FF42353083F840A946A88B70CA63F53254D36A20
        1502D5B006281C8A165658E57185610490B9046A3303D425D140A995504D38E5
        7185E15920D6877A8B014A5F046263281F9F3CD63014057907C89C0E755126D4
        5BAFA17C9CF238C390AAE9902606929A15D1F5D1DEC0C11F8683D7406A01AA1B
        0800731CE3C53897222E0000000049454E44AE426082}
      Proportional = True
      ExplicitLeft = -13
    end
    object Label1: TLabel
      Left = 40
      Top = 0
      Width = 123
      Height = 25
      Align = alLeft
      Caption = 'Sistema de Gest'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 18
    end
  end
  object panel_bottom: TPanel
    Left = 0
    Top = 483
    Width = 730
    Height = 21
    Align = alBottom
    BevelOuter = bvNone
    Color = 3487029
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
    ExplicitTop = 622
    ExplicitWidth = 1215
  end
end
