pkgname=veilid-server-git
pkgver=20230813
pkgrel=1
pkgdesc="Tools and the backend server for the privacy-focused application framework Veilid"
arch=('x86_64')
url="https://gitlab.com/veilid/veilid/"
license=('MPL2')
makedepends=('git' 'rust' 'capnproto' 'protobuf')
source=("systemd-sysusers.conf")
sha256sums=('21fd31902c990813d8f33258d0bb5ab4a002deeeedb88865982d69124b803031')

prepare() {
    cd "$_pkgname"
    if [ -d veilid-git ]; then rm -Rf veilid-git; fi
    git clone --recurse-submodules https://gitlab.com/veilid/veilid.git veilid-git
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
    cargo build --features=rt-tokio --manifest-path=veilid-git/Cargo.toml --release --bin veilid-server
    cargo build --features=rt-tokio --manifest-path=veilid-git/Cargo.toml --release --bin veilid-cli
}

package() {
    cd "$_pkgname"
    install -m 755 -d "${pkgdir}/usr/lib/sysusers.d"
    install -m 644 "${srcdir}/systemd-sysusers.conf" "${pkgdir}/usr/lib/sysusers.d/${pkgname}.conf"
    install -Dm744 veilid-git/target/release/veilid-cli "${pkgdir}/usr/bin/veilid-cli"
    install -Dm744 veilid-git/target/release/veilid-server "${pkgdir}/usr/bin/veilid-server"
    install -Dm744 veilid-git/package/linux/veilid-server.conf "${pkgdir}/etc/veilid-server/veilid-server.conf"
    install -Dm744 veilid-git/package/systemd/veilid-server.service "${pkgdir}/usr/lib/systemd/system/veilid-server.service"
    install -d --mode=750 "${pkgdir}/var/db/veilid-server/"
}

