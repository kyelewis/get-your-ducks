{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/007ccf2f";
  };

  outputs = { self, nixpkgs }: 
  let 
    pkgs = import nixpkgs { 
      system = "x86_64-linux";
    };

    in with pkgs; {
      devShells.x86_64-linux.default = mkShell {
        buildInputs = [ 
          nodejs-16_x 
          nodePackages.pnpm 
        ];
      };
    };
}
    
