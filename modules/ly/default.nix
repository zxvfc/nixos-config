{ lib, pkgs, config, ... } : {
	services.displayManager.ly = { 
		enable = true;
		settings = {
			allow_empty_password = true;
			animation = "gameoflife";
			animation_frame_delay = 5;
			animation_timeout_sec = 0;
			asterisk = "*";
			auth_fails = 10;
			battery_id = "BATT";
			# auto_login_service = ly-autologin;
			# auto_login_session = null;
			# auto_login_user = null;
			bg = "0x00000000";
			# bigclock = none;
			# bigclock_12hr = false;
			# bigclock_seconds = false;
			# blank_box = true;
			# border_fg = 0x00FFFFFF;
			# box_title = null;
			brightness_down_cmd = "${pkgs.brightnessctl}/bin/brightnessctl -q -n s 10%-";
			brightness_down_key = "F4";
			brightness_up_cmd = "${pkgs.brightnessctl}/bin/brightnessctl -q -n s +10%";
			brightness_up_key = "F5";
			# clear_password = false;
			# clock = null;
			# dur_file_path = "/etc/ly/example.dur";
			# dur_offset_alignment = "center";
			# dur_x_offset = 0;
			# dur_y_offset = 0;
			edge_margin = 0;
			error_bg = "0x00000000";
			error_fg = "0x01FF0000";
			fg = "0x00FFFFFF";
			full_color = true;
			gameoflife_entropy_interval = 10;
			gameoflife_fg = "0x010080FF";
			gameoflife_frame_delay = 6;
			gameoflife_initial_density = 0.4;
			hibernate_cmd = null;
			hibernate_key = "F6";
			hide_borders = false;
			hide_key_hints = false;
			hide_keyboard_locks = false;
			hide_version_string = false;
			# inactivity_cmd = null;
			# inactivity_delay = 0;
			# initial_info_text = null;
			# input_len = 34;
			lang = "en";
			load = true;
			logout_cmd = null;
			margin_box_h = 2;
			margin_box_v = 1;
			min_refresh_delta = 5;
			numlock = false;
			restart_cmd = "/sbin/shutdown -r now";
			restart_key = "F2";
			save = true;
			service_name = "ly";
			shell = true;
			show_password_key =" F7";
			show_tty = true;
			shutdown_cmd = "/sbin/shutdown -a now";
			shutdown_key = "F1";
			sleep_cmd = null;
			sleep_key = "F3";
		};
	};
}



