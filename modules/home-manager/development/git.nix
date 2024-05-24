{ ... }: {
  programs.git.enable = true;
  programs.git.aliases = {
    user-kimbix = "config user.name \"Kimbix\" && git config user.email \"alemanhumberto06@gmail.com\"";
    user-uni = "config user.name \"HumbertoAleman\" && git config user.email \"haleman.23@est.ucab.edu.ve\"";
  };

	programs.git.delta = {
		enable = true;
		options = {
			navigate = true;
			side-by-side = true;
			features = "decorations";
		};
	};
}
