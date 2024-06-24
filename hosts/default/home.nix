{ inputs, pkgs, ... }: {
# This is a test comment
	imports = [
		inputs.ags.homeManagerModules.default
		../../modules/home-manager/gaming/minecraft.nix
		../../modules/home-manager/gaming/osu.nix
		../../modules/home-manager/terminals/foot.nix
		../../modules/home-manager/widgets/ags.nix
		../../modules/home-manager/window-managers/hyprland.nix
		../../modules/home-manager/disk-managers/udiskie.nix
		../../modules/home-manager/utilities/screenshot.nix
		../../modules/home-manager/utilities/system-monitor.nix
		../../modules/home-manager/utilities/zip.nix
		../../modules/home-manager/utilities/fzf.nix
		../../modules/home-manager/utilities/eza.nix
		../../modules/home-manager/utilities/bat.nix
		../../modules/home-manager/utilities/zoxide.nix
		../../modules/home-manager/browsers/floorp.nix
		../../modules/home-manager/browsers/firefox.nix
		../../modules/home-manager/menu/rofi.nix
		../../modules/home-manager/extra/discord.nix
		../../modules/home-manager/file-managers/lf.nix
		../../modules/home-manager/image-viewers/feh.nix
		../../modules/home-manager/sound/easyeffects.nix
		../../modules/home-manager/shells/zsh.nix
		../../modules/home-manager/shells/oh-my-posh/oh-my-posh.nix
		../../modules/home-manager/shells/starship.nix
		../../modules/home-manager/note-taking/obsidian.nix
		../../modules/home-manager/development/godot.nix
		../../modules/home-manager/development/dotnet.nix
		../../modules/home-manager/development/git.nix
		../../modules/home-manager/development/nvim.nix
		../../modules/home-manager/development/docker.nix
		../../modules/home-manager/mail/thunderbird.nix
		../../modules/home-manager/music/mpd.nix
		../../modules/home-manager/music/ncmpcpp.nix
	];

	widgets.ags.enable = true;
	widgets.ags.autostart = true;

	hyprland.enable = true;
	hyprland.utilities.hyprpaper.enable = true;
	hyprland.utilities.hyprpicker.enable = true;
	hyprland.utilities.hyprcursor.enable = true;
	hyprland.utilities.hyprpaper.wallpaper = ../../wallpapers/samus_wallpaper.png;
	hyprland.utilities.hyprpaper.autostart = true;

	xdg.mimeApps.defaultApplications = {
		"text/plain" = [ "nvim.desktop" ];
		"image/png" = [ "feh.desktop" ];
	};

	xdg.desktopEntries = {
		davinci-resolve = {
			name = "Davinci Resolve";
			genericName = "Video Editor";
			exec = "davinci-resolve";
			terminal = false;
			categories = [ "Application" "Video" ];
		};
	};

	nixpkgs.config.allowUnfree = true;

	# Home Manager needs a bit of information about you and the paths it should
	# manage.
	home.username = "humberto";
	home.homeDirectory = "/home/humberto";

	# This value determines the Home Manager release that your configuration is
	# compatible with. This helps avoid breakage when a new Home Manager release
	# introduces backwards incompatible changes.
	#
	# You should not change this value, even if you update Home Manager. If you do
	# want to update the value, then make sure to first check the Home Manager
	# release notes.
	home.stateVersion = "23.11"; # Please read the comment before changing.

	# The home.packages option allows you to install Nix packages into your
	# environment.
	home.packages = with pkgs; [
		calibre
		keepassxc
		tmux
		nwg-look
		pcmanfm
		obs-studio
		davinci-resolve
		nodejs_22
		bun
		vscode-fhs
		lazygit
		sass
		sassc
		
		mongosh
		mongodb-compass

		postman
		tlrc

		jetbrains.idea-community
		jetbrains.jdk
		javaPackages.openjfx21
		scenebuilder


		openssl

		gamemode
		gamescope

		imagemagick
		# # Adds the 'hello' command to your environment. It prints a friendly
		# # "Hello, world!" when run.
		# pkgs.hello

		# # It is sometimes useful to fine-tune packages, for example, by applying
		# # overrides. You can do that directly here, just don't forget the
		# # parentheses. Maybe you want to install Nerd Fonts with a limited number of
		# # fonts?
		# (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

		# # You can also create simple shell scripts directly inside your
		# # configuration. For example, this adds a command 'my-hello' to your
		# # environment:
		# (pkgs.writeShellScriptBin "my-hello" ''
		#		echo "Hello, ${config.home.username}!"
		# '')
	];

	gtk = {
			enable = true;
			font.name = "TeX Gyre Adventor 10";
			cursorTheme = {
				name = "macOS-BigSur-White";
				package = pkgs.apple-cursor;
				size = 32;
			};
			theme = {
				name = "WhiteSur-Dark";
				package = pkgs.whitesur-gtk-theme;
			};
			iconTheme = {
				name = "WhiteSur-dark";
				package = pkgs.whitesur-icon-theme;
			};

			gtk3.extraConfig = {
			Settings = ''
				gtk-application-prefer-dark-theme=1
			'';
		};

			gtk4.extraConfig = {
			Settings = ''
				gtk-application-prefer-dark-theme=1
			'';
		};
	}; 


	#gnome outside gnome
	dconf = {
		enable = true;
		settings = {
			"org/gnome/desktop/interface" = {
				color-scheme = "prefer-dark";
				theme = "Juno";
			};
		};
	};


	# Home Manager is pretty good at managing dotfiles. The primary way to manage
	# plain files is through 'home.file'.
	home.file = {
		# # Building this configuration will create a copy of 'dotfiles/screenrc' in
		# # the Nix store. Activating the configuration will then make '~/.screenrc' a
		# # symlink to the Nix store copy.
		# ".screenrc".source = dotfiles/screenrc;

		# # You can also set the file content immediately.
		# ".gradle/gradle.properties".text = ''
		#		org.gradle.console=verbose
		#		org.gradle.daemon.idletimeout=3600000
		# '';
	};

	# Home Manager can also manage your environment variables through
	# 'home.sessionVariables'. These will be explicitly sourced when using a
	# shell provided by Home Manager. If you don't want to manage your shell
	# through Home Manager then you have to manually source 'hm-session-vars.sh'
	# located at either
	#
		# ../../modules/home-manager/gaming/steam.nix
	#  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
	#
	# or
	#
	#  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
	#
	# or
	#
	#  /etc/profiles/per-user/humberto/etc/profile.d/hm-session-vars.sh
	#
	home.sessionVariables = {
		EDITOR = "nvim";
	};

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
