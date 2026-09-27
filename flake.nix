{
  description = "LispFuck: a Brainfuck interpreter/debugger in Common Lisp.";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/e158d9ed9b51c98974c5e66e1ba1c9e0255fecaa";
  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAll = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in {
      packages = forAll (pkgs: with pkgs; rec {
        brain = sbcl.buildASDFSystem {
          pname = "brain";
          version = "0.0.1";
          src = (lib.cleanSourceWith { src = "${self}/code"; filter = p: _: !(lib.hasSuffix ".fasl" p || lib.hasPrefix ".#" (baseNameOf p)); });
          systems = [ "brain" ];
          lispLibs = [  ];
          meta = { description = "LispFuck: a Brainfuck interpreter/debugger in Common Lisp."; homepage = "https://github.com/equwal/LispBrain"; license = lib.licenses.mit; };
        };
        default = brain;
        # an SBCL with this system (and its dependencies) preloaded: `nix run .#sbcl`
        sbcl-with = sbcl.withPackages (ps: [ brain ]);
      });
      apps = forAll (pkgs: {
        sbcl = { type = "app"; program = "${self.packages.${pkgs.system}.sbcl-with}/bin/sbcl"; };
      });
    };
}
