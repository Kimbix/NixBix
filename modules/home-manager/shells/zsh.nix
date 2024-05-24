{ config, pkgs, ... }: {
	programs.fzf.enableZshIntegration = true;
	programs.eza.enableZshIntegration = true;
	programs.zoxide.enableZshIntegration = true;

	programs.zsh = {
		enable = true;

		history = {
			share = true;
			size = 10000;
			save = 10000;
			path = "$HOME/.zsh_history";

			ignoreSpace = true;
			ignoreDups = true;
			ignoreAllDups = true;
		};

		antidote.enable = true;
		antidote.plugins = [
			"zsh-users/zsh-syntax-highlighting"
			"zsh-users/zsh-completions"
			"zsh-users/zsh-autosuggestions"
			"aloxaf/fzf-tab"
			"romkatv/powerlevel10k"
		];

		shellAliases = {
			nix-rebuild-default = "sudo nixos-rebuild switch --flake \"path://${config.home.homeDirectory}/.sources/nix/#default\"";
			ls = "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions";
			tree = "eza --tree --level=2";
			cd = "z";
			cat = "bat -p";
		};

		initExtra = ''
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

_fzf_comprun() {
	local command=$1
	shift

	case "$command" in
		cd)						fzf --preview "eza --tree --color=always {} | head -200" "$@" ;;
		export|unset)	fzf --preview "eval \'echo \\$\'" ;;
		ssh)					fzf --preview "dig {}" ;;
		*)						fzf --preview "$show_file_or_dir_preview" "$@" ;;
	esac
}
		'';
		initExtraFirst = ''
bindkey -v

# P10K Config, should probably source it from a github
P10K_CONFIG="${config.home.homeDirectory}/.p10k.zsh"
if [ -f "$P10K_CONFIG" ]; then
	source "$P10K_CONFIG"
fi

# FZFGIT package, actually sourcing it from a github
FZFGIT_DIR="${config.home.homeDirectory}/.fzf-git/"
if [ -f "''${FZFGIT_DIR}/fzf-git.sh" ]; then
	source "''${FZFGIT_DIR}/fzf-git.sh"
fi
		'';
	};

	home.file.".fzf-git/".source = builtins.fetchGit {
		url = "https://github.com/junegunn/fzf-git.sh.git";
		rev = "bd8ac4ba4c9d7d12b34f7fa2b0d334f50cdb5254";
	};
}
