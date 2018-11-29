let
  pkgs = import <nixpkgs> {};

  haskellPackages = pkgs.haskellPackages;

  elmPackages = pkgs.elmPackages;

  ghc =
    haskellPackages.ghcWithHoogle
    ( hs:
      with hs;
      [ text containers random bytestring
        aeson servant servant-server wai warp wai-extra
        websockets servant-websockets wai-middleware-static
        http-types cookie mtl
      ]
    );
in
  pkgs.mkShell {
    buildInputs = with pkgs; [ ghc haskellPackages.ghcid
                               libiconv elmPackages.elm ];
  }
