#!/usr/bin/env bash

REQUIRED_PACKAGES=(
  # Requirements for building Swift on Linux
  git
  cmake
  ninja-build
  clang
  python
  uuid-dev
  libicu-dev
  icu-devtools
  libbsd-dev
  libedit-dev
  libxml2-dev
  libsqlite3-dev
  libkqueue-dev
  swig
  libpython-dev
  libncurses5-dev
  pkg-config
  libblocksruntime-dev
  libcurl4-openssl-dev
  autoconf
  libtool
  systemtap-sdt-dev

  # Requirements for helping below
  curl
  unzip
)

# Update packages
apt-get update -y

# Install required packages
apt-get install -y ${REQUIRED_PACKAGES[@]}

# Create workspace
cd /vagrant
mkdir -p swift-dev && cd swift-dev

# Download Android NDK
curl "https://dl.google.com/android/repository/android-ndk-r14b-linux-x86_64.zip" > android-ndk-r14b.zip

# Unarchive download
unzip android-ndk-r14b.zip

# Add to PATH
export PATH="/vagrant/swift-dev/android-ndk-r14b:$PATH"

# Download appropriate `libiconv` and `libicu` binaries that are compatible with Android
git clone --depth 1 https://github.com/SwiftAndroid/libiconv-libicu-android.git
./libiconv-libicu-android/build.sh

# Clone Swift repository
git clone --depth 1 https://github.com/apple/swift.git

# Download Swift dependencies
./swift/utils/update-checkout --clone

# Build Swift with Android target
./swift/utils/build-script -R \
  --android \
  --android-ndk /vagrant/android-ndk-r14b \
  --android-api-level 21 \
  --android-icu-uc /vagrant/libiconv-libicu-android/armeabi-v7a \
  --android-icu-uc-include /vagrant/libiconv-libicu-android/armeabi-v7a/icu/source/common \
  --android-icu-i18n /vagrant/libiconv-libicu-android/armeabi-v7a \
  --android-icu-i18n-include /vagrant/libiconv-libicu-android/armeabi-v7a/icu/source/i18n/
