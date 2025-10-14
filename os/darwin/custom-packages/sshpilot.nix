{ pkgs, lib, stdenv, fetchurl, undmg, ... }:

stdenv.mkDerivation rec {
  pname = "sshpilot";
  version = "4.3.6";

  src = fetchurl {
    url = "https://github.com/mfat/sshpilot/releases/download/v${version}/sshPilot-macOS-${version}-aarch64.dmg";
    sha256 = "b608da9d9891d1a31c19090aed14a6401d932d11d18d86df2a7e7a4b5a67dab8";
  };

  nativeBuildInputs = [ undmg ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/Applications
    cp -r "sshPilot.app" $out/Applications/
    
    # Crear enlace simbólico en bin para acceso desde terminal
    mkdir -p $out/bin
    ln -s $out/Applications/sshPilot.app/Contents/MacOS/sshPilot $out/bin/sshpilot
    
    runHook postInstall
  '';

  meta = with lib; {
    description = "SSH connection manager for macOS";
    longDescription = ''
      sshPilot is a modern SSH connection manager for macOS that provides
      an intuitive interface for managing SSH connections, tunnels, and keys.
    '';
    homepage = "https://github.com/mfat/sshpilot";
    license = licenses.unfree; # Verificar licencia real
    platforms = platforms.darwin;
    maintainers = [ ];
  };
}