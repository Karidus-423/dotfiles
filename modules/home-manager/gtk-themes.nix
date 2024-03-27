{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "Chicago95";
  src = pkgs.fetchFromGitHub {
    owner = "grassmunk";
    repo = "Chicago95";
    rev = "v3.01";
    sha256 = "";
  };
}

