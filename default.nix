let
 pkgs = import (fetchTarball "https://github.com/rstats-on-nix/nixpkgs/archive/ec4b92d9b1484d5e102acf81e22ad0ba308644ce.tar.gz") {};
  rix = [(pkgs.rPackages.buildRPackage {
            name = "rix";
            src = pkgs.fetchgit {
              url = "https://github.com/b-rodrigues/rix";
              branchName = "master";
              rev = "82890b30cb3315e264993da344cd46a8d1ee7aab";
              sha256 = "sha256-WahxciCco6pF+5trK5kuTNEQtopQbspPhi2W34CNVuE=";
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
