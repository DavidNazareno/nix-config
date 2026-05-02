#!/bin/bash

# Nix Configuration Helper Script
# Facilita la ejecución de comandos comunes de nix-darwin

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Obtener hostname
HOSTNAME=$(hostname | cut -d "." -f 1)
SUDO_KEEPALIVE_PID=""

cleanup() {
    if [ -n "$SUDO_KEEPALIVE_PID" ] && kill -0 "$SUDO_KEEPALIVE_PID" 2>/dev/null; then
        kill "$SUDO_KEEPALIVE_PID" 2>/dev/null || true
    fi
}

trap cleanup EXIT

# Función para mostrar el banner
show_banner() {
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    Nix Configuration Helper                  ║"
    echo "║                      Host: $HOSTNAME                        ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Función para mostrar el menú principal
show_menu() {
    echo -e "${BLUE}Selecciona una opción:${NC}"
    echo
    echo -e "${GREEN}📦 Configuración del Sistema:${NC}"
    echo "  1) 🔨 Build (construir sin aplicar)"
    echo "  2) 🔄 Switch (construir y aplicar)"
    echo "  3) 🔍 Trace (build con --show-trace)"
    echo "  4) ℹ️  Info (mostrar información del sistema)"
    echo
    echo -e "${YELLOW}🧹 Mantenimiento:${NC}"
    echo "  5) 🗑️  Clean (limpiar generaciones antiguas)"
    echo "  6) 🗂️  GC (garbage collection completo)"
    echo "  7) 📥 Update (actualizar flake inputs)"
    echo
    echo -e "${PURPLE}🔧 Validación:${NC}"
    echo "  8) ✅ Check (verificar configuración)"
    echo
    echo -e "${CYAN}🚀 Colmena (si está disponible):${NC}"
    echo "  9) 🏗️  Colmena Build"
    echo " 10) 🚀 Colmena Apply"
    echo
    echo -e "${RED}❌ Salir:${NC}"
    echo " 11) 🚪 Salir"
    echo
}

# Función para ejecutar comandos con feedback
execute_command() {
    local cmd="$1"
    local description="$2"
    
    echo -e "${BLUE}Ejecutando: ${description}${NC}"
    echo -e "${YELLOW}Comando: ${cmd}${NC}"
    echo
    
    if eval "$cmd"; then
        echo -e "${GREEN}✅ ${description} completado exitosamente${NC}"
    else
        echo -e "${RED}❌ Error ejecutando: ${description}${NC}"
        return 1
    fi
}

# Solicitar sudo solo cuando sea necesario y mantener la sesión viva
ensure_sudo() {
    if sudo -v; then
        if [ -z "$SUDO_KEEPALIVE_PID" ] || ! kill -0 "$SUDO_KEEPALIVE_PID" 2>/dev/null; then
            while true; do
                sudo -n true
                sleep 60
                kill -0 "$$" 2>/dev/null || exit
            done >/dev/null 2>&1 &
            SUDO_KEEPALIVE_PID=$!
        fi
    else
        echo -e "${RED}❌ No se pudieron obtener permisos de administrador${NC}"
        return 1
    fi
}

# Ejecutar comandos que requieren privilegios
execute_privileged_command() {
    local cmd="$1"
    local description="$2"

    if ! ensure_sudo; then
        return 1
    fi

    execute_command "$cmd" "$description"
}

# Función para confirmar acciones destructivas
confirm_action() {
    local action="$1"
    echo -e "${YELLOW}⚠️  Estás a punto de ejecutar: ${action}${NC}"
    read -p "¿Continuar? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${RED}Operación cancelada${NC}"
        return 1
    fi
    return 0
}

# Función para mostrar información del host
show_host_info() {
    echo -e "${CYAN}Información del Host:${NC}"
    echo "Hostname: $HOSTNAME"
    echo "OS: $(uname -s)"
    echo "Arquitectura: $(uname -m)"
    echo "Usuario: $(whoami)"
    echo "Directorio actual: $(pwd)"
    echo
}

check_conflicting_apps() {
    local has_conflict=0
    local apps=(
        "Visual Studio Code"
        "Code"
        "VSCodium"
        "Zed"
        "Ghostty"
        "iTerm2"
    )

    for app in "${apps[@]}"; do
        if pgrep -x "$app" >/dev/null 2>&1; then
            if [ $has_conflict -eq 0 ]; then
                echo -e "${YELLOW}⚠️  Hay aplicaciones abiertas que pueden bloquear el garbage collection:${NC}"
                has_conflict=1
            fi
            echo "  - $app"
        fi
    done

    if [ $has_conflict -eq 1 ]; then
        echo
        echo -e "${YELLOW}Cierra esas apps y vuelve a intentar el GC para evitar errores con /nix/store.${NC}"
        return 1
    fi

    return 0
}

# Función principal
main() {
    show_banner
    show_host_info
    
    while true; do
        show_menu
        read -p "Ingresa tu opción (1-11): " choice
        echo
        
        case $choice in
            1)
                execute_command "nix --extra-experimental-features 'nix-command flakes' build \".#darwinConfigurations.$HOSTNAME.system\"" "Build de la configuración"
                ;;
            2)
                if confirm_action "Switch a nueva configuración"; then
                    execute_command "nix --extra-experimental-features 'nix-command flakes' build \".#darwinConfigurations.$HOSTNAME.system\"" "Build de la configuración"
                    if [ $? -eq 0 ]; then
                        if ensure_sudo; then
                            # Configurar safe.directory para root antes de ejecutar
                            sudo git config --global --add safe.directory "$(pwd)"
                            execute_command "sudo ./result/sw/bin/darwin-rebuild switch --flake \".#$HOSTNAME\"" "Switch a nueva configuración"
                        fi
                    fi
                fi
                ;;
            3)
                execute_command "nix --extra-experimental-features 'nix-command flakes' build \".#darwinConfigurations.$HOSTNAME.system\" --show-trace" "Build con trace"
                ;;
            4)
                execute_command "nix --extra-experimental-features 'nix-command flakes' eval \".#darwinConfigurations.$HOSTNAME.system\" --apply 'sys: sys.config.system.stateVersion'" "Información del sistema"
                ;;
            5)
                if confirm_action "Limpiar generaciones antiguas"; then
                    if check_conflicting_apps; then
                        execute_privileged_command "sudo nix-collect-garbage --delete-older-than 30d && sudo nix-store --gc" "Limpieza de generaciones"
                    fi
                fi
                ;;
            6)
                if confirm_action "Garbage collection completo"; then
                    if check_conflicting_apps; then
                        execute_privileged_command "sudo nix-collect-garbage -d && sudo nix-collect-garbage --delete-older-than 7d && sudo nix-store --gc" "Garbage collection"
                    fi
                fi
                ;;
            7)
                execute_command "nix flake update" "Actualización de flake inputs"
                ;;
            8)
                execute_command "nix flake check" "Verificación de configuración"
                ;;
            9)
                if command -v colmena &> /dev/null; then
                    execute_command "colmena build" "Colmena Build"
                else
                    echo -e "${RED}❌ Colmena no está instalado${NC}"
                fi
                ;;
            10)
                if command -v colmena &> /dev/null; then
                    if confirm_action "Colmena Apply"; then
                        execute_command "colmena apply" "Colmena Apply"
                    fi
                else
                    echo -e "${RED}❌ Colmena no está instalado${NC}"
                fi
                ;;
            11)
                echo -e "${GREEN}👋 ¡Hasta luego!${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}❌ Opción inválida. Por favor selecciona 1-11.${NC}"
                ;;
        esac
        
        echo
        read -p "Presiona Enter para continuar..."
        clear
        show_banner
    done
}

# Verificar si estamos en el directorio correcto
if [ ! -f "flake.nix" ]; then
    echo -e "${RED}❌ Error: No se encontró flake.nix en el directorio actual${NC}"
    echo -e "${YELLOW}Por favor ejecuta este script desde el directorio raíz de tu configuración nix${NC}"
    exit 1
fi

# Verificar si estamos en macOS
if [ "$(uname)" != "Darwin" ]; then
    echo -e "${RED}❌ Error: Este script está diseñado para macOS con nix-darwin${NC}"
    exit 1
fi

# Ejecutar función principal
main
