{ config, inputs, pkgs, ... }:
let
  username = config.conf.username;
  # at time of using this here, stylix might not be evaluated yet
  # hence ensure it is by using base16 mkSchemeAttrs
  base16 = pkgs.callPackage inputs.base16.lib { };
  scheme = (base16.mkSchemeAttrs config.stylix.base16Scheme);
  # active_colors=#ffc0caf5, #${scheme.base00}, #ff373949, #ff2b2c3b, #ff1a1b26, #ff2b2c3b, #ffc0caf5, #ffc0caf5, #ffc0caf5, #ff1a1b26, #ff1a1b26, #19000000, #ff2b2c3b, #ffc0caf5, #ff3584e4, #ff1b6acb, #ff1a1b26, #ff242530, #ff1a1b26, #ffc0caf5, #ffc0caf5
  # disabled_colors=#ff6d728d, #${scheme.base00}, #ff373949, #ff2b2c3b, #ff1a1b26, #ff2b2c3b, #ff6d728d, #ff6d728d, #ff6d728d, #ff1a1b26, #ff1a1b26, #19000000, #ff2b2c3b, #ff6d728d, #ff3584e4, #ff1b6acb, #ff1a1b26, #ff242530, #ff1a1b26, #ff6d728d, #ff6d728d
  # inactive_colors=#ff6d728d, #${scheme.base00}, #ff373949, #ff2b2c3b, #ff1a1b26, #ff2b2c3b, #ff6d728d, #ff6d728d, #ff6d728d, #ff1a1b26, #ff1a1b26, #19000000, #ff2b2c3b, #ff6d728d, #ff3584e4, #ff1b6acb, #ff1a1b26, #ff242530, #ff1a1b26, #ff6d728d, #ff6d728d
  color = ''
    [ColorScheme]
    active_colors=#ff${scheme.base05}, #ff${scheme.base01}, #ff${scheme.base01}, #ff${scheme.base01}, #ff${scheme.base00}, #ff${scheme.base00}, #ff${scheme.base05}, #ff${scheme.base04}, #ff${scheme.base05}, #ff${scheme.base00}, #ff${scheme.base00}, #00${scheme.base01}, #ff${scheme.base02}, #ff${scheme.base04}, #ff${scheme.base08}, #ff${scheme.base04}, #ff${scheme.base01}, #ff${scheme.base00}, #ff${scheme.base01}, #ff${scheme.base05}, #ff${scheme.base04}
    disabled_colors=#ff${scheme.base05}, #ff${scheme.base01}, #ff${scheme.base01}, #ff${scheme.base01}, #ff${scheme.base00}, #ff${scheme.base00}, #ff${scheme.base05}, #ff${scheme.base04}, #ff${scheme.base05}, #ff${scheme.base00}, #ff${scheme.base00}, #00${scheme.base01}, #ff${scheme.base02}, #ff${scheme.base04}, #ff${scheme.base08}, #ff${scheme.base04}, #ff${scheme.base01}, #ff${scheme.base00}, #ff${scheme.base01}, #ff${scheme.base05}, #ff${scheme.base04}
    inactive_colors=#ff${scheme.base05}, #ff${scheme.base01}, #ff${scheme.base01}, #ff${scheme.base01}, #ff${scheme.base00}, #ff${scheme.base00}, #ff${scheme.base05}, #ff${scheme.base04}, #ff${scheme.base05}, #ff${scheme.base00}, #ff${scheme.base00}, #00${scheme.base01}, #ff${scheme.base02}, #ff${scheme.base04}, #ff${scheme.base08}, #ff${scheme.base04}, #ff${scheme.base01}, #ff${scheme.base00}, #ff${scheme.base01}, #ff${scheme.base05}, #ff${scheme.base04}
  '';
  qss = ''
    QTabBar::tab:selected {
        color: palette(highlight);
    }
    QMenuBar, QMenu, QToolBar, QStatusBar, QFrame, QScrollBar {
        border: none;
    }
  '';
in {
  xdg.configFile."qt5ct/colors/tokyonight.conf" = { text = "${color}"; };
  xdg.configFile."qt6ct/colors/tokyonight.conf" = { text = "${color}"; };
  xdg.configFile."qt5ct/qss/tab.qss" = { text = "${qss}"; };
  xdg.configFile."qt5ct/qt5ct.conf" = {
    text = ''
      [Appearance]
      color_scheme_path=/home/${username}/.config/qt5ct/colors/tokyonight.conf
      custom_palette=true
      icon_theme=MoreWaita
      standard_dialogs=gtk3
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
      stylesheets=/home/${username}/.config/qt5ct/qss/tab.qss, /nix/store/5713p1pv913a6fsn8j7z6ndikcwikbcd-qt5ct-1.8/share/qt5ct/qss/fusion-fixes.qss, /nix/store/5713p1pv913a6fsn8j7z6ndikcwikbcd-qt5ct-1.8/share/qt5ct/qss/scrollbar-simple.qss, /nix/store/5713p1pv913a6fsn8j7z6ndikcwikbcd-qt5ct-1.8/share/qt5ct/qss/sliders-simple.qss, /nix/store/5713p1pv913a6fsn8j7z6ndikcwikbcd-qt5ct-1.8/share/qt5ct/qss/tooltip-simple.qss, /nix/store/5713p1pv913a6fsn8j7z6ndikcwikbcd-qt5ct-1.8/share/qt5ct/qss/traynotification-simple.qss
      toolbutton_style=4
      underline_shortcut=0
      wheel_scroll_lines=3

      [SettingsWindow]
      geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\n\0\0\0\0\0\0\0\rK\0\0\x5q\0\0\n\0\0\0\0\0\0\0\r[\0\0\x5\x7f\0\0\0\0\x2\0\0\0\rp\0\0\n\0\0\0\0\0\0\0\rK\0\0\x5q)

      [Troubleshooting]
      force_raster_widgets=1
      ignored_applications=@Invalid()
    '';
  };
  xdg.configFile."qt6ct/qt6ct.conf" = {
    text = ''
      [Appearance]
      color_scheme_path=/home/${username}/.config/qt6ct/colors/toykonight.conf
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
