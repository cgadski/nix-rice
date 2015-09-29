# overrides packages to exactly the versioning I want
{
  allowUnfree = true;
  # packageOverrides = pkgs: {
    # flashplayer = pkgs.flashplayer.overrideDerivation (attrs: rec {
      # version = "11.2.202.481";
      # src = pkgs.fetchurl {
        # url = "http://fpdownload.adobe.com/get/flashplayer/pdc/${version}/install_flash_player_11_linux.x86_64.tar.gz";
        # sha256 = "151di671xqywjif3v4hbsfw55jyd5x5qjq2zc92xw367pssi29yz";
      # };
    # });
  # };
}
