{
  description = "FrameGraph";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      rec {
        packages = flake-utils.lib.flattenTree {
          framegraph = pkgs.stdenv.mkDerivation {
            pname = "framegraph";
            version = "0.1";
            buildInputs = [pkgs.perl];
            src = ./.;
            installPhase = ''
              mkdir -p $out/bin
              cp *.pl $out/bin/
            '';
          };
        };
        defaultPackage = packages.framegraph;
      }
    );
}
