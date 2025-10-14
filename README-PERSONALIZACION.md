# 🔧 Guía de Personalización - Configuración Nix

Esta guía te llevará paso a paso para personalizar completamente la configuración Nix heredada de Alex Kretzschmar y adaptarla a tu entorno personal con tu Mac Mini y portátil Lenovo.

## 📋 Índice

- [Preparación Inicial](#preparación-inicial)
- [Paso 1: Configurar Usuario Personal](#paso-1-configurar-usuario-personal)
- [Paso 2: Personalizar Configuración Git](#paso-2-personalizar-configuración-git)
- [Paso 3: Configurar Hosts Específicos](#paso-3-configurar-hosts-específicos)
- [Paso 4: Ajustar Configuraciones del Sistema](#paso-4-ajustar-configuraciones-del-sistema)
- [Paso 5: Personalizar Aplicaciones](#paso-5-personalizar-aplicaciones)
- [Paso 6: Configurar Secretos (Opcional)](#paso-6-configurar-secretos-opcional)
- [Paso 7: Aplicar y Probar](#paso-7-aplicar-y-probar)
- [Solución de Problemas](#solución-de-problemas)

---

## 🚀 Preparación Inicial

### ✅ Estado Actual
Ya has configurado correctamente:
- ✅ `dnz-mac-mini` en `darwinConfigurations`
- ✅ `dnz-linux-lenovo` en `darwinConfigurations` (⚠️ **PROBLEMA**: usando `mkDarwin` para Linux)

### 🔍 Problemas Identificados
1. **Usuario hardcodeado**: Toda la configuración usa "alex" como usuario por defecto
2. **Configuración Linux incorrecta**: `dnz-linux-lenovo` usa `mkDarwin` en lugar de `mkNixOS`
3. **Datos personales**: Email y nombre de Alex en configuraciones Git

---

## 📝 Paso 1: Configurar Usuario Personal

### 1.1 Crear tu archivo de configuración personal

```bash
# Crear tu archivo de configuración personal
cp home/alex.nix home/davidnazareno.nix
```

### 1.2 Personalizar `home/davidnazareno.nix`

Edita el archivo y cambia:

```nix
# ANTES (líneas 46-47)
programs.git = {
  enable = true;
  userEmail = "alexktz@gmail.com";
  userName = "Alex Kretzschmar";

# DESPUÉS
programs.git = {
  enable = true;
  userEmail = "tu-email@gmail.com";           # ← Cambia por tu email
  userName = "David Nazareno";                # ← Cambia por tu nombre
```

### 1.3 Actualizar configuración SSH (opcional)

Si tienes configuraciones SSH específicas, personaliza la sección:

```nix
programs.ssh = {
  enable = true;
  enableDefaultConfig = false;
  extraConfig = ''
    StrictHostKeyChecking no
  '';
  matchBlocks = {
    "*" = {
      user = "davidnazareno";  # ← Cambia si usas otro usuario por defecto
      extraOptions = {
        UserKnownHostsFile = "/dev/null";
        LogLevel = "ERROR";
      };
    };
    "github.com" = {
      hostname = "ssh.github.com";
      port = 443;
    };
  };
};
```

---

## 🔧 Paso 2: Personalizar Configuración Git

### 2.1 Configurar Git globalmente

En `home/davidnazareno.nix`, personaliza la configuración Git:

```nix
programs.git = {
  enable = true;
  userEmail = "tu-email@gmail.com";
  userName = "Tu Nombre Completo";
  diff-so-fancy.enable = true;
  lfs.enable = true;
  extraConfig = {
    init = {
      defaultBranch = "main";  # o "master" si prefieres
    };
    merge = {
      conflictStyle = "diff3";
      tool = "meld";  # o tu herramienta preferida
    };
    pull = {
      rebase = true;  # o false si prefieres merge
    };
  };
};
```

---

## 🖥️ Paso 3: Configurar Hosts Específicos

### 3.1 Actualizar `lib/helpers.nix`

Cambia el usuario por defecto:

```nix
# ANTES (línea 3)
mkDarwin = { hostname, username ? "alex", system ? "aarch64-darwin",}:

# DESPUÉS
mkDarwin = { hostname, username ? "davidnazareno", system ? "aarch64-darwin",}:
```

### 3.2 Corregir configuración Linux en `flake.nix`

**⚠️ PROBLEMA CRÍTICO**: Tu Lenovo usa `mkDarwin` pero debería usar `mkNixOS`.

**Opción A: Si el Lenovo ejecuta NixOS**
```nix
# En flake.nix, ELIMINAR esta línea:
dnz-linux-lenovo = libx.mkDarwin { hostname = "dnz-linux-lenovo"; };

# Y AGREGAR en la sección nixosConfigurations (que necesitas crear):
nixosConfigurations = {
  dnz-linux-lenovo = libx.mkNixOS { 
    hostname = "dnz-linux-lenovo"; 
    username = "davidnazareno";
    system = "x86_64-linux";
  };
};
```

**Opción B: Si el Lenovo ejecuta macOS (poco probable)**
```nix
# Mantener pero corregir el sistema:
dnz-linux-lenovo = libx.mkDarwin { 
  hostname = "dnz-linux-lenovo"; 
  username = "davidnazareno";
  system = "x86_64-darwin";  # Si es Intel Mac
};
```

**Opción C: Si el Lenovo ejecuta Linux pero quieres usar nix-darwin**
```nix
# Eliminar completamente la línea del Lenovo por ahora
# dnz-linux-lenovo = libx.mkDarwin { hostname = "dnz-linux-lenovo"; };
```

### 3.3 Crear directorios de hosts específicos

```bash
# Para Mac Mini
mkdir -p hosts/darwin/dnz-mac-mini
echo '{ ... }: { }' > hosts/darwin/dnz-mac-mini/default.nix

# Para Lenovo (si usas NixOS)
mkdir -p hosts/nixos/dnz-linux-lenovo
echo '{ ... }: { }' > hosts/nixos/dnz-linux-lenovo/default.nix
```

---

## ⚙️ Paso 4: Ajustar Configuraciones del Sistema

### 4.1 Actualizar `hosts/common/darwin-common.nix`

```nix
# ANTES (línea 18)
system.primaryUser = "alex";

# DESPUÉS
system.primaryUser = "davidnazareno";
```

### 4.2 Actualizar configuraciones de usuario en hosts NixOS

Si tienes hosts NixOS, actualiza cada archivo en `hosts/nixos/*/default.nix`:

```nix
# Buscar y reemplazar en todos los archivos NixOS:
# ANTES
users.users.alex = {
  description = "alex";

# DESPUÉS
users.users.davidnazareno = {
  description = "David Nazareno";
```

---

## 📱 Paso 5: Personalizar Aplicaciones

### 5.1 Revisar aplicaciones en `hosts/common/common-packages.nix`

Revisa la lista de paquetes y comenta/descomenta según tus necesidades:

```nix
# Ejemplo: Si no usas Terraform
# pkgs.terraform

# Ejemplo: Si quieres agregar una herramienta
pkgs.htop
pkgs.neofetch  # ← Agregar si quieres
```

### 5.2 Personalizar aplicaciones macOS en `hosts/common/darwin-common.nix`

Revisa las secciones `brews`, `casks` y `masApps`:

```nix
casks = [
  # Comentar aplicaciones que no uses
  # "adobe-creative-cloud"  # ← Si no tienes licencia
  
  # Agregar aplicaciones que necesites
  "1password"  # ← Si usas 1Password en lugar de Bitwarden
];
```

### 5.3 Personalizar configuraciones específicas

**Ghostty Terminal:**
```bash
# Editar home/ghostty/config
# Cambiar fuente si no tienes BerkeleyMono:
font-family = "JetBrains Mono Nerd Font"  # En lugar de BerkeleyMono
```

**Starship Prompt:**
```bash
# Revisar home/starship/starship.toml
# Personalizar según tus preferencias
```

---

## 🔐 Paso 6: Configurar Secretos (Opcional)

### 6.1 Generar nuevas claves age

```bash
# Generar nueva clave age
age-keygen -o ~/.config/sops/age/keys.txt

# Obtener la clave pública
age-keygen -y ~/.config/sops/age/keys.txt
```

### 6.2 Actualizar `.sops.yaml`

```yaml
keys:
  - &davidnazareno age1tu_clave_publica_aqui  # ← Tu nueva clave

creation_rules:
  - path_regex: secrets/secrets.yaml$
    key_groups:
    - age:
      - *davidnazareno  # ← Usar tu clave
```

---

## 🚀 Paso 7: Aplicar y Probar

### 7.1 Verificar configuración

```bash
# Verificar sintaxis del flake
nix flake check

# Ver qué se va a construir
nix build .#darwinConfigurations.dnz-mac-mini.system --dry-run
```

### 7.2 Aplicar configuración

```bash
# Actualizar dependencias
just update

# Aplicar configuración
just switch

# O manualmente:
darwin-rebuild switch --flake .#dnz-mac-mini
```

### 7.3 Verificar que funciona

```bash
# Verificar usuario actual
whoami  # Debería mostrar: davidnazareno

# Verificar configuración Git
git config --global user.name
git config --global user.email

# Verificar hostname
hostname  # Debería mostrar: dnz-mac-mini.local
```

---

## 🔧 Solución de Problemas

### Error: "user 'alex' not found"

**Causa**: Referencias hardcodeadas al usuario "alex"

**Solución**:
```bash
# Buscar todas las referencias a "alex"
grep -r "alex" . --exclude-dir=.git

# Reemplazar manualmente cada ocurrencia
```

### Error: "file 'home/davidnazareno.nix' not found"

**Causa**: No creaste tu archivo de configuración personal

**Solución**:
```bash
cp home/alex.nix home/davidnazareno.nix
```

### Error: "mkNixOS function not found"

**Causa**: La función `mkNixOS` está comentada

**Solución**: Usar solo `mkDarwin` para macOS o implementar `mkNixOS` para Linux

### Problemas con Homebrew

**Causa**: Homebrew configurado para usuario "alex"

**Solución**: Verificar que `lib/helpers.nix` use tu usuario en la configuración de nix-homebrew

---

## 📚 Comandos Útiles

```bash
# Ver configuración actual
darwin-rebuild --list-generations

# Rollback si algo falla
darwin-rebuild rollback

# Limpiar generaciones antiguas
sudo nix-collect-garbage -d

# Ver qué paquetes están instalados
nix-env -q

# Actualizar solo el flake.lock
nix flake update

# Reconstruir sin aplicar
nix build .#darwinConfigurations.dnz-mac-mini.system
```

---

## 🎯 Checklist Final

- [ ] ✅ Creado `home/davidnazareno.nix`
- [ ] ✅ Actualizado email y nombre en Git
- [ ] ✅ Cambiado usuario por defecto en `lib/helpers.nix`
- [ ] ✅ Actualizado `system.primaryUser` en `darwin-common.nix`
- [ ] ✅ Corregido configuración Linux en `flake.nix`
- [ ] ✅ Creado directorios de hosts específicos
- [ ] ✅ Personalizado aplicaciones según necesidades
- [ ] ✅ Configurado secretos (si es necesario)
- [ ] ✅ Probado `nix flake check`
- [ ] ✅ Aplicado con `just switch`
- [ ] ✅ Verificado que todo funciona

---

## 🆘 ¿Necesitas Ayuda?

Si encuentras problemas:

1. **Revisa los logs**: `darwin-rebuild switch --flake .#dnz-mac-mini --show-trace`
2. **Verifica sintaxis**: `nix flake check`
3. **Rollback si es necesario**: `darwin-rebuild rollback`
4. **Consulta la documentación**: 
   - [Nix Darwin](https://github.com/LnL7/nix-darwin)
   - [Home Manager](https://nix-community.github.io/home-manager/)

¡Con esta guía deberías tener tu configuración Nix completamente personalizada! 🎉