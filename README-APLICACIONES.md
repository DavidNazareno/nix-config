# 📱 Lista de Aplicaciones - Configuración Nix

Esta guía detalla todas las aplicaciones y herramientas incluidas en la configuración Nix, organizadas por categoría y método de instalación.

## 📋 Índice

- [Herramientas de Sistema (Nix Packages)](#herramientas-de-sistema-nix-packages)
- [Aplicaciones macOS (Homebrew Casks)](#aplicaciones-macos-homebrew-casks)
- [Herramientas CLI (Homebrew Brews)](#herramientas-cli-homebrew-brews)
- [Aplicaciones Mac App Store](#aplicaciones-mac-app-store)
- [Configuraciones de Usuario](#configuraciones-de-usuario)
- [Configuraciones Específicas](#configuraciones-específicas)

---

## 🔧 Herramientas de Sistema (Nix Packages)

### Desarrollo y DevOps
- **act** - Ejecuta GitHub Actions localmente
- **ansible** - Herramienta de automatización y gestión de configuración
- **go** - Lenguaje de programación Go
- **hugo** - Generador de sitios web estáticos
- **just** - Ejecutor de comandos similar a make pero más simple
- **kubectl** - Cliente de línea de comandos para Kubernetes
- **terraform** - Herramienta de infraestructura como código
- **nodejs** - Runtime de JavaScript
- **colmena** - Herramienta de despliegue para NixOS
- **hcloud** - CLI para Hetzner Cloud
- **lima** - Máquinas virtuales Linux en macOS
- **talosctl** - CLI para Talos Linux

### Utilidades de Sistema
- **btop** - Monitor de recursos del sistema (alternativa moderna a htop)
- **coreutils** - Utilidades básicas de GNU
- **jq** - Procesador de JSON en línea de comandos
- **comma** - Ejecuta programas sin instalarlos permanentemente
- **nix** - Gestor de paquetes Nix
- **git-crypt** - Cifrado transparente de archivos en repositorios Git
- **yt-dlp** - Descargador de videos de YouTube y otros sitios
- **get_iplayer** - Descargador de contenido de BBC iPlayer
- **beszel** - Herramienta de monitoreo de sistema

### Fuentes (Nerd Fonts)
- **fira-code** - Fuente monoespaciada con ligaduras
- **hack** - Fuente diseñada para código fuente
- **jetbrains-mono** - Fuente oficial de JetBrains
- **meslo-lg** - Fuente basada en Menlo con glifos adicionales
- **symbols-only** - Solo símbolos e iconos

### Extensiones VSCode
- **ms-vscode-remote.remote-ssh** - Extensión para desarrollo remoto via SSH

---

## 🖥️ Aplicaciones macOS (Homebrew Casks)

### Creatividad y Multimedia
- **adobe-creative-cloud** - Suite de aplicaciones creativas de Adobe
- **audacity** - Editor de audio gratuito y de código abierto
- **obs** - Software de grabación y streaming
- **flameshot** - Herramienta de captura de pantalla
- **vlc** - Reproductor multimedia universal

### Desarrollo
- **visual-studio-code** - Editor de código de Microsoft
- **ghostty** - Terminal moderno y rápido
- **alacritty** - Terminal acelerado por GPU
- **iterm2** - Terminal avanzado para macOS
- **orbstack** - Alternativa rápida a Docker Desktop

### Comunicación
- **discord** - Plataforma de comunicación para gamers
- **element** - Cliente de Matrix para comunicación segura
- **signal** - Mensajería segura y privada
- **slack** - Plataforma de comunicación empresarial
- **claude** - Asistente de IA de Anthropic

### Productividad
- **notion** - Espacio de trabajo todo-en-uno
- **obsidian** - Aplicación de toma de notas con enlaces
- **raycast** - Lanzador de aplicaciones y herramientas
- **hammerspoon** - Automatización y scripting para macOS
- **karabiner-elements** - Personalizador de teclado

### Utilidades del Sistema
- **istat-menus** - Monitor del sistema en la barra de menú
- **jordanbaird-ice** - Organizador de iconos de la barra de menú
- **easy-move-plus-resize** - Redimensionar ventanas fácilmente
- **omnidisksweeper** - Analizador de uso de disco
- **bentobox** - Organizador de archivos

### Hardware y Periféricos
- **elgato-camera-hub** - Software para cámaras Elgato
- **elgato-control-center** - Centro de control para dispositivos Elgato
- **elgato-stream-deck** - Software para Stream Deck
- **logitech-options** - Software para dispositivos Logitech
- **displaylink** - Drivers para monitores DisplayLink

### Entretenimiento
- **spotify** - Servicio de streaming de música
- **plexamp** - Reproductor de música de Plex
- **steam** - Plataforma de juegos
- **openttd** - Simulador de transporte de código abierto
- **openscad** - Software de modelado 3D

### Navegadores
- **firefox** - Navegador web de Mozilla
- **google-chrome** - Navegador web de Google

### Fuentes Adicionales
- **font-fira-code** - Fuente Fira Code
- **font-fira-code-nerd-font** - Fira Code con iconos Nerd Font
- **font-fira-mono-for-powerline** - Fira Mono para Powerline
- **font-hack-nerd-font** - Hack con iconos Nerd Font
- **font-jetbrains-mono-nerd-font** - JetBrains Mono con iconos
- **font-meslo-lg-nerd-font** - Meslo LG con iconos Nerd Font

### Audio Profesional (Rogue Amoeba)
- **audio-hijack** - Grabación y enrutamiento de audio
- **farrago** - Reproductor de efectos de sonido
- **loopback** - Enrutamiento de audio virtual
- **soundsource** - Control avanzado de audio

### Herramientas Especializadas
- **mqtt-explorer** - Cliente MQTT para IoT
- **music-decoy** - Previene que iTunes se abra automáticamente
- **macwhisper** - Transcripción de audio usando Whisper
- **lm-studio** - Interfaz para modelos de lenguaje local

---

## ⚡ Herramientas CLI (Homebrew Brews)

- **neovim** - Editor de texto modal avanzado
- **ollama** - Ejecuta modelos de IA localmente

---

## 🏪 Aplicaciones Mac App Store

### Productividad
- **Amphetamine** (937984704) - Mantiene la Mac despierta
- **Bitwarden** (1352778147) - Gestor de contraseñas
- **Fantastical** (975937182) - Calendario avanzado
- **Todoist** (585829637) - Gestor de tareas
- **Keynote** (409183694) - Presentaciones de Apple
- **Numbers** (409203825) - Hoja de cálculo de Apple
- **Pages** (409201541) - Procesador de texto de Apple

### Utilidades
- **AutoMounter** (1160435653) - Montaje automático de volúmenes
- **Disk Speed Test** (425264550) - Prueba de velocidad de disco
- **Resize Master** (1025306797) - Redimensionador de imágenes
- **rCmd** (1596283165) - Lanzador de aplicaciones
- **Snippety** (1530751461) - Gestor de snippets de código
- **The Unarchiver** (425424353) - Descompresor de archivos
- **UTM** (1538878817) - Virtualización en Apple Silicon

### Comunicación y Redes
- **Telegram** (747648890) - Mensajería instantánea
- **Microsoft Remote Desktop** (1295203466) - Escritorio remoto
- **Wireguard** (1451685025) - VPN moderna y segura
- **Home Assistant Companion** (1099568401) - Control de domótica

### Creatividad
- **Creator's Best Friend** (1524172135) - Herramientas para creadores
- **DaVinci Resolve** (571213070) - Editor de video profesional
- **Final Cut Pro** (424389933) - Editor de video de Apple

### Redes Sociales
- **Ivory for Mastodon by Tapbots** (6444602274) - Cliente de Mastodon
- **Perplexity** (6714467650) - Motor de búsqueda con IA

---

## 👤 Configuraciones de Usuario

### Shell y Terminal
- **Zsh** - Shell avanzado con autocompletado y sugerencias
- **Bash** - Shell tradicional de Unix
- **Starship** - Prompt personalizable y rápido
- **Tmux** - Multiplexor de terminal con configuración personalizada

### Herramientas de Desarrollo
- **Git** - Control de versiones con configuración personalizada
- **GPG** - Cifrado y firma digital
- **SSH** - Acceso remoto seguro con configuración personalizada
- **Direnv** - Carga automática de variables de entorno

### Navegación y Archivos
- **Eza** - Listado de archivos moderno (sucesor de ls)
- **Fzf** - Buscador difuso interactivo
- **Zoxide** - Navegación inteligente de directorios
- **Lf** - Gestor de archivos en terminal

### Monitoreo y Utilidades
- **Htop** - Monitor de procesos interactivo
- **Bat** - Visualizador de archivos con sintaxis resaltada
- **Alacritty** - Terminal configurado via Home Manager
- **Nix-index** - Índice de paquetes Nix para búsqueda rápida

---

## ⚙️ Configuraciones Específicas

### Aerospace (Gestor de Ventanas)
- **Configuración**: `home/aerospace/aerospace.toml`
- **Propósito**: Gestor de ventanas tipo tiling para macOS
- **Características**: 
  - Layouts automáticos (tiles/accordion)
  - Orientación automática según el monitor
  - Integración con borders para efectos visuales
  - Atajos de teclado personalizables

### Ghostty (Terminal)
- **Configuración**: `home/ghostty/config`
- **Propósito**: Terminal moderno y rápido
- **Características**:
  - Tema Nord
  - Fuente BerkeleyMono Nerd Font
  - Integración con Zsh
  - Configuración de ventana personalizada

### Neovim
- **Configuración**: `home/nvim/`
- **Archivos**: `options.lua`, `keymap.lua`, `plugins/`
- **Propósito**: Editor de texto modal avanzado
- **Estado**: Configuración comentada (no activa actualmente)

### Starship
- **Configuración**: `home/starship/starship.toml`
- **Propósito**: Prompt personalizable para shell
- **Características**: Integración con Zsh y Bash

---

## 🔐 Gestión de Secretos

El sistema utiliza **SOPS** (Secrets OPerationS) para el manejo seguro de secretos:
- Cifrado con claves age
- Archivo de secretos: `secrets/secrets.yaml`
- Configuración en `.sops.yaml`

---

## 📚 Recursos Adicionales

- **Home Manager Options**: [Búsqueda de opciones](https://mipmip.github.io/home-manager-option-search)
- **Nix Packages**: [Búsqueda de paquetes](https://search.nixos.org/packages)
- **Homebrew**: [Búsqueda de fórmulas](https://formulae.brew.sh/)

---

## 🎯 Notas de Uso

1. **Instalación**: Las aplicaciones se instalan automáticamente al aplicar la configuración
2. **Actualización**: Usar `just update` para actualizar paquetes
3. **Personalización**: Modificar los archivos de configuración según necesidades
4. **Compatibilidad**: Configuración optimizada para macOS (Darwin) y NixOS

Esta configuración proporciona un entorno completo de desarrollo y productividad con herramientas modernas y configuraciones optimizadas.