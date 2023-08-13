pkgname=veilid-git
pkgrel=1
pkgdesc="Tools to support Veilid"
arch=('any')
url="https://gitlab.com/veilid/veilid/"
license=('Mozilla Public License Version 2.0')
depends=('git' 'rust' 'capnproto' 'protobuf')

prepare() {
    cd "$_pkgname"
    if [ -d veilid-git ]; then rm -Rf veilid-git; fi
    git clone --recurse-submodules https://gitlab.com/veilid/veilid.git veilid-git
    cargo install wasm-bindgen-cli wasm-pack
}

pkgver() {
    cd "$_pkgname"
    cd veilid-git
    (   set -o pipefail
        git describe --long --tag | sed -r 's/([^-]*-g)/r\1/;s/-/./g' ||
        printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
    ) 2>/dev/null
}

build() {
    cd "$_pkgname"
    cargo build --features=rt-tokio --manifest-path=veilid-git/veilid-tools/Cargo.toml
    cargo build --features=rt-tokio --manifest-path=veilid-git/veilid-core/Cargo.toml
    cargo build --features=rt-tokio --manifest-path=veilid-git/veilid-server/Cargo.toml
    cargo build --features=rt-tokio --manifest-path=veilid-git/veilid-cli/Cargo.toml
}

package() {
    cd "$_pkgname"
    install -Dm644 veilid-git/target/debug/libveilid_tools.so "${pkgdir}/usr/lib/libveilid_tools.so"
    install -Dm644 veilid-git/target/debug/libveilid_core.so "${pkgdir}/usr/lib/libveilid_core.so"
    install -Dm744 veilid-git/target/debug/veilid-cli "${pkgdir}/usr/bin/veilid-cli"
    install -Dm744 veilid-git/target/debug/veilid-server "${pkgdir}/usr/bin/veilid-server"
}

