#!/bin/bash

set -e

echo "🔄 Actualizando sistema..."
sudo apt update

echo "📦 Instalando dependencias de compilación..."
sudo apt install -y git cmake make g++ pkg-config

echo "📦 Instalando bibliotecas Qt y KDE necesarias..."
sudo apt install -y \
  qtbase5-dev qtdeclarative5-dev qttools5-dev qttools5-dev-tools \
  qml-module-qtquick-controls qml-module-qtquick-controls2 qml-module-qtgraphicaleffects \
  qtquickcontrols2-5-dev libqt5x11extras5-dev libpolkit-qt5-1-dev \
  libkf5coreaddons-dev libkf5i18n-dev libkf5windowsystem-dev libkf5idletime-dev

echo "📦 Instalando dependencias de X11 y XCB..."
sudo apt install -y \
  libx11-dev libxext-dev libxrandr-dev libx11-xcb-dev libxcb-randr0-dev libsm-dev \
  libxcb-util-dev libxcb-image0-dev libxcb-xfixes0-dev libxcb-damage0-dev \
  libxcb-composite0-dev libxcb-shm0-dev libxcb-dpms0-dev libxcb-keysyms1-dev \
  libxtst-dev libxi-dev libxcursor-dev

echo "📦 Instalando dependencias de entrada y servidor gráfico..."
sudo apt install -y \
  libinput-dev xserver-xorg-dev xserver-xorg-input-synaptics-dev

echo "📦 Instalando otras dependencias útiles..."
sudo apt install -y \
  libpam0g-dev libpolkit-agent-1-dev libpolkit-gobject-1-dev libdbus-1-dev libdbusmenu-qt5-dev

echo "📁 Clonando repositorio principal de Cutefish Desktop..."
mkdir -p ~/cutefish && cd ~/cutefish
git clone https://github.com/cutefishos/core.git
cd core

echo "🔨 Compilando Cutefish Desktop..."
mkdir -p build && cd build
cmake ..
make -j$(nproc)

echo "✅ Compilación finalizada. Puedes instalar con: sudo make install"

