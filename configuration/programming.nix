{ config, pkgs, inputs, ... }:

let
in {
  environment.systemPackages = with pkgs; [
    lua5_1
    luarocks
    go
    stylua
    tree-sitter
    gnumake

    (python311.withPackages
      (ps: with ps; [ numpy pandas jupyterlab tensorflow matplotlib ]))
  ];

}
