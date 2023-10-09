#!/bin/sh

# This script installs the Nix package manager on your system by
# downloading a binary distribution and running its installer script
# (which in turn creates and populates /nix).

{ # Prevent execution if this script was only partially downloaded
oops() {
    echo "$0:" "$@" >&2
    exit 1
}

umask 0022

tmpDir="$(mktemp -d -t nix-binary-tarball-unpack.XXXXXXXXXX || \
          oops "Can't create temporary directory for downloading the Nix binary tarball")"
cleanup() {
    rm -rf "$tmpDir"
}
trap cleanup EXIT INT QUIT TERM

require_util() {
    command -v "$1" > /dev/null 2>&1 ||
        oops "you do not have '$1' installed, which I need to $2"
}

case "$(uname -s).$(uname -m)" in
    Linux.x86_64)
        hash=eb838a533ca280a3639cea47bfc43f5527f72a21d84ba1078aee206837bc0158
        path=k4wqfhcx1yf5c4hi847nkwg2srkr7r66/nix-2.18.1-x86_64-linux.tar.xz
        system=x86_64-linux
        ;;
    Linux.i?86)
        hash=df679509a9c8d924616f301d2a99df20233a701618b5359c9e4948c20f3fb931
        path=ha4xxsq8lxyx9v6py7jjaizcqqw9qcy9/nix-2.18.1-i686-linux.tar.xz
        system=i686-linux
        ;;
    Linux.aarch64)
        hash=8465f88eb7dc5127d919934961c7a9e8712d300ada51d4f5a560f4a7e05700d5
        path=vdg37c1l55172g8w7w4r2hnvak7bm6m3/nix-2.18.1-aarch64-linux.tar.xz
        system=aarch64-linux
        ;;
    Linux.armv6l)
        hash=cddc610a2d40ecaf6ce85a47af7bdf074a9331aca6e21c9f4d9f59d4eaf1e0d0
        path=559dzrg5lqp2703vmxwvylhdy6jal1nb/nix-2.18.1-armv6l-linux.tar.xz
        system=armv6l-linux
        ;;
    Linux.armv7l)
        hash=c6493994b006f1786a338956d03ac2fd6a8739db7447f97c4279148ebfba1e15
        path=gwwpkmj5pdbh2nghdi7vg9xbmgh9f4ny/nix-2.18.1-armv7l-linux.tar.xz
        system=armv7l-linux
        ;;
    Darwin.x86_64)
        hash=435ba3569dd968ae4e725792c8ed222eb11ba7adc032ca58c7cf9a64169d44cc
        path=5bwbrwkxygfmgfsxcgw5bj34pbn73j1a/nix-2.18.1-x86_64-darwin.tar.xz
        system=x86_64-darwin
        ;;
    Darwin.arm64|Darwin.aarch64)
        hash=eed9a8dee2e4ceffd2c7a5dc67e567d15a49926c01ab170422ddd0035a94d7d5
        path=jcg291j00kswx3qsxg2p2lanr02wp5nd/nix-2.18.1-aarch64-darwin.tar.xz
        system=aarch64-darwin
        ;;
    *) oops "sorry, there is no binary distribution of Nix for your platform";;
esac

# Use this command-line option to fetch the tarballs using nar-serve or Cachix
if [ "${1:-}" = "--tarball-url-prefix" ]; then
    if [ -z "${2:-}" ]; then
        oops "missing argument for --tarball-url-prefix"
    fi
    url=${2}/${path}
    shift 2
else
    url=https://releases.nixos.org/nix/nix-2.18.1/nix-2.18.1-$system.tar.xz
fi

tarball=$tmpDir/nix-2.18.1-$system.tar.xz

require_util tar "unpack the binary tarball"
if [ "$(uname -s)" != "Darwin" ]; then
    require_util xz "unpack the binary tarball"
fi

if command -v curl > /dev/null 2>&1; then
    fetch() { curl --fail -L "$1" -o "$2"; }
elif command -v wget > /dev/null 2>&1; then
    fetch() { wget "$1" -O "$2"; }
else
    oops "you don't have wget or curl installed, which I need to download the binary tarball"
fi

echo "downloading Nix 2.18.1 binary tarball for $system from '$url' to '$tmpDir'..."
fetch "$url" "$tarball" || oops "failed to download '$url'"

if command -v sha256sum > /dev/null 2>&1; then
    hash2="$(sha256sum -b "$tarball" | cut -c1-64)"
elif command -v shasum > /dev/null 2>&1; then
    hash2="$(shasum -a 256 -b "$tarball" | cut -c1-64)"
elif command -v openssl > /dev/null 2>&1; then
    hash2="$(openssl dgst -r -sha256 "$tarball" | cut -c1-64)"
else
    oops "cannot verify the SHA-256 hash of '$url'; you need one of 'shasum', 'sha256sum', or 'openssl'"
fi

if [ "$hash" != "$hash2" ]; then
    oops "SHA-256 hash mismatch in '$url'; expected $hash, got $hash2"
fi

unpack=$tmpDir/unpack
mkdir -p "$unpack"
tar -xJf "$tarball" -C "$unpack" || oops "failed to unpack '$url'"

script=$(echo "$unpack"/*/install)

[ -e "$script" ] || oops "installation script is missing from the binary tarball!"
export INVOKED_FROM_INSTALL_IN=1
"$script" "$@"

} # End of wrapping
