#!/bin/bash

set -e

# Ruta base donde están los módulos descargados
BASE_DIR=~/cutefish/modules

# Lista de módulos locales que quieres compilar
MODULOS=(
  dock
  launcher
  statusbar
  settings
  filemanager
  terminal
  screenlocker
  screenshot
  libcutefish
)

# Compilar cada módulo
for modulo in "${MODULOS[@]}"; do
  echo "🔧 Compilando $modulo..."
  cd "$BASE_DIR/$modulo"

  mkdir -p build && cd build
  cmake ..
  make -j$(nproc)
  sudo make install

  echo "✅ $modulo compilado e instalado."
done

echo "🎉 Todos los módulos han sido compilados correctamente."

