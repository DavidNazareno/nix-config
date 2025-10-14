{ pkgs, lib, stdenv, fetchurl, dpkg, autoPatchelfHook, ... }:

stdenv.mkDerivation rec {
  pname = "sshpilot";
  version = "4.3.6";

  src = fetchurl {
    url = "https://github.com/mfat/sshpilot/releases/download/v${version}/sshpilot_${version}-1_all.deb";
    sha256 = "7c571467dcdb4975cd9fe054b3a94786e18dad535d473cc4611173b8c72f80c1";
  };

  nativeBuildInputs = [ 
    dpkg 
    autoPatchelfHook 
  ];

  buildInputs = with pkgs; [
    # Dependencias comunes para aplicaciones GUI en Linux
    gtk3
    glib
    cairo
    pango
    gdk-pixbuf
    atk
    at-spi2-atk
    dbus
    libdrm
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libxcb
    mesa
    expat
    libxkbcommon
    alsa-lib
    nss
    nspr
    cups
  ];

  unpackPhase = ''
    runHook preUnpack
    dpkg-deb -x $src .
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    
    # Copiar archivos del paquete DEB
    mkdir -p $out
    cp -r usr/* $out/
    
    # Asegurar permisos ejecutables
    if [ -f $out/bin/sshpilot ]; then
      chmod +x $out/bin/sshpilot
    fi
    
    # Copiar archivos de aplicación si existen
    if [ -d opt ]; then
      mkdir -p $out/opt
      cp -r opt/* $out/opt/
    fi
    
    runHook postInstall
  '';

  meta = with lib; {
    description = "SSH connection manager for Linux";
    longDescription = ''
      sshPilot is a modern SSH connection manager for Linux that provides
      an intuitive interface for managing SSH connections, tunnels, and keys.
    '';
    homepage = "https://github.com/mfat/sshpilot";
    license = licenses.unfree; # Verificar licencia real
    platforms = platforms.linux;
    maintainers = [ ];
  };
}