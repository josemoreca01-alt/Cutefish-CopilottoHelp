#!/bin/bash

set -e

BASE_DIR=~/cutefish/modules
OUTPUT_DIR=~/cutefish-packages
mkdir -p "$OUTPUT_DIR"

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

for modulo in "${MODULOS[@]}"; do
  BUILD_DIR="$BASE_DIR/$modulo/build"
  PKG_DIR="$OUTPUT_DIR/${modulo}-package"

  if [ ! -d "$BUILD_DIR" ]; then
    echo "❌ No se encontró build para $modulo, omitiendo..."
    continue
  fi

  echo "🔐 Corrigiendo permisos en $BUILD_DIR..."
  sudo chown -R $USER:$USER "$BUILD_DIR"

  echo "📦 Instalando $modulo en directorio temporal..."
  make -C "$BUILD_DIR" DESTDIR="$PKG_DIR" install

  echo "🗂️ Creando metadatos del paquete .deb..."
  mkdir -p "$PKG_DIR/DEBIAN"
  cat <<EOF > "$PKG_DIR/DEBIAN/control"
Package: cutefish-$modulo
Version: 0.8.2
Section: x11
Priority: optional
Architecture: amd64
Depends: qtbase5-dev, libkf5coreaddons5, libkf5i18n5, libkf5windowsystem5
Maintainer: TuNombre <tu@email.com>
Description: Cutefish module: $modulo
 This package contains the $modulo component of the Cutefish Desktop Environment.
EOF

  echo "📦 Generando paquete .deb para $modulo..."
  dpkg-deb --build "$PKG_DIR" "$OUTPUT_DIR/cutefish-$modulo.deb"

  echo "✅ Paquete generado: $OUTPUT_DIR/cutefish-$modulo.deb"
done

echo "🎉 Todos los paquetes .deb han sido generados correctamente."
