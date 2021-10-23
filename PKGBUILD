# Maintainer: Buce <dmbuce@gmail.com>

pkgname=rhesootick
pkgver=0.r24.gf0e44ca
pkgver() {
  cd "$srcdir/$pkgname"
  if ! git describe --tags 2>/dev/null; then
    echo "0.r$(git rev-list --count HEAD).g$(git rev-parse --short HEAD)"
  fi | sed 's/-/.r/; s/-/./g'
}
pkgrel=1
pkgdesc="Restic with hooks."
arch=(any)
url="https://github.com/DMBuce/rhesootick"
license=('unknown')
groups=()
depends=(
)
makedepends=('git')
provides=()
conflicts=()
replaces=()
backup=(
	etc/rhesootick.d/config
	etc/rhesootick.d/exclude
	etc/rhesootick.d/password
  etc/rhesootick.d/hooks/check-integ.post.disabled
  etc/rhesootick.d/hooks/check-snaps.post.disabled
  etc/rhesootick.d/hooks/repo-mounted.pre.disabled
)
options=()
install=
source=("$pkgname::git+https://github.com/DMBuce/${pkgname%-git}.git")
#source=("$pkgname::git+ssh://git@mantrid/~/${pkgname%-git}.git")
md5sums=('SKIP')

package() {
  cd "$srcdir/$pkgname"
  make prefix=/usr sysconfdir=/etc localstatedir=/var DESTDIR="$pkgdir" install
}

# vim:set ts=2 sw=2 et:
