{ pkgs, ... }: {
	programs.thunderbird.enable = true;
	programs.thunderbird.profiles.default = {
		isDefault = true;
	};

	accounts.email.accounts.humberto = {
		address = "alemanhumberto06@gmail.com";
		primary = true;
		realName = "Humberto Aleman";
		thunderbird.enable = true;
	};

	accounts.email.accounts.kimbix = {
		address = "alemanhumberto106@gmail.com";
		primary = false;
		realName = "Kimbix";
		thunderbird.enable = true;
	};

	accounts.email.accounts.university = {
		address = "haleman.23@est.ucab.edu.ve";
		primary = false;
		realName = "Humberto Aleman Odreman";
		thunderbird.enable = true;
	};

	accounts.email.accounts.nsfw = {
		address = "thegreatkimbixarchive@gmail.com";
		primary = false;
		realName = "KKCruzin";
		thunderbird.enable = true;
	};
}
