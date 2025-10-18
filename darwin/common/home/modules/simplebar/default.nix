{
  inputs,
  system,
  pkgs,
  ...
}:
{
  # Configuración de simple-bar para Übersicht
  # Basado en: https://www.jeantinland.com/toolbox/simple-bar/

  # Configurar inicio automático de Übersicht
  launchd.agents.ubersicht = {
    enable = true;
    config = {
      ProgramArguments = [ "/Applications/Übersicht.app/Contents/MacOS/Übersicht" ];
      RunAtLoad = true;
      KeepAlive = true;
      Label = "com.user.ubersicht";
    };
  };

  # Configurar simple-bar
  home.activation.simple-bar = {
    after = [ "writeBoundary" ];
    before = [ ];
    data = ''
      # Crear directorio de widgets de Übersicht si no existe
      UBERSICHT_WIDGETS_DIR="$HOME/Library/Application Support/Übersicht/widgets"
      mkdir -p "$UBERSICHT_WIDGETS_DIR"
      
      # Clonar simple-bar si no existe o actualizarlo si ya existe
      SIMPLE_BAR_DIR="$UBERSICHT_WIDGETS_DIR/simple-bar"
      
      if [ ! -d "$SIMPLE_BAR_DIR" ]; then
        echo "Clonando simple-bar desde GitHub..."
        ${pkgs.git}/bin/git clone --depth 1 https://github.com/Jean-Tinland/simple-bar "$SIMPLE_BAR_DIR"
        echo "Simple Bar clonado exitosamente en $SIMPLE_BAR_DIR"
      else
        echo "Actualizando simple-bar..."
        cd "$SIMPLE_BAR_DIR"
        ${pkgs.git}/bin/git pull origin main || echo "No se pudo actualizar simple-bar, continuando..."
      fi
      
      # Asegurar permisos correctos
      chmod -R 755 "$SIMPLE_BAR_DIR" || true
      
      # Verificar que el directorio tiene el nombre correcto (requerido por simple-bar)
      if [ -d "$SIMPLE_BAR_DIR" ]; then
        echo "✅ Simple Bar instalado correctamente en: $SIMPLE_BAR_DIR"
        echo "📝 Para activar Simple Bar:"
        echo "   1. Übersicht se iniciará automáticamente"
        echo "   2. Activa el widget 'simple-bar-index-jsx' en la lista de widgets"
        echo "   3. La configuración personalizada se aplicará desde ~/.simplebarrc"
      else
        echo "❌ Error: No se pudo instalar Simple Bar"
      fi
    '';
  };

  # Configuración personalizada de simple-bar usando el archivo .simplebarrc
  # Simple Bar lee automáticamente este archivo desde el directorio home
  home.file.".simplebarrc" = {
    source = ./.simplebarrc;
    onChange = ''
      # Reiniciar Übersicht si está ejecutándose para aplicar cambios
      if pgrep -x "Übersicht" > /dev/null; then
        echo "Reiniciando Übersicht para aplicar cambios de configuración..."
        osascript -e 'tell application "Übersicht" to refresh'
      else
        echo "Übersicht no está ejecutándose. Inicia Übersicht manualmente para ver Simple Bar."
      fi
    '';
  };

  # Mensaje informativo
  home.activation.simple-bar-info = {
    after = [ "simple-bar" ];
    before = [ ];
    data = ''
      echo "✅ simple-bar configurado correctamente"
      echo "📋 Para usar simple-bar:"
      echo "   1. Übersicht se iniciará automáticamente con launchd"
      echo "   2. La barra debería aparecer automáticamente"
      echo "   3. Configuración personalizada en: ~/.simplebarrc"
      echo "   4. Window manager configurado para AeroSpace"
      echo ""
      echo "🔧 Para abrir configuración: Click en simple-bar + cmd+,"
    '';
  };
}