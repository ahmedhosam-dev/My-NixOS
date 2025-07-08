{ lib, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        height = 30;
        margin-top = 4;
        margin-bottom = 4;
        margin-left = 8;
        margin-right = 8;

        ###################
        # INCLUDE MODULES #
        ###################
        # include = [
        #   "/etc/nixos/home/ahmed/waybar/ModulesWrokspaces"
        # ];

        ###################
        # MODULES POSTION #
        ###################
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "tray" "group/audio" "backlight#vertical"
          "network#speed" "cpu" "memory" "custom/temperature" "disk"
          "battery" "group/power"
        ];

        ##################
        # MODULES FORMAT #
        ##################

        ###########################
        ########## LEFT ###########
        ###########################
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "I";
            "2" = "II";
            "3" = "III";
            "4" = "IV";
            "5" = "V";
            "6" = "VI";
            "7" = "VII";
            "8" = "VIII";
            "9" = "IX";
            "10" = "X";
          };
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
            "6" = [];
            "7" = [];
            "8" = [];
            "9" = [];
            "10" = [];
          };
        };

        ############################
        ########## CENTER ##########
        ############################
        clock = {
        	format = " {:%H:%M   %Y, %d %B, %A}";
          format-alt= " {:%I:%M %p}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
  	      calendar = {
  	      	mode = "year";
  	      	mode-mon-col = 3;
  	      	weeks-pos = "right";
  	      	on-scroll = 1;
  	      	format = {
  	      		months = "<span color='#ffead3'><b>{}</b></span>";
  	      		days = "<span color='#ecc6d9'><b>{}</b></span>";
  	      		weeks = "<span color='#99ffdd'><b>W{}</b></span>";
  	      		weekdays = "<span color='#ffcc66'><b>{}</b></span>";
  	      		today = "<span color='#ff6699'><b><u>{}</u></b></span>";
  	      	};
          };
        };

        ###########################
        ########## RIGHT ##########
        ###########################
        tray = {
          "icon-size" = 16;
          "spacing" = 8;
        };

        "backlight#vertical" = {
        	interval= 2;
        	rotate= 1;
        	format= "{icon}";
          # "format-icons" = ["󰃞" "󰃟" "󰃠"];
        	format-icons = [
        		"" "" "" "" "" "" "" "" "" "" "" "" "" "" ""
        	];
        	on-click = "";
        	on-click-middle = "";
        	on-click-right = "";
        	on-update = "";
        	on-scroll-up = "brightnessctl set \"+5%\" && notify-send \"Brightness:\" \"+5%\"";
        	on-scroll-down = "brightnessctl set \"5%-\" && notify-send \"Brightness:\" \"-5%\"";
        	smooth-scrolling-threshold = 1;
        	tooltip-format = "backlight {percent}%";
        };

        "network#speed" = {
        	interval = 1;
        	format = "{ifname}";
        	format-wifi = "{icon}  {bandwidthUpBytes}  {bandwidthDownBytes}";
        	format-ethernet = "󰌘  {bandwidthUpBytes}  {bandwidthDownBytes}";
        	format-disconnected = "󰌙";
        	tooltip-format = "{ipaddr}";
        	format-linked = "󰈁 {ifname} (No IP)";
        	tooltip-format-wifi = "{essid} {icon} {signalStrength}%";
        	tooltip-format-ethernet = "{ifname} 󰌘";
        	tooltip-format-disconnected = "󰌙 Disconnected";
        	min-length = 24;
        	max-length  = 24;
        	format-icons = [
        		"󰤯" "󰤟" "󰤢" "󰤥" "󰤨"
        	];
        };

        cpu = {
          format = "{usage}% 󰍛";
          interval = 1;
          min-length = 5;
          format-alt-click = "click";
          format-alt = "{icon0}{icon1}{icon2}{icon3} {user:>2}% 󰍛";
          fromat-icons = [
            "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"
          ];
          on-click = "gnome-system-monitor";
        };

        memory = {
	        interval = 10;
	        format = "{used:0.1f}G 󰾆";
	        format-alt = "{percentage}% 󰾆";
	        format-alt-click = "click";
	        tooltip = true;
	        tooltip-format = "{used:0.1f}GB/{total:0.1f}G";
	        on-click-right = "kitty --title btop sh -c 'btop'";
        };

        "custom/temperature" = {
          format = " {}°C  ";
          interval = 5;
          exec = "echo $(sensors | grep 'Package id 0' | awk '{print $4}' | sed 's/+//;s/°C//;s/\.0//')";
          tooltip = true;
        };

        disk = {
          interval = 30;
          format = "{percentage_used}% 󰋊";
          path = "/";
          tooltip = true;
          tooltip-format = "{used} out of {total} on {path} ({percentage_used}%)";
        };

        battery = {
          format = "{capacity}% {icon}";
          format-icons = ["" "" "" "" ""];
        };

        ######## POWER GROUP ########
        "group/power"= {
          orientation = "horizontal";
          drawer = {
            transition-duration = 500;
            children-class = "power-menu";
            # transition-left-to-rightl = false;
          };
          modules = [
            "custom/power"
            "custom/quit"
            "custom/lock"
            "custom/reboot"
            ];
        };
        "custom/power" = {
          format = " ⏻ ";
          on-click = "wlogout";
          tooltip = true;
          tooltip-format = "Left click: WLogout Menu";
        };
        "custom/quit" = {
          format = " 󰗼 ";
          on-click = "hyprctl dispatch exit";
          tooltip = true;
          tooltip-format = "Left click: Exit Hyprland";
        };
        "custom/lock" = {
	        format = "󰌾";
	        on-click = "hyprlock";
	        tooltip = true;
	        tooltip-format = "󰷛 Screen Lock";
        };
        "custom/reboot" = {
          format = " 󰜉 ";
          on-click = "systemctl reboot";
          tooltip = true;
          tooltip-format = "Left click: Reboot";
        };

        ######## AUDIO GROUP ########
        "group/audio" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "pulseaudio";
            transition-left-to-rightl = true;
          };
          modules = [
            "pulseaudio"
            "pulseaudio#microphone"
          ];
        };
        pulseaudio = {
        	format = "{icon} {volume}%";
        	format-bluetooth = "{icon} 󰂰 {volume}%";
        	format-muted = "󰖁";
        	format-icons = {
        		headphone = "";
        		hands-free = "";
        		headset = "";
        		phone = "";
        		portable = "";
        		car = "";
        		default = [
        			"" "" "󰕾"  ""
        		];
        		ignored-sinks = [
        			"Easy Effects Sink"
        		];
        	};
        	scroll-step = 5.0;
        	on-click = "pamixer --toggle-mute && notify-send \"Volume:\" \"Toggle Mute\"";
        	on-click-right = "pavucontrol -t 3";
        	on-scroll-up = "pamixer -i 5 && notify-send \"Volume:\" \"+5\"";
        	on-scroll-down = "pamixer -d 5 && notify-send \"Volume:\" \"-5\"";
        	tooltip-format = "{icon} {desc} | {volume}%";
        	smooth-scrolling-threshold = 1;
        };
        "pulseaudio#microphone" = {
        	format = "{format_source}";
        	format-source = " {volume}%";
        	format-source-muted = "";
        	on-click = "pamixer --default-source --toggle-mute && notify-send \"Mic:\" \"Toggle Mute\"";
        	on-click-right = "pavucontrol -t 4";
        	on-scroll-up = "pamixer --default-source -i 5 && notify-send \"Mic:\" \"+5\"";
        	on-scroll-down = "pamixer --default-source -d 5 && notify-send \"Mic:\" \"-5\"";
        	tooltip-format = "{source_desc} | {source_volume}%";
        	scroll-step = 5;
        };

      };
    };
    style = lib.fileContents ./style.css;
  };
}
