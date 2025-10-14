# Instalación de Nix y Home Manager en Ubuntu

Esta guía te ayudará a instalar Nix y configurar Home Manager en tu sistema Ubuntu existente.

## 1. Instalar Nix

Ejecuta el siguiente comando para instalar Nix:

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

Después de la instalación, reinicia tu terminal o ejecuta:

```bash
source /etc/profile
```

## 2. Habilitar Flakes

Crea el directorio de configuración de Nix:

```bash
mkdir -p ~/.config/nix
```

Crea el archivo de configuración:

```bash
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
```

## 3. Clonar la configuración

Clona este repositorio en tu directorio home:

```bash
cd ~
git clone https://github.com/tu-usuario/nix-config.git
cd nix-config
```

## 4. Instalar Home Manager

Ejecuta el siguiente comando para instalar Home Manager con tu configuración:

```bash
nix run home-manager/release-25.05 -- switch --flake .#davidnazareno@dnz-linux-lenovo
```

## 5. Activar la configuración

Una vez instalado, puedes actualizar tu configuración ejecutando:

```bash
home-manager switch --flake .#davidnazareno@dnz-linux-lenovo
```

## 6. Comandos útiles

- **Actualizar la configuración**: `home-manager switch --flake .#davidnazareno@dnz-linux-lenovo`
- **Verificar la configuración**: `nix flake check`
- **Actualizar las dependencias**: `nix flake update`
- **Limpiar generaciones antiguas**: `nix-collect-garbage -d`

## Notas importantes

- Esta configuración usa Home Manager standalone, no NixOS completo
- Los paquetes se instalarán en tu perfil de usuario, no a nivel del sistema
- Puedes personalizar la configuración editando `common/home/davidnazareno.nix`