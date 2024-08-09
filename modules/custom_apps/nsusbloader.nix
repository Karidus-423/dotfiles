{pkgs, fetchurl}:
pkgs.stdenv.mkDerivation rec {
	pname = "ns-usbloader";
	version = "7.1";
	src = fetchurl{
		url = "https://github.com/developersu/ns-usbloader/releases/download/v7.1/ns-usbloader-7.1.jar";
	};
	buildInputs = with pkgs;[java jdk11];
	installPhase = ''
		mkdir -p $out/bin
		cp ${pname} $out/bin
	'';
}
