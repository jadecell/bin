{
  perSystem = {
    pkgs,
    lib,
    ...
  }: let
    bashDeps = rec {
      extract = with pkgs; [
        gnutar # tar
        xz # unlzma, unxz
        bzip2 # bunzip2
        unar # .rar
        gzip # gunzip, uncompress
        p7zip # .7z
        cabextract # cabextract
        unzip
        gnused
        zstd
      ];

      musicimport = with pkgs; [
        fzf
      ];
      wallsort = [];
      update-system = [];
    };
  in {
    packages =
      lib.attrsets.mapAttrs (
        name: path:
          pkgs.writeShellApplication {
            name = "${name}";
            runtimeInputs = path;
            text = builtins.readFile ./src/${name};
          }
      )
      bashDeps;
  };
}
