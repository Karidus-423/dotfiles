{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "Kanagawa";
  src = pkgs.fetchFromGitHub {
    owner = "Fausto-Korpsvart";
    repo = "Kanagawa-GKT-Theme";
    rev = "35936a1e3bbd329339991b29725fc1f67f192c1e";
    hash = "sha256-BZRmjVas8q6zsYbXFk4bCk5Ec/3liy9PQ8fqFGHAXe0=";
  };

  nativeBuildInputs = [
    pkgs.gtk3
  ];

  propagatedUserEnvPkgs = [
    pkgs.gtk-engine-murrine
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/themes
    cp -a themes/* $out/share/themes

    runHook postInstall
  '';
}
