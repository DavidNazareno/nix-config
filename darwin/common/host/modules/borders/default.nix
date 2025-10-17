{ pkgs, ... }:
{
  services.jankyborders = {
    enable = true;
    package = pkgs.jankyborders;

    style = "round";
    width = 6.0;
    hidpi = false;
    active_color="0xc0e2e2e3";
	  inactive_color="0xc02c2e34";
	  background_color="0x302c2e34";
  };
}
