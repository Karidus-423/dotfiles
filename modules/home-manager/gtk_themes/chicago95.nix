{pkgs}:
pkgs.stdenv.mkDerivation{
    name = "Chicago95";
    buildInputs = [pkgs.gdk-pixbuf pkgs.xfce.xfce4-panel-profiles];
    src = pkgs.fetchFromGitHub {
        owner = "grassmunk";
        repo = "Chicago95";
        rev = "v3.0.1";
        sha256 = "EHcDIct2VeTsjbQWnKB2kwSFNb97dxuydAu+i/VquBA=";
    };
    installPhase = ''
    runHook preInstall
    mkdir -p $out/share/{themes,icons,sounds}
    cp -r Theme/Chicago95 $out/share/themes
    cp -r Icons/* $out/share/icons
    cp -r Cursors/* $out/share/icons
    cp -r sounds/Chicago95 $out/share/sounds
    runHook postInstall
  '';
}
