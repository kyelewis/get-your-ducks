{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/007ccf2f";
  };
  outputs = { self, nixpkgs }: 
  let 
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in with pkgs; {
      devShells.x86_64-linux.default = mkShell {
        buildInputs = [ nodejs-16_x nodePackages.pnpm zlib zlib.dev swift pkgconfig ];
        shellHook = ''
          export LD_LIBRARY_PATH=${zlib}/lib
          export DYLD_LIBRARY_PATH=${zlib}/lib
        '';
      };
    };
}
    
