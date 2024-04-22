let
  color = ''
    [ColorScheme]
    active_colors=#ffc0caf5, #ff1a1b26, #ff373949, #ff2b2c3b, #ff1a1b26, #ff2b2c3b, #ffc0caf5, #ffc0caf5, #ffc0caf5, #ff1a1b26, #ff1a1b26, #19000000, #ff2b2c3b, #ffc0caf5, #ff3584e4, #ff1b6acb, #ff1a1b26, #ff242530, #ff1a1b26, #ffc0caf5, #ffc0caf5
    disabled_colors=#ff6d728d, #ff1a1b26, #ff373949, #ff2b2c3b, #ff1a1b26, #ff2b2c3b, #ff6d728d, #ff6d728d, #ff6d728d, #ff1a1b26, #ff1a1b26, #19000000, #ff2b2c3b, #ff6d728d, #ff3584e4, #ff1b6acb, #ff1a1b26, #ff242530, #ff1a1b26, #ff6d728d, #ff6d728d
    inactive_colors=#ff6d728d, #ff1a1b26, #ff373949, #ff2b2c3b, #ff1a1b26, #ff2b2c3b, #ff6d728d, #ff6d728d, #ff6d728d, #ff1a1b26, #ff1a1b26, #19000000, #ff2b2c3b, #ff6d728d, #ff3584e4, #ff1b6acb, #ff1a1b26, #ff242530, #ff1a1b26, #ff6d728d, #ff6d728d
  '';
  qss = ''
    QTabBar::tab:selected {
        color: palette(highlight);
    }
    QMenuBar, QMenu, QToolBar, QStatusBar, QFrame, QScrollBar {
        border: none;
    }
  '';
in
{
  xdg.configFile."qt5ct/colors/tokyonight.conf" = {
    text = "${color}";
  };
  xdg.configFile."qt6ct/colors/tokyonight.conf" = {
    text = "${color}";
  };
  xdg.configFile."qt5ct/qss/tab.qss" = {
    text = "${qss}";
  };
  xdg.configFile."qt6ct/qss/tab.qss" = {
    text = "${qss}";
  };
  xdg.configFile."qt5ct/qt5ct.conf" = {
    text =
      ''
        [Appearance]
        color_scheme_path=/home/dashie/.config/qt5ct/colors/tokyonight.conf
        custom_palette=true
        icon_theme=breeze
        standard_dialogs=default
        style=Breeze

        [Fonts]
        fixed="Noto Sans,12,-1,5,50,0,0,0,0,0"
        general="Noto Sans,12,-1,5,50,0,0,0,0,0"

        [Interface]
        activate_item_on_single_click=2
        buttonbox_layout=3
        cursor_flash_time=1000
        dialog_buttons_have_icons=0
        double_click_interval=400
        gui_effects=General, AnimateMenu, AnimateCombo, AnimateTooltip, AnimateToolBox
        keyboard_scheme=4
        menus_have_icons=true
        show_shortcuts_in_context_menus=true
        stylesheets=/home/dashie/.config/qt5ct/qss/tab.qss
        toolbutton_style=4
        underline_shortcut=0
        wheel_scroll_lines=3

        [PaletteEditor]
        geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\n\0\0\0\0\0\0\0\fv\0\0\x2\x10\0\0\n\0\0\0\0\0\0\0\fv\0\0\x2\x10\0\0\0\0\x2\0\0\0\rp\0\0\n\0\0\0\0\0\0\0\fv\0\0\x2\x10)

        [QSSEditor]
        geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\x2\x82\0\0\x1\xf2\0\0\0\0\0\0\0\0\0\0\x2\x82\0\0\x1\xf2\0\0\0\x2\x2\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\x2\x82\0\0\x1\xf2)

        [SettingsWindow]
        geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\n\0\0\0\0\0\0\0\r\x83\0\0\x2\x94\0\0\n\0\0\0\0\0\0\0\fO\0\0\x2\xbf\0\0\0\0\x2\0\0\0\rp\0\0\n\0\0\0\0\0\0\0\r\x83\0\0\x2\x94)

        [Troubleshooting]
        force_raster_widgets=1
        ignored_applications=@Invalid()
      '';
  };
  xdg.configFile."qt6ct/qt6ct.conf" = {
    text =
      ''
        [Appearance]
        color_scheme_path=/home/dashie/.config/qt6ct/colors/toykonight.conf
        custom_palette=true
        standard_dialogs=default
        style=Adwaita-Dark

        [Fonts]
        fixed="DejaVu LGC Sans,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
        general="DejaVu LGC Sans,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"

        [Interface]
        activate_item_on_single_click=2
        buttonbox_layout=3
        cursor_flash_time=1000
        dialog_buttons_have_icons=0
        double_click_interval=400
        gui_effects=General, AnimateMenu, AnimateCombo, AnimateTooltip, AnimateToolBox
        keyboard_scheme=4
        menus_have_icons=true
        show_shortcuts_in_context_menus=true
        stylesheets=@Invalid()
        toolbutton_style=4
        underline_shortcut=1
        wheel_scroll_lines=3

        [PaletteEditor]
        geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\x2\x30\0\0\x1\xf4\0\0\0\0\0\0\0\0\0\0\x2\x30\0\0\x1\xf4\0\0\0\0\0\0\0\0\a\x80\0\0\0\0\0\0\0\0\0\0\x2\x30\0\0\x1\xf4)

        [SettingsWindow]
        geometry="@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\x3\xec\0\0\x3,\0\0\0\0\0\0\0\0\0\0\x3\xec\0\0\x3,\0\0\0\0\0\0\0\0\rp\0\0\0\0\0\0\0\0\0\0\x3\xec\0\0\x3,)"

        [Troubleshooting]
        force_raster_widgets=1
        ignored_applications=@Invalid()
      '';
  };
}
