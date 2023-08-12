pkgname=veilid-git
pkgver=v0.1.7.r23.g2d2983e
pkgrel=1
pkgdesc="Tools to support Veilid"
arch=('any')
url="https://gitlab.com/veilid/veilid/"
license=('Mozilla Public License Version 2.0')
depends=('rust' 'capnproto' 'protobuf')
source=("${_pkgname}"::"https://github.com/socketwench/veilid-git-archlinux.git")
sha512sums=('SKIP')

pkgver() {
    cd "$_pkgname"
    (   set -o pipefail
        git describe --long --tag | sed -r 's/([^-]*-g)/r\1/;s/-/./g' ||
        printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
    ) 2>/dev/null
}

prepare() {
    cd "$_pkgname"
    git clone --recurse-submodules git@gitlab.com:veilid/veilid.git .
    cargo install wasm-bindgen-cli wasm-pack
}

build() {
    cd "$_pkgname"
    cargo build --features=rt-tokio --manifest-path=veilid-tools/Cargo.toml
    cargo build --features=rt-tokio --manifest-path=veilid-core/Cargo.toml
    cargo build --features=rt-tokio --manifest-path=veilid-server/Cargo.toml
    cargo build --features=rt-tokio --manifest-path=veilid-cli/Cargo.toml
}

package() {
    cd "$_pkgname"
    install -Dm644 target/debug/libveilid_tools.so "${pkgdir}/usr/lib/libveilid_tools.so"
    install -Dm644 target/debug/libveilid_core.so "${pkgdir}/usr/lib/libveilid_core.so"
    install -Dm644 target/debug/veilid-cli "${pkgdir}/usr/bin/veilid-cli"
    install -Dm644 target/debug/veilid-server "${pkgdir}/usr/bin/veilid-server"
}

