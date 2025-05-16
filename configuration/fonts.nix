{ config, pkgs, inputs, ... }:

let
in {
  fonts.packages = with pkgs; [
    google-fonts
    fira-code
    jetbrains-mono

    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];

}
