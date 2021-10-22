# Maintainer: Buce <dmbuce@gmail.com>

pkgname=rheostoick
pkgver=0.r23.g25e942f
pkgver() {
  cd "$srcdir/$pkgname"
  if ! git describe --tags 2>/dev/null; then
    echo "0.r$(git rev-list --count HEAD).g$(git rev-parse --short HEAD)"
  fi | sed 's/-/.r/; s/-/./g'
}
pkgrel=1
pkgdesc="Restic with hooks."
arch=(any)
url="https://github.com/DMBuce/rheostoick"
license=('unknown')
groups=()
depends=(
)
makedepends=('git')
provides=()
conflicts=()
replaces=()
backup=(
	etc/rheostoick.d/config
	etc/rheostoick.d/exclude
	etc/rheostoick.d/password
  etc/rheostoick.d/hooks/check-integ.post.disabled
  etc/rheostoick.d/hooks/check-snaps.post.disabled
  etc/rheostoick.d/hooks/repo-mounted.pre.disabled
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
