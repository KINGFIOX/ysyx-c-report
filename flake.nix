{
  description = "reveal.js presentation development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nodejs_22
            nodePackages.gulp-cli
            git
          ];

          shellHook = ''
            if [ ! -d node_modules ]; then
              echo "📦 正在安装依赖..."
              npm install --silent
            fi
            echo "🎯 reveal.js 答辩 PPT 环境已就绪"
            echo "   运行: gulp serve"
          '';
        };
      }
    );
}
