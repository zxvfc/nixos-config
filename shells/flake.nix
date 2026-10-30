{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      jdk = pkgs.jdk21;

      kmp-lsp = pkgs.rustPlatform.buildRustPackage rec {
        pname = "kmp-lsp";
        version = "0.27.0";
        src = pkgs.fetchFromGitHub {
          owner = "Hessesian";
          repo = "kmp-lsp";
          tag = "v${version}";
          hash = "sha256-6F9g0bgsFooHzE9r1byBox13OW09MKfPOGhpCo4G0lk=";
        };
        cargoHash = "sha256-GGkb8KWc2ZicSOKMErS+a97PT983weioDyE79HRxa4I=";
        doCheck = false;
      };
      ktrs = pkgs.rustPlatform.buildRustPackage rec {
        pname = "ktrs";
        version = "0.5.3";
        src = pkgs.fetchFromGitHub {
          owner = "Hexay";
          repo = "ktrs";
          tag = "v${version}";
          hash = "sha256-ifDWBEIh0rGPlmB0HTVIwyC5P6/deoplTx4PoZ2+Rmo=";
        };
        cargoHash = "sha256-yQYnjxxVj36Q4y1yEiKGwKRgLI+ulg5t7YRO4qAS7ic=";
        doCheck = false;
      };
      jvmPackages = [
        (pkgs.gradle_9.override { java = jdk; })
        jdk
        kmp-lsp
        ktrs
        pkgs.kotlin
        pkgs.ripgrep
        pkgs.fd
      ];
      postgressPackages = [ pkgs.postgresql ];
      postgressHook = ''
        PG_NAME="$(basename "$PWD")"
        export PGDATA="$HOME/.local/share/pg/$PG_NAME/data"
        export PGHOST="''${XDG_RUNTIME_DIR:-/tmp}/pg-$PG_NAME"
        mkdir -p "$PGHOST"
        if [ ! -d "$PGDATA" ]; then
          mkdir -p "$(dirname "$PGDATA")"
          initdb --no-locale -E UTF8 >/dev/null
          printf "unix_socket_directories = '%s'\nlisten_addresses = '''\n" "$PGHOST" >> "$PGDATA/postgresql.conf"
        fi
      '';
    in
    {
      devShells.${system} = {
        jvm = pkgs.mkShell { packages = jvmPackages; };
        postgress = pkgs.mkShell {
          packages = postgressPackages;
          shellHook = postgressHook;
        };
        jvm-postgress = pkgs.mkShell {
          packages = jvmPackages ++ postgressPackages;
          shellHook = postgressHook;
        };
      };
    };
}
