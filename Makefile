SHELL = /bin/sh

# root for installation
prefix      = /usr/local
exec_prefix = ${prefix}

# executables
bindir     = ${exec_prefix}/bin
sbindir    = ${exec_prefix}/sbin
libexecdir = ${exec_prefix}/libexec

# data
datarootdir    = ${prefix}/share
datadir        = ${datarootdir}
sysconfdir     = ${prefix}/etc
sharedstatedir = ${prefix}/com
localstatedir  = ${prefix}/var

# misc
includedir    = ${prefix}/include
oldincludedir = /usr/include
docdir        = ${datarootdir}/doc/${PACKAGE_TARNAME}
infodir       = ${datarootdir}/info
libdir        = ${exec_prefix}/lib
localedir     = ${datarootdir}/locale
mandir        = ${datarootdir}/man
man1dir       = $(mandir)/man1
man2dir       = $(mandir)/man2
man3dir       = $(mandir)/man3
man4dir       = $(mandir)/man4
man5dir       = $(mandir)/man5
man6dir       = $(mandir)/man6
man7dir       = $(mandir)/man7
man8dir       = $(mandir)/man8
man9dir       = $(mandir)/man9
manext        = .1
srcdir        = .

INSTALL         = /usr/bin/install -c
INSTALL_PROGRAM = ${INSTALL}
INSTALL_DATA    = ${INSTALL} -m 644

LN_S        = ln -s
SED_INPLACE = sed -i

PACKAGE   = rheostoick
PROG      = rheostoick
#VERSION   = 0.0.0
BUGREPORT = https://github.com/DMBuce/rheostoick/issues
URL       = https://github.com/DMBuce/rheostoick

BINFILES         = $(wildcard bin/*)
ETCFILES         = $(shell find etc/ -type f)
BINFILES_INSTALL = $(BINFILES:bin/%=$(DESTDIR)$(bindir)/%)
ETCFILES_INSTALL = $(ETCFILES:etc/%=$(DESTDIR)$(sysconfdir)/%)
INSTALL_FILES    = $(BINFILES_INSTALL) $(ETCFILES_INSTALL)
INSTALL_DIRS     = $(sort $(dir $(INSTALL_FILES)))

.PHONY: all
all:

.PHONY: install
install: all installdirs $(INSTALL_FILES)
	$(SED_INPLACE) 's,/etc,$(sysconfdir),g' $(DESTDIR)$(bindir)/$(PROG)
	$(SED_INPLACE) 's,/etc,$(sysconfdir),g' $(DESTDIR)$(sysconfdir)/config
	$(SED_INPLACE) 's,/etc,$(sysconfdir),g' $(DESTDIR)$(sysconfdir)/exclude

.PHONY: installdirs
installdirs: $(INSTALL_DIRS)

$(INSTALL_DIRS):
	$(INSTALL) -d $@

$(DESTDIR)$(bindir)/%: bin/%
	$(INSTALL_PROGRAM) $< $@

$(DESTDIR)$(sysconfdir)/%: etc/%
	$(INSTALL_DATA) $< $@

$(DESTDIR)$(sysconfdir)/rheostoick.d/hooks/%: etc/rheostoick.d/hooks/%
	$(INSTALL_PROGRAM) $< $@

$(DESTDIR)$(sysconfdir)/rheostoick.d/password: etc/rheostoick.d/password
	$(INSTALL) -m 600 $< $@

# vim: set ft=make:
