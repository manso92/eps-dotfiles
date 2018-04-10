#!/usr/bin/env bash


#############################################################################
# Boostrap.bash                                                             #
# Autor original: Manuel Blanc                                              #
# Repositorio original: https://github.com/ManuelBlanc/eps-dotfiles.git     #
# Modificacion: Pablo Marcos - 10-4-2018                                    #
#############################################################################

{ # Proteccion ejecuccion parcial

# Colorines
C_NORMAL=$(tput sgr0)
C_BOLD=$(tput bold)
C_RED=$(tput setaf 1)
C_GREEN=$(tput setaf 2)
C_YELLOW=$(tput setaf 3)
C_BLUE=$(tput setaf 4)
C_MAGENTA=$(tput setaf 5)
C_CYAN=$(tput setaf 6)
C_WHITE=$(tput setaf 7)

# Utilidades
info()  { echo "$C_GREEN==> $C_NORMAL$@$C_NORMAL";              	}
infoB() { echo "$C_GREEN==> $C_NORMAL${C_BOLD}$@$NORMAL";       	}
error() { echo "$C_RED==> $C_NORMAL${C_BOLD}error: $C_NORMAL$@";	}
abort() { error "$@"; exit 1;                                   	}
prompt() {
	read -p "${C_YELLOW}$1 ${C_BOLD}[S/n]${C_NORMAL} " # -n 1 -r
	[[ -z $REPLY || $REPLY =~ ^[YySs]$ ]]
	return $?
}

# ----------------------------------------------------------------------------

infoB "======================================================================"
infoB " eps-dotfiles -- instalacion/reconfiguracion"
infoB "======================================================================"

PREFIX="$HOME/UnidadH"
GITREPO="https://github.com/pablomm/eps-dotfiles.git"

# Preparacion
if ! test -d "$PREFIX" ; then

	PREFIX="$HOME"
	prompt "UnidadH no encontrada, instalar en $HOME/eps-dotfiles en su lugar?" || abort "Instalacion cancelada"
 	mkdir "$PREFIX/eps-dotfiles"
 	infoB "Clonando el repositorio"
	git clone --recursive -v "$GITREPO" "$PREFIX/eps-dotfiles"

else

	if [ -d "$PREFIX/eps-dotfiles" ]; then

		info "Encontrada instalacion existente en $PREFIX/eps-dotfiles, actualizando ..."
		(cd "$PREFIX/eps-dotfiles" && git pull --ff-only -v origin master && git submodule update)

	else
		prompt "Desea instalar en $PREFIX/eps-dotfiles ($GITREPO)?" || abort "instalacion abortada"
		infoB "Clonando el repositorio"
		git clone --recursive -v "$GITREPO" "$PREFIX/eps-dotfiles"
	fi

fi



source "$PREFIX/eps-dotfiles/setup"

info "Instalacion completada. Cierre la terminal para aplicar todos los cambios"

}
