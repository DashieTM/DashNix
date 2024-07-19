{
  # don't ask....
  programs.yazi =
    {
      enable = true;
      settings = {
        log = {
          enabled = false;
        };
        opener = {

          folder = [
            {
              run = "open - R \"$@\"";
              orphan = true;
              display_name = "Reveal in Finder";
            }
            {
              run = "$EDITOR \"$@\"";
              orphan = true;
            }
          ];
          archive = [
            {
              run = "unar \"$1\"";
              display_name = "Extract here";
            }
          ];
          text = [
            {
              run = "$EDITOR \"$@\"";
              orphan = true;
            }
          ];
          image = [
            {
              run = "imv \"$@\"";
              orphan = true;
              display_name = "Open";
            }
            {
              run = "exiftool \"$1\"; echo \"Press enter to exit\"; read";
              block = true;
              display_name = "Show EXIF";
            }
          ];
          pdf = [{
            run = "zathura \"$@\"";
            orphan = true;
            display_name = "Open";
          }];
          video = [
            {
              run = "mpv \"$@\"";
              orphan = true;
            }
            {
              run = "mediainfo \"$1\"; echo \"Press enter to exit\"; read";
              block = true;
              display_name = "Show media info";
            }
          ];
          audio = [
            {
              run = "xdg-open \"$@\"";
              orphan = true;
            }
            { run = "mediainfo \"$1\"; echo \"Press enter to exit\"; read"; block = true; display_name = "Show media info"; }
          ];
          fallback = [
            {
              run = "xdg-open \"$@\"";
              orphan = true;
              display_name = "Open";
            }
            {
              run = "xdg-open - R \"$@\"";
              orphan = true;
              display_name = "Reveal in Finder";
            }
          ];
        };
        plugin = {
          prepend_previewers = [
            {
              name = "*.md";
              run = "glow";
            }
            { mime = "text/csv"; run = "miller"; }
          ];
        };
      };
      keymap =
        {
          manager.keymap = [
            {
              on = [
                "<Esc>"
              ];
              run = "escape";
              desc = "Exit visual mode clear selected or cancel search";
            }
            {
              on = [
                "q"
              ];
              run = "quit";
              desc = "Exit the process";
            }
            {
              on = [
                "Q"
              ];
              run = "quit --no-cwd-file";
              desc = "Exit the process without writing cwd-file";
            }
            {
              on = [
                "<C-q>"
              ];
              run = "close";
              desc = "Close the current tab or quit if it is last tab";
            }
            {
              on = [
                "<C-z>"
              ];
              run = "suspend";
              desc = "Suspend the process";
            }

            # Navigation
            {
              on = [
                "l"
              ];
              run = "arrow -1";
              desc = "Move cursor up";
            }
            {
              on = [
                "k"
              ];
              run = "arrow 1";
              desc = "Move cursor down";
            }

            {
              on = [
                "L"
              ];
              run = "arrow -5";
              desc = "Move cursor up 5 lines";
            }
            {
              on = [
                "K"
              ];
              run = "arrow 5";
              desc = "Move cursor down 5 lines";
            }

            {
              on = [
                "<C-u>"
              ];
              run = "arrow -50%";
              desc = "Move cursor up half page";
            }
            {
              on = [
                "<C-d>"
              ];
              run = "arrow 50%";
              desc = "Move cursor down half page";
            }
            {
              on = [
                "<C-b>"
              ];
              run = "arrow -100%";
              desc = "Move cursor up one page";
            }
            {
              on = [
                "<C-f>"
              ];
              run = "arrow 100%";
              desc = "Move cursor down one page";
            }

            {
              on = [
                "j"
              ];
              run = "leave";
              desc = "Go back to the parent directory";
            }
            {
              on = [
                ";"
              ];
              run = "enter";
              desc = "Enter the child directory";
            }

            {
              on = [
                "J"
              ];
              run = "back";
              desc = "Go back to the previous directory";
            }
            {
              on = [
                "P"
              ];
              run = "forward";
              desc = "Go forward to the next directory";
            }

            {
              on = [
                "<C-k>"
              ];
              run = "peek -5";
              desc = "Peek up 5 units in the preview";
            }
            {
              on = [
                "<C-j>"
              ];
              run = "peek 5";
              desc = "Peek down 5 units in the preview";
            }

            {
              on = [
                "<Up>"
              ];
              run = "arrow -1";
              desc = "Move cursor up";
            }
            {
              on = [
                "<Down>"
              ];
              run = "arrow 1";
              desc = "Move cursor down";
            }
            {
              on = [
                "<Left>"
              ];
              run = "leave";
              desc = "Go back to the parent directory";
            }
            {
              on = [
                "<Right>"
              ];
              run = "enter";
              desc = "Enter the child directory";
            }

            {
              on = [
                "g"
                "g"
              ];
              run = "arrow -99999999";
              desc = "Move cursor to the top";
            }
            {
              on = [
                "G"
              ];
              run = "arrow 99999999";
              desc = "Move cursor to the bottom";
            }

            # Selection
            {
              on = [
                "v"
              ];
              run = "visual_mode";
              desc = "Enter visual mode (selection mode)";
            }
            {
              on = [
                "V"
              ];
              run = "visual_mode --unset";
              desc = "Enter visual mode (unset mode)";
            }
            {
              on = [
                "<C-a>"
              ];
              run = "select_all --state=true";
              desc = "Select all files";
            }
            {
              on = [
                "<C-r>"
              ];
              run = "select_all --state=none";
              desc = "Inverse selection of all files";
            }

            # Operation
            {
              on = [
                "o"
              ];
              run = "open";
              desc = "Open the selected files";
            }
            {
              on = [
                "O"
              ];
              run = "open --interactive";
              desc = "Open the selected files interactively";
            }
            {
              on = [
                "<Enter>"
              ];
              run = "open";
              desc = "Open the selected files";
            }
            {
              on = [
                "<C-Enter>"
              ];
              run = "open --interactive";
              desc = "Open the selected files interactively";
            } # It's cool if you're using a terminal that supports CSI u
            {
              on = [
                "y"
              ];
              run = "yank";
              desc = "Copy the selected files";
            }
            {
              on = [
                "x"
              ];
              run = "yank --cut";
              desc = "Cut the selected files";
            }
            {
              on = [
                "p"
              ];
              run = "paste";
              desc = "Paste the files";
            }
            {
              on = [
                "P"
              ];
              run = "paste --force";
              desc = "Paste the files (overwrite if the destination exists)";
            }
            {
              on = [
                "-"
              ];
              run = "link";
              desc = "Symlink the absolute path of files";
            }
            {
              on = [
                "_"
              ];
              run = "link --relative";
              desc = "Symlink the relative path of files";
            }
            {
              on = [
                "d"
              ];
              run = "remove";
              desc = "Move the files to the trash";
            }
            {
              on = [
                "D"
              ];
              run = "remove --permanently";
              desc = "Permanently delete the files";
            }
            {
              on = [
                "a"
              ];
              run = "create";
              desc = "Create a file or directory (ends with / for directories)";
            }
            {
              on = [
                "r"
              ];
              run = "rename";
              desc = "Rename a file or directory";
            }
            {
              on = [
                ";"
              ];
              run = "shell";
              desc = "Run a shell command";
            }
            {
              on = [
                ":"
              ];
              run = "shell --block";
              desc = "Run a shell command (block the UI until the command finishes)";
            }
            {
              on = [
                "."
              ];
              run = "hidden toggle";
              desc = "Toggle the visibility of hidden files";
            }
            {
              on = [
                "<Space>"
                "f"
                "g>"
              ];
              run = "search fd";
              desc = "Search files by name using fd";
            }
            {
              on = [
                "<Space>"
                "f"
                "G>"
              ];
              run = "search rg";
              desc = "Search files by content using ripgrep";
            }
            {
              on = [
                "<C-s>"
              ];
              run = "search none";
              desc = "Cancel the ongoing search";
            }
            {
              on = [
                "z"
              ];
              run = "jump zoxide";
              desc = "Jump to a directory using zoxide";
            }
            {
              on = [
                "Z"
              ];
              run = "jump fzf";
              desc = "Jump to a directory or reveal a file using fzf";
            }

            # Copy
            {
              on = [
                "c"
                "c"
              ];
              run = "copy path";
              desc = "Copy the absolute path";
            }
            {
              on = [
                "c"
                "d"
              ];
              run = "copy dirname";
              desc = "Copy the path of the parent directory";
            }
            {
              on = [
                "c"
                "f"
              ];
              run = "copy filename";
              desc = "Copy the name of the file";
            }
            {
              on = [
                "c"
                "n"
              ];
              run = "copy name_without_ext";
              desc = "Copy the name of the file without the extension";
            }

            # Find
            {
              on = [
                "/"
              ];
              run = "find --smart";
            }
            {
              on = [
                "?"
              ];
              run = "find --previous --smart";
            }
            {
              on = [
                "n"
              ];
              run = "find_arrow";
            }
            {
              on = [
                "N"
              ];
              run = "find_arrow --previous";
            }

            # Sorting
            {
              on = [
                ","
                "a"
              ];
              run = "sort alphabetical --dir_first";
              desc = "Sort alphabetically";
            }
            {
              on = [
                ","
                "A"
              ];
              run = "sort alphabetical --reverse --dir_first";
              desc = "Sort alphabetically (reverse)";
            }
            {
              on = [
                ","
                "c"
              ];
              run = "sort created --dir_first";
              desc = "Sort by creation time";
            }
            {
              on = [
                ","
                "C"
              ];
              run = "sort created --reverse --dir_first";
              desc = "Sort by creation time (reverse)";
            }
            {
              on = [
                ","
                "m"
              ];
              run = "sort modified --dir_first";
              desc = "Sort by modified time";
            }
            {
              on = [
                ","
                "M"
              ];
              run = "sort modified --reverse --dir_first";
              desc = "Sort by modified time (reverse)";
            }
            {
              on = [
                ","
                "n"
              ];
              run = "sort natural --dir_first";
              desc = "Sort naturally";
            }
            {
              on = [
                ","
                "N"
              ];
              run = "sort natural --reverse --dir_first";
              desc = "Sort naturally (reverse)";
            }
            {
              on = [
                ","
                "s"
              ];
              run = "sort size --dir_first";
              desc = "Sort by size";
            }
            {
              on = [
                ","
                "S"
              ];
              run = "sort size --reverse --dir_first";
              desc = "Sort by size (reverse)";
            }

            # Tabs
            {
              on = [
                "t"
              ];
              run = "tab_create --current";
              desc = "Create a new tab using the current path";
            }

            {
              on = [
                "1"
              ];
              run = "tab_switch 0";
              desc = "Switch to the first tab";
            }
            {
              on = [
                "2"
              ];
              run = "tab_switch 1";
              desc = "Switch to the second tab";
            }
            {
              on = [
                "3"
              ];
              run = "tab_switch 2";
              desc = "Switch to the third tab";
            }
            {
              on = [
                "4"
              ];
              run = "tab_switch 3";
              desc = "Switch to the fourth tab";
            }
            {
              on = [
                "5"
              ];
              run = "tab_switch 4";
              desc = "Switch to the fifth tab";
            }
            {
              on = [
                "6"
              ];
              run = "tab_switch 5";
              desc = "Switch to the sixth tab";
            }
            {
              on = [
                "7"
              ];
              run = "tab_switch 6";
              desc = "Switch to the seventh tab";
            }
            {
              on = [
                "8"
              ];
              run = "tab_switch 7";
              desc = "Switch to the eighth tab";
            }
            {
              on = [
                "9"
              ];
              run = "tab_switch 8";
              desc = "Switch to the ninth tab";
            }

            {
              on = [
                "["
              ];
              run = "tab_switch -1 --relative";
              desc = "Switch to the previous tab";
            }
            {
              on = [
                "]"
              ];
              run = "tab_switch 1 --relative";
              desc = "Switch to the next tab";
            }

            {
              on = [
                "{"
              ];
              run = "tab_swap -1";
              desc = "Swap the current tab with the previous tab";
            }
            {
              on = [
                "}"
              ];
              run = "tab_swap 1";
              desc = "Swap the current tab with the next tab";
            }

            # Tasks
            {
              on = [
                "w"
              ];
              run = "tasks_show";
              desc = "Show the tasks manager";
            }

            # Goto
            {
              on = [
                "g"
                "h"
              ];
              run = "cd ~";
              desc = "Go to the home directory";
            }
            {
              on = [
                "g"
                "c"
              ];
              run = "cd ~/.config";
              desc = "Go to the config directory";
            }
            {
              on = [
                "g"
                "d"
              ];
              run = "cd ~/Downloads";
              desc = "Go to the downloads directory";
            }
            {
              on = [
                "g"
                "t"
              ];
              run = "cd /tmp";
              desc = "Go to the temporary directory";
            }
            {
              on = [
                "g"
                "<Space>"
              ];
              run = "cd --interactive";
              desc = "Go to a directory interactively";
            }

            # Help
            {
              on = [
                "~"
              ];
              run = "help";
              desc = "Open help";
            }
          ];

          tasks.keymap = [
            {
              on = [
                "<Esc>"
              ];
              run = "close";
              desc = "Hide the task manager";
            }
            {
              on = [
                "<C-q>"
              ];
              run = "close";
              desc = "Hide the task manager";
            }
            {
              on = [
                "w"
              ];
              run = "close";
              desc = "Hide the task manager";
            }

            {
              on = [
                "k"
              ];
              run = "arrow -1";
              desc = "Move cursor up";
            }
            {
              on = [
                "j"
              ];
              run = "arrow 1";
              desc = "Move cursor down";
            }

            {
              on = [
                "<Up>"
              ];
              run = "arrow -1";
              desc = "Move cursor up";
            }
            {
              on = [
                "<Down>"
              ];
              run = "arrow 1";
              desc = "Move cursor down";
            }

            {
              on = [
                "<Enter>"
              ];
              run = "inspect";
              desc = "Inspect the task";
            }
            {
              on = [
                "x"
              ];
              run = "cancel";
              desc = "Cancel the task";
            }

            {
              on = [
                "~"
              ];
              run = "help";
              desc = "Open help";
            }
          ];


          select.keymap = [
            {
              on = [
                "<C-q>"
              ];
              run = "close";
              desc = "Cancel selection";
            }
            {
              on = [
                "<Esc>"
              ];
              run = "close";
              desc = "Cancel selection";
            }
            {
              on = [
                "<Enter>"
              ];
              run = "close --submit";
              desc = "Submit the selection";
            }

            {
              on = [
                "k"
              ];
              run = "arrow -1";
              desc = "Move cursor up";
            }
            {
              on = [
                "j"
              ];
              run = "arrow 1";
              desc = "Move cursor down";
            }

            {
              on = [
                "K"
              ];
              run = "arrow -5";
              desc = "Move cursor up 5 lines";
            }
            {
              on = [
                "J"
              ];
              run = "arrow 5";
              desc = "Move cursor down 5 lines";
            }

            {
              on = [
                "<Up>"
              ];
              run = "arrow -1";
              desc = "Move cursor up";
            }
            {
              on = [
                "<Down>"
              ];
              run = "arrow 1";
              desc = "Move cursor down";
            }

            {
              on = [
                "~"
              ];
              run = "help";
              desc = "Open help";
            }
          ];


          input.keymap = [
            {
              on = [
                "<C-q>"
              ];
              run = "close";
              desc = "Cancel input";
            }
            {
              on = [
                "<Enter>"
              ];
              run = "close --submit";
              desc = "Submit the input";
            }
            {
              on = [
                "<Esc>"
              ];
              run = "escape";
              desc = "Go back the normal mode or cancel input";
            }

            # Mode
            {
              on = [
                "i"
              ];
              run = "insert";
              desc = "Enter insert mode";
            }
            {
              on = [
                "a"
              ];
              run = "insert --append";
              desc = "Enter append mode";
            }
            {
              on = [
                "v"
              ];
              run = "visual";
              desc = "Enter visual mode";
            }
            {
              on = [
                "V"
              ];
              run = [
                "move -999"
                "visual"
                "move 999"
              ];
              desc = "Enter visual mode and select all";
            }

            # Navigation
            {
              on = [
                "h"
              ];
              run = "move -1";
              desc = "Move cursor left";
            }
            {
              on = [
                "l"
              ];
              run = "move 1";
              desc = "Move cursor right";
            }

            {
              on = [
                "0"
              ];
              run = "move -999";
              desc = "Move to the BOL";
            }
            {
              on = [
                "$"
              ];
              run = "move 999";
              desc = "Move to the EOL";
            }
            {
              on = [
                "I"
              ];
              run = [
                "move -999"
                "insert"
              ];
              desc = "Move to the BOL and enter insert mode";
            }
            {
              on = [
                "A"
              ];
              run = [
                "move 999"
                "insert --append"
              ];
              desc = "Move to the EOL and enter append mode";
            }

            {
              on = [
                "<Left>"
              ];
              run = "move -1";
              desc = "Move cursor left";
            }
            {
              on = [
                "<Right>"
              ];
              run = "move 1";
              desc = "Move cursor right";
            }

            {
              on = [
                "b"
              ];
              run = "backward";
              desc = "Move to the beginning of the previous word";
            }
            {
              on = [
                "w"
              ];
              run = "forward";
              desc = "Move to the beginning of the next word";
            }
            {
              on = [
                "e"
              ];
              run = "forward --end-of-word";
              desc = "Move to the end of the next word";
            }

            # Deletion
            {
              on = [
                "d"
              ];
              run = "delete --cut";
              desc = "Cut the selected characters";
            }
            {
              on = [
                "D"
              ];
              run = [
                "delete --cut"
                "move 999"
              ];
              desc = "Cut until the EOL";
            }
            {
              on = [
                "c"
              ];
              run = "delete --cut --insert";
              desc = "Cut the selected characters and enter insert mode";
            }
            {
              on = [
                "C"
              ];
              run = [
                "delete --cut --insert"
                "move 999"
              ];
              desc = "Cut until the EOL and enter insert mode";
            }
            {
              on = [
                "x"
              ];
              run = [
                "delete --cut"
                "move 1 --in-operating"
              ];
              desc = "Cut the current character";
            }

            # Yank/Paste
            {
              on = [
                "y"
              ];
              run = "yank";
              desc = "Copy the selected characters";
            }
            {
              on = [
                "p"
              ];
              run = "paste";
              desc = "Paste the copied characters after the cursor";
            }
            {
              on = [
                "P"
              ];
              run = "paste --before";
              desc = "Paste the copied characters before the cursor";
            }

            # Undo/Redo
            {
              on = [
                "u"
              ];
              run = "undo";
              desc = "Undo the last operation";
            }
            {
              on = [
                "<C-r>"
              ];
              run = "redo";
              desc = "Redo the last operation";
            }

            # Help
            {
              on = [
                "~"
              ];
              run = "help";
              desc = "Open help";
            }
          ];

          help.keymap = [
            {
              on = [
                "<Esc>"
              ];
              run = "escape";
              desc = "Clear the filter or hide the help";
            }
            {
              on = [
                "q"
              ];
              run = "close";
              desc = "Exit the process";
            }
            {
              on = [
                "<C-q>"
              ];
              run = "close";
              desc = "Hide the help";
            }

            # Navigation
            {
              on = [
                "k"
              ];
              run = "arrow -1";
              desc = "Move cursor up";
            }
            {
              on = [
                "j"
              ];
              run = "arrow 1";
              desc = "Move cursor down";
            }

            {
              on = [
                "K"
              ];
              run = "arrow -5";
              desc = "Move cursor up 5 lines";
            }
            {
              on = [
                "J"
              ];
              run = "arrow 5";
              desc = "Move cursor down 5 lines";
            }

            {
              on = [
                "<Up>"
              ];
              run = "arrow -1";
              desc = "Move cursor up";
            }
            {
              on = [
                "<Down>"
              ];
              run = "arrow 1";
              desc = "Move cursor down";
            }

            # Filtering
            {
              on = [
                "/"
              ];
              run = "filter";
              desc = "Apply a filter for the help items";
            }
          ];
        };
      # theme = {
      #   manager = {
      #     cwd = {
      #       fg = "#94e2d5";
      #     };
      #
      #     # Hovered
      #     hovered = {
      #       reversed = true;
      #     };
      #     preview_hovered = { underline = true; };
      #
      #     # Find
      #     find_keyword = {
      #       fg = "#f9e2af";
      #       bold = true;
      #       italic = true;
      #       underline = true;
      #     };
      #     find_position = {
      #       fg = "#f5c2e7";
      #       bg = "reset";
      #       bold = true;
      #       italic = true;
      #     };
      #
      #     # Marker
      #     marker_copied = {
      #       fg = "#a6e3a1";
      #       bg = "#a6e3a1";
      #     };
      #     marker_cut = {
      #       fg = "#f38ba8";
      #       bg = "#f38ba8";
      #     };
      #     marker_marked = {
      #       fg = "#f9e2af";
      #       bg = "#f9e2af";
      #     };
      #     marker_selected = {
      #       fg = "#779EF0";
      #       bg = "#89b4fa";
      #     };
      #
      #     # Tab
      #     tab_active = {
      #       fg = "#1e1e2e";
      #       bg = "#cdd6f4";
      #     };
      #     tab_inactive = {
      #       fg = "#cdd6f4";
      #       bg = "#45475a";
      #     };
      #     tab_width = 1;
      #
      #     # Count
      #     count_copied = {
      #       fg = "#1e1e2e";
      #       bg = "#a6e3a1";
      #     };
      #     count_cut = {
      #       fg = "#1e1e2e";
      #       bg = "#f38ba8";
      #     };
      #     count_selected = {
      #       fg = "#1e1e2e";
      #       bg = "#89b4fa";
      #     };
      #
      #     # Border
      #     border_symbol = "│";
      #     border_style = { fg = "#7f849c"; };
      #
      #   };
      #   status = {
      #     separator_open = "";
      #     separator_close = "";
      #     separator_style = {
      #       fg = "#45475a";
      #       bg = "#45475a";
      #     };
      #
      #     # Mode
      #     mode_normal = {
      #       fg = "#1e1e2e";
      #       bg = "#89b4fa";
      #       bold = true;
      #     };
      #     mode_select = {
      #       fg = "#1e1e2e";
      #       bg = "#a6e3a1";
      #       bold = true;
      #     };
      #     mode_unset = {
      #       fg = "#1e1e2e";
      #       bg = "#f2cdcd";
      #       bold = true;
      #     };
      #
      #     # Progress
      #     progress_label = {
      #       fg = "#ffffff";
      #       bold = true;
      #     };
      #     progress_normal = {
      #       fg = "#89b4fa";
      #       bg = "#45475a";
      #     };
      #     progress_error = {
      #       fg = "#f38ba8";
      #       bg = "#45475a";
      #     };
      #
      #     # Permissions
      #     permissions_t = { fg = "#89b4fa"; };
      #     permissions_r = { fg = "#f9e2af"; };
      #     permissions_w = { fg = "#f38ba8"; };
      #     permissions_x = { fg = "#a6e3a1"; };
      #     permissions_s = { fg = "#7f849c"; };
      #   };
      #
      #   input = {
      #     border = {
      #       fg = "#89b4fa";
      #     };
      #     title = { };
      #     value = { };
      #     selected = { reversed = true; };
      #   };
      #   select = {
      #     border = {
      #       fg = "#89b4fa";
      #     };
      #     active = { fg = "#f5c2e7"; };
      #     inactive = { };
      #   };
      #   tasks = {
      #     border = {
      #       fg = "#89b4fa";
      #     };
      #     title = { };
      #     hovered = {
      #       underline = true;
      #     };
      #   };
      #   which = {
      #     mask = {
      #       bg = "#313244";
      #     };
      #     cand = { fg = "#94e2d5"; };
      #     rest = { fg = "#9399b2"; };
      #     desc = { fg = "#f5c2e7"; };
      #     separator = "  ";
      #     separator_style = { fg = "#585b70"; };
      #   };
      #   help = {
      #     on = {
      #       fg = "#f5c2e7";
      #     };
      #     exec = { fg = "#94e2d5"; };
      #     desc = { fg = "#9399b2"; };
      #     hovered = {
      #       bg = "#585b70";
      #       bold = true;
      #     };
      #     footer = {
      #       fg = "#45475a";
      #       bg = "#cdd6f4";
      #     };
      #   };
      #   filetype = {
      #     rules = [
      #       # Images
      #       {
      #         mime = "image/*";
      #         fg = "#94e2d5";
      #       }
      #
      #       # Videos
      #       {
      #         mime = "video/*";
      #         fg = "#f9e2af";
      #       }
      #       {
      #         mime = "audio/*";
      #         fg = "#f9e2af";
      #       }
      #
      #       # Archives
      #       {
      #         mime = "application/zip";
      #         fg = "#f5c2e7";
      #       }
      #       {
      #         mime = "application/gzip";
      #         fg = "#f5c2e7";
      #       }
      #       {
      #         mime = "application/x-tar";
      #         fg = "#f5c2e7";
      #       }
      #       {
      #         mime = "application/x-bzip";
      #         fg = "#f5c2e7";
      #       }
      #       {
      #         mime = "application/x-bzip2";
      #         fg = "#f5c2e7";
      #       }
      #       {
      #         mime = "application/x-7z-compressed";
      #         fg = "#f5c2e7";
      #       }
      #       {
      #         mime = "application/x-rar";
      #         fg = "#f5c2e7";
      #       }
      #
      #       # Fallback
      #       {
      #         name = "*";
      #         fg = "#cdd6f4";
      #       }
      #       {
      #         name = "*/";
      #         fg = "#89b4fa";
      #       }
      #     ];
        # };
      # };
    };
}










