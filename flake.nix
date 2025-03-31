{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    pix2tex-src = {
      url = "github:lukas-blecher/LaTeX-OCR";
      flake = false;
    };
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;
      pix2tex = pkgs.callPackage ./nix { inherit inputs; };
    in
    {
      packages.aarch64-darwin = {
        default = pix2tex;
        all = pix2tex.overrideAttrs (old: {
          propagatedBuildInputs = old.propagatedBuildInputs ++ (old.passthru.optional-dependencies.all or []);
        });
        api = pix2tex.overrideAttrs (old: {
          propagatedBuildInputs = old.propagatedBuildInputs ++ (old.passthru.optional-dependencies.api or []);
        });
        gui = pix2tex.overrideAttrs (old: {
          propagatedBuildInputs = old.propagatedBuildInputs ++ (old.passthru.optional-dependencies.gui or []);
        });
        highlight = pix2tex.overrideAttrs (old: {
          propagatedBuildInputs = old.propagatedBuildInputs ++ (old.passthru.optional-dependencies.highlight or []);
        });
        train = pix2tex.overrideAttrs (old: {
          propagatedBuildInputs = old.propagatedBuildInputs ++ (old.passthru.optional-dependencies.train or []);
        });
      };
    };
}
