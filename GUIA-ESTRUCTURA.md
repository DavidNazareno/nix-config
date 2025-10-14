# Guía de Estructura - Configuración Nix Darwin

Esta es una guía completa para entender la estructura y componentes de tu configuración de Nix Darwin. Este proyecto es un fork personalizado que combina **nix-darwin** (para macOS) y **NixOS** (para Linux) con **home-manager** para gestionar configuraciones de usuario.

## 📁 Estructura General del Proyecto

```
nix-config/
├── 🔧 Archivos de Configuración Principal
├── 🏠 Configuraciones de Usuario (home/)
├── 🖥️  Configuraciones de Hosts (hosts/)
├── 📚 Librerías y Utilidades (lib/)
├── 🔐 Secretos y Seguridad
├── 📊 Datos y Configuraciones Específicas
└── 🛠️  Herramientas de Desarrollo
```

---

## 🔧 Archivos de Configuración Principal

### `flake.nix` - El Corazón del Sistema
**¿Qué es?** El archivo principal que define todas las dependencias y configuraciones del sistema.

**Componentes clave:**
- **Inputs**: Define las fuentes de paquetes y herramientas
  - `nixpkgs`: Paquetes estables de NixOS 24.11
  - `nixpkgs-unstable`: Paquetes más recientes
  - `nix-darwin`: Para configuraciones de macOS
  - `home-manager`: Para configuraciones de usuario
  - `nix-homebrew`: Integración con Homebrew
  - `sops-nix`: Manejo de secretos

- **Outputs**: Define las configuraciones de sistemas
  - **darwinConfigurations**: Sistemas macOS (nauvis, mac-studio, mba15, baldrick, magrathea)
  - **colmena**: Para despliegue remoto de sistemas NixOS

### `justfile` - Automatización de Comandos
**¿Qué es?** Un archivo de automatización similar a Makefile pero más moderno.

**Comandos principales:**
- `just` o `just switch`: Construye y aplica la configuración
- `just build`: Solo construye sin aplicar
- `just trace`: Construye con información de depuración
- `just update`: Actualiza todas las dependencias

### `.envrc` - Entorno de Desarrollo
**¿Qué es?** Configuración para `direnv` que carga automáticamente el entorno de desarrollo cuando entras al directorio.

---

## 🏠 Configuraciones de Usuario (`home/`)

### `alex.nix` - Configuración Principal del Usuario
**¿Qué contiene?**
- Configuración de programas CLI (git, fzf, eza, direnv)
- Configuración de shell y herramientas de desarrollo
- Configuraciones específicas de aplicaciones

### Configuraciones de Aplicaciones:
- **`aerospace/`**: Gestor de ventanas para macOS
- **`ghostty/`**: Terminal moderno
- **`nvim/`**: Editor Neovim con plugins y configuraciones
- **`starship/`**: Prompt personalizado para terminal

---

## 🖥️ Configuraciones de Hosts (`hosts/`)

### `common/` - Configuraciones Compartidas
- **`common-packages.nix`**: Paquetes instalados en todos los sistemas
- **`darwin-common.nix`**: Configuraciones base para macOS
- **`darwin-common-dock.nix`**: Configuración del Dock de macOS
- **`nixos-common.nix`**: Configuraciones base para Linux

### `darwin/` - Sistemas macOS
- **`baldrick/`**: Configuración específica para el sistema "baldrick"
  - Configuraciones personalizadas del Dock
  - Configuraciones específicas del hardware/uso

### `nixos/` - Sistemas Linux
- **`desktop/`**: Sistema de escritorio Linux
- **`ktz-cloud/`**: Servidor en la nube
- **`morphnix/`**: Sistema con agente Beszel
- **`nix-dev/`**: Sistema de desarrollo
- **`nvllama/`**: Sistema para IA/ML

---

## 📚 Librerías y Utilidades (`lib/`)

### `helpers.nix` - Funciones de Construcción
**¿Qué hace?** Define funciones para crear configuraciones de sistema de manera consistente.

**Función principal:**
- `mkDarwin`: Crea configuraciones de macOS con:
  - Configuraciones comunes
  - Home-manager integrado
  - Homebrew configurado
  - Overlays de paquetes

### `default.nix` - Exportador de Funciones
Exporta las funciones de `helpers.nix` para uso en el flake principal.

---

## 🔐 Secretos y Seguridad

### `.sops.yaml` - Configuración de Secretos
**¿Qué es SOPS?** Sistema para encriptar secretos usando claves Age/GPG.

**Configuración:**
- Define claves públicas para diferentes hosts
- Reglas de creación para archivos de secretos
- Permite compartir secretos de forma segura

### `secrets/secrets.yaml`
Archivo encriptado que contiene secretos como:
- Tokens de API
- Contraseñas
- Claves privadas

---

## 📊 Datos y Configuraciones Específicas (`data/`)

### `iStatMenus/`
Configuraciones exportadas de iStat Menus (monitor de sistema para macOS)

### `iterm2/`
Scripts de instalación y configuraciones para iTerm2

### `mac-dot-zshrc`
Configuración base de Zsh para macOS

---

## 🛠️ Herramientas de Desarrollo

### `shell.nix`
Define el entorno de desarrollo con herramientas necesarias para trabajar con el proyecto.

### `.github/workflows/`
Automatización CI/CD para validar las configuraciones.

### `testing/`
Configuraciones experimentales para probar nuevos sistemas.

---

## 🚀 Cómo Usar Este Sistema

### 1. **Aplicar Configuración**
```bash
just switch [hostname]  # Aplica configuración al sistema actual o especificado
```

### 2. **Solo Construir (sin aplicar)**
```bash
just build [hostname]   # Construye sin aplicar cambios
```

### 3. **Actualizar Dependencias**
```bash
just update            # Actualiza flake.lock con nuevas versiones
```

### 4. **Depuración**
```bash
just trace [hostname]  # Construye con información detallada de errores
```

---

## 🎯 Conceptos Clave para Entender

### **Flakes**
Sistema moderno de Nix que hace las configuraciones reproducibles y declarativas.

### **Home Manager**
Gestiona configuraciones de usuario (dotfiles, programas) de forma declarativa.

### **Nix Darwin**
Extensión de Nix para gestionar configuraciones de sistema en macOS.

### **Overlays**
Modificaciones a paquetes de nixpkgs (como usar Node.js 22 en lugar de la versión por defecto).

### **Colmena**
Herramienta para desplegar configuraciones NixOS a múltiples servidores remotos.

---

## 📝 Personalización

Para personalizar este sistema para tu uso:

1. **Cambia el usuario**: Modifica `alex.nix` o crea tu propio archivo de usuario
2. **Añade hosts**: Crea nuevas configuraciones en `hosts/darwin/` o `hosts/nixos/`
3. **Modifica paquetes**: Edita `common-packages.nix` para añadir/quitar software
4. **Configura aplicaciones**: Añade configuraciones en `home/`

---

## 🔍 Recursos Adicionales

- [Manual de Nix](https://nixos.org/manual/nix/stable/)
- [Home Manager Options](https://mipmip.github.io/home-manager-option-search/)
- [Nix Darwin Options](https://daiderd.com/nix-darwin/manual/index.html)
- [Flakes Tutorial](https://nixos.wiki/wiki/Flakes)

---

*Esta configuración es un sistema completo y modular que te permite gestionar múltiples máquinas (macOS y Linux) con configuraciones consistentes y reproducibles.*