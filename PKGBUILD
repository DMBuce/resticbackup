# Maintainer: Buce <dmbuce@gmail.com>

pkgname=resticbackup
pkgver=0.49
pkgver() {
  cd "$srcdir/$pkgname"
  #if ! git describe --tags 2>/dev/null; then
  #  echo "0.r$(git rev-list --count HEAD).g$(git rev-parse --short HEAD)"
  #fi | sed 's/-/.r/; s/-/./g'
  ./bin/resticbackup --version
}
pkgrel=1
pkgdesc="Restic with hooks."
arch=(any)
url="https://github.com/DMBuce/resticbackup"
license=('GPL3')
groups=()
depends=(
  restic
)
makedepends=('git')
provides=()
conflicts=()
replaces=()
backup=(
	etc/resticbackup.d/config
	etc/resticbackup.d/exclude
	etc/resticbackup.d/password
  etc/resticbackup.d/hooks/check-integ.post.disabled
  etc/resticbackup.d/hooks/check-snaps.post.disabled
  etc/resticbackup.d/hooks/repo-mounted.pre.disabled
  etc/profile.d/restic.sh
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
