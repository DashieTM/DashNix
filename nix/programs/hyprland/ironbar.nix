{config, ...}:{
   
  programs.ironbar =
  {
    enable = true;
    style = ''
      @import url("/home/dashie/.config/gtk-3.0/gtk.css");
      
      * {
        color: #71bbe6;
        padding: 0px;
        margin: 0px;
      }
      
      .background {
        background-color: rgba(0, 0, 0, 0);
      }
      
      .workspaces {
        margin: 2px 0px 0px 5px;
        border-radius: 10px;
        /* background-color: #2b2c3b; */
        background-color: #1E1E2E;
        padding: 2px 5px 2px 5px;
      }
      
      .workspaces .item {
        margin: 0px 3px 0px 3px;
        font-size: 13px;
        border-radius: 100%;
        padding: 0px 2px 0px 3px;
        background-color: rgba(0, 0, 0, 0);
      }
      
      .workspaces .item:hover {
        background-color: #3e4152;
      }
      
      .workspaces .item.focused {
        background-color: #3e4152;
      }
      
      .audio-box {
        padding: 2em;
        background-color: #1E1E2E;
        border-radius: 5px;
      }
      
      .audio-slider {
        padding: 5px;
        margin: 5px;
      }
      
      .audio-button {
        padding: 5px 10px 5px 10px;
        margin: 0px 1em 20px 1em;
        border-radius: 100%;
        font-size: 17px;
      }
      
      .audio-button-box {
        padding: 0px 2.5em 0px 2.5em;
      }
      
      .focused {
        /* margin: 2px 0px 0px 0px; */
        padding: 0px 5px 0px 5px;
        /* background-color: 1a1b26; */
        background-color: #1E1E2E;
        font-size: 17px;
        border-radius: 10px;
      }
      
      #bar #end {
        margin: 0px 5px 0px 0px;
        padding: 0px 5px 0px 5px;
        background-color: #1E1E2E;
        border-radius: 10px;
      }
      
      .popup-button {
        padding: 0px 5px 0px 3px;
        margin: 0em 3px;
        border-radius: 100%;
        font-size: 13px;
        background-color: #1E1E2E;
      }
      
      .popup-button-box {
        padding: 2px 0px 2px 0px;
      }
      
      .clock {
        padding: 0px 5px 0px 5px;
        font-size: 17px;
        background-color: #1E1E2E;
      }
      
      .clock:hover {
        background-color: #3e4152;
      }
      
      .custom button {
        background-color: #1E1E2E;
      }
      
      .custom button:hover {
        background-color: #3e4152;
      }
      
      .memory-usage {
        font-size: 15px;
        margin: 0px 5px 0px 0px;
      }
      
      .memory-usage:hover {
        background-color: #3e4152;
      }
      
      .popup-clock {
        background-color: #1E1E2E;
        border-radius: 5px;
        padding: 2px 8px 10px 8px;
      }
      
      .popup-clock .calendar-clock {
        font-size: 2.5em;
        padding-bottom: 0.1em;
      }
      
      .popup-clock .calendar {
        border-radius: 5px;
        font-size: 1.05em;
      }
      
      .popup-clock .calendar:selected {
        background-color: #3e4152;
      }
    '';
    features = [
      #"another_feature"
    ];
    config = {
      monitors."${config.programs.ironbar.monitor}" = {
        end = [
          {
            type = "sys_info";
            format = [
              " {memory_percent}"
            ];
            interval.memory = 30;
            class = "memory-usage";
          }
          {
            type = "custom";
            bar = [
              {
                type = "button";
                class = "popup-button";
                label = "";
                on_click = "popup:toggle";
              }
            ];
            class = "popup-button-box";
            popup = [
              {
                type = "box";
                orientation = "vertical";
                class = "audio-box";
                widgets = [
                  {
                    type = "box";
                    orientation = "horizontal";
                    widgets = [
                      {
                        type = "button";
                        class = "audio-button";
                        label = "";
                        on_click = "!/home/dashie/.config/eww/scripts/audio_control.sh bluetooth";
                      }
                      {
                        type = "button";
                        class = "audio-button";
                        label = "󰋋";
                        on_click = "!/home/dashie/.config/eww/scripts/audio_control.sh internal";
                      }
                    ];
                    class = "audio-button-box";
                  }
                  {
                    type = "label";
                    label = "Output";
                  }
                  {
                    type = "slider";
                    class = "audio-slider";
                    step = 1.0;
                    length = 200;
                    value = "pactl get-sink-volume @DEFAULT_SINK@ | awk -F'/' '{ print $2 }' | tr -d ' %'";
                    on_change = "!pactl set-sink-volume @DEFAULT_SINK@ $0%";
                  }
                  {
                    type = "label";
                    label = "Input";
                  }
                  {
                    type = "slider";
                    class = "audio-slider";
                    step = 1.0;
                    length = 200;
                    value = "pactl get-source-volume @DEFAULT_SOURCE@ | awk -F'/' '{ print $2 }' | tr -d ' %'";
                    on_change = "!pactl set-source-volume @DEFAULT_SOURCE@ $0%";
                  }
                ];
              }
            ];
          }
          {
            type = "custom";
            bar = [
              {
                type = "button";
                class = "popup-button";
                label = "";
                on_click = "!oxidash --css /home/dashie/gits/oxidash/style.css";
              }
            ];
            class = "popup-button-box";
          }
          {
            type = "clock";
            format = "%I:%M";
            format_popup = "%I:%M:%S";
            locale = "en_US";
          }
          { type = "tray"; }
        ];
        position = "top";
        height = 10;
        anchor_to_edges = true;
        start = [{
          type = "workspaces";
          all_monitors = true;
        }];
        center = [
          {
            type = "focused";
            show_icon = true;
            show_title = true;
            icon_size = 20;
            truncate = "end";
          }
        ];
      };
    };
  };
}
