let
 pkgs = import (fetchTarball "https://github.com/rstats-on-nix/nixpkgs/archive/82c7a6368d7dce27d4445a39cb506cf8d5749b06.tar.gz") {};
  rix = [(pkgs.rPackages.buildRPackage {
            name = "rix";
            src = pkgs.fetchgit {
              url = "https://github.com/b-rodrigues/rix";
              branchName = "master";
              rev = "2bcd605e5b3f00582ec5262abf5f0cbefe26f905";
              sha256 = "sha256-7GAx0oVSSMYLOSBttQC1JxsLxaCriPJYCr59DhAiU+E=";
            };
            propagatedBuildInputs = builtins.attrValues {
              inherit (pkgs.rPackages) codetools httr jsonlite sys;
            };
         })
  ];
 system_packages = builtins.attrValues {
  inherit (pkgs) R glibcLocalesUtf8 quarto nix;
};
  in
  pkgs.mkShell {
    LOCALE_ARCHIVE = if pkgs.system == "x86_64-linux" then  "${pkgs.glibcLocalesUtf8}/lib/locale/locale-archive" else "";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";

    buildInputs = [ system_packages rix pkgs.rPackages.quarto pkgs.rPackages.targets pkgs.rPackages.tarchetypes];

    shellHook = '' Rscript -e "targets::tar_make()" '';
  }
