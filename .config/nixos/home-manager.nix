{ config, pkgs, ... }:
let
 home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz;
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.pandy = {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "24.11";
    #home.stateVersion = "18.09";
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "pandy";
    home.homeDirectory = "/home/pandy";
    home.sessionPath = [
      "$HOME/bin"
      "$HOME/bin/work"
    ];
    # home.file.".config/hosts".source = ../hosts;
    #xdg.configFile.".config/alacritty/alacritty.toml".source = .dotfiles/alacritty.toml;
    programs.home-manager.enable = true;
  };
}
