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

PACKAGE   = resticbackup
PROG      = resticbackup
#VERSION   = 0.0.0
BUGREPORT = https://github.com/DMBuce/resticbackup/issues
URL       = https://github.com/DMBuce/resticbackup

BINFILES         = $(wildcard bin/*)
ETCFILES         = $(shell find etc/ -type f)
BINFILES_INSTALL = $(BINFILES:bin/%=$(DESTDIR)$(bindir)/%)
ETCFILES_INSTALL = $(ETCFILES:etc/%=$(DESTDIR)$(sysconfdir)/%)
MAN1FILES        = doc/resticbackup.1
MANFILES         = $(MAN1FILES)
HTMLFILES        = $(MANFILES:%=%.html)
TEXTFILES        = $(BINFILES:bin/%=doc/%.1.txt)
DOCFILES         = $(MANFILES) $(HTMLFILES) $(TEXTFILES)
INSTALL_FILES    = $(BINFILES_INSTALL) $(ETCFILES_INSTALL)
INSTALL_DIRS     = $(sort $(dir $(INSTALL_FILES)))

.PHONY: all
all: doc

.PHONY: install
install: all installdirs $(INSTALL_FILES)
	$(SED_INPLACE) 's,/etc,$(sysconfdir),g' $(DESTDIR)$(bindir)/$(PROG)
	$(SED_INPLACE) 's,/etc,$(sysconfdir),g' $(DESTDIR)$(sysconfdir)/$(PROG).d/config
	$(SED_INPLACE) 's,/etc,$(sysconfdir),g' $(DESTDIR)$(sysconfdir)/profile.d/restic.sh

.PHONY: uninstall
uninstall:
	rm -f $(INSTALL_FILES)

.PHONY: installdirs
installdirs: $(INSTALL_DIRS)

.PHONY: doc
doc: $(DOCFILES)

doc/%.1: doc/%.1.pod
	pod2man $< > $@

doc/%.txt: doc/%.pod
	pod2text $< > $@

doc/%.html: doc/%.pod
	pod2html $< > $@

$(INSTALL_DIRS):
	$(INSTALL) -d $@

$(DESTDIR)$(bindir)/%: bin/%
	$(INSTALL_PROGRAM) $< $@

$(DESTDIR)$(sysconfdir)/%: etc/%
	$(INSTALL_DATA) $< $@

$(DESTDIR)$(sysconfdir)/resticbackup.d/hooks/%: etc/resticbackup.d/hooks/%
	$(INSTALL_PROGRAM) $< $@

$(DESTDIR)$(sysconfdir)/resticbackup.d/password: etc/resticbackup.d/password
	$(INSTALL) -m 600 $< $@

$(DESTDIR)$(man1dir)/%: doc/%
	$(INSTALL_DATA) $< $@

# vim: set ft=make:
