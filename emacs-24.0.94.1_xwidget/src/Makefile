# src/Makefile for GNU Emacs.

# Copyright (C) 1985, 1987-1988, 1993-1995, 1999-2012
#   Free Software Foundation, Inc.

# This file is part of GNU Emacs.

# GNU Emacs is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# GNU Emacs is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.


# Note that this file is edited by msdos/sed1v2.inp for MSDOS.  That
# script may need modifying in sync with changes made here.  Try to
# avoid shell-ism because the DOS build has to use the DOS shell.

SHELL = /bin/sh

# Here are the things that we expect ../configure to edit.
# We use $(srcdir) explicitly in dependencies so as not to depend on VPATH.
srcdir = /home/andy/emacs-xwidget/src
abs_builddir = /home/andy/emacs-xwidget/src
VPATH = $(srcdir)
CC = gcc -std=gnu99
CFLAGS = -pthread -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/gtk-3.0 -I/usr/include/libsoup-2.4 -I/usr/include/pango-1.0 -I/usr/include/gio-unix-2.0/ -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/freetype2 -I/usr/include/pixman-1 -I/usr/include/libpng12 -I/usr/include/libxml2 -I/usr/include/webkitgtk-3.0   -DHAVE_WEBKIT_OSR -g
CPPFLAGS =    -DXASSERTS=1
LDFLAGS = -lwebkitgtk-3.0 -lgtk-3 -lsoup-2.4 -ljavascriptcoregtk-3.0 -lgdk-3 -latk-1.0 -lpangocairo-1.0 -lgdk_pixbuf-2.0 -lcairo-gobject -lpango-1.0 -lcairo -lgio-2.0 -lgobject-2.0 -lglib-2.0   -Wl,-znocombreloc 
LD_FIRSTFLAG=-nostdlib
EXEEXT = 
version = 24.0.94
# Substitute an assignment for the MAKE variable, because
# BSD doesn't have it as a default.

# Don't use LIBS.  configure puts stuff in it that either shouldn't be
# linked with Emacs or is duplicated by the other stuff below.
# LIBS = -lm -lxml2   -lSM -lICE -lXrender -lXft    -lgtk-3 -lgdk-3 -latk-1.0 -lgio-2.0 -lpangocairo-1.0 -lgdk_pixbuf-2.0 -lcairo-gobject -lpango-1.0 -lcairo -lgobject-2.0 -lglib-2.0   -lrsvg-2 -lm -lgio-2.0 -lgdk_pixbuf-2.0 -lcairo -lgobject-2.0 -lglib-2.0   -lX11 -lpthread   -ldbus-1 -lpthread -lrt  
LIBOBJS = 

lispsource = $(srcdir)/../lisp
lib = ../lib
libsrc = ../lib-src
etc = ../etc
oldXMenudir = ../oldXMenu
lwlibdir = ../lwlib
lispdir = ../lisp

# Configuration files for .o files to depend on.
M_FILE = $(srcdir)/m/amdx86-64.h
S_FILE = $(srcdir)/s/gnu-linux.h
config_h = config.h $(M_FILE) $(S_FILE)

bootstrap_exe = $(abs_builddir)/bootstrap-emacs$(EXEEXT)

## ns-app if HAVE_NS, else empty.
OTHER_FILES = 

## Flags to pass for profiling builds
PROFILING_CFLAGS = 

## Flags to pass to the compiler to enable build warnings
C_WARNINGS_SWITCH = -Wimplicit-function-declaration -Wold-style-definition -Wdeclaration-after-statement 

## Machine-specific CFLAGS.
C_SWITCH_MACHINE=
## System-specific CFLAGS.
C_SWITCH_SYSTEM=

## Currently only set if NS_IMPL_GNUSTEP.
## C_SWITCH_X_SITE may override this.
C_SWITCH_X_SYSTEM=

## Define C_SWITCH_X_SITE to contain any special flags your compiler
## may need to deal with X Windows.  For instance, if you've defined
## HAVE_X_WINDOWS and your X include files aren't in a place that your
## compiler can find on its own, you might want to add "-I/..." or
## something similar.  This is normally set by configure.
## This is used before C_SWITCH_X_SYSTEM and may override it.
C_SWITCH_X_SITE= -pthread -I/usr/include/gtk-3.0 -I/usr/include/pango-1.0 -I/usr/include/gio-unix-2.0/ -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/freetype2 -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/pixman-1 -I/usr/include/libpng12   -I/usr/include/freetype2  

## Define LD_SWITCH_X_SITE to contain any special flags your loader
## may need to deal with X Windows.  For instance, if your X libraries
## aren't in a place that your loader can find on its own, you might
## want to add "-L/..." or something similar.  Only used if
## HAVE_X_WINDOWS.
## FIXME? configure sets a value for this, but it has never been
## substituted in this or any other Makefile. Cf C_SWITCH_X_SITE.
LD_SWITCH_X_SITE=

## Next two must come before LD_SWITCH_SYSTEM.
## If needed, a -R option that says where to find X windows at run time.
LD_SWITCH_X_SITE_AUX=
## As above, but using -rpath instead.
LD_SWITCH_X_SITE_AUX_RPATH=

## System-specific LDFLAGS.
LD_SWITCH_SYSTEM=

## This holds any special options for linking temacs only (ie, not
## used by configure).  Not used elsewhere because it sometimes
## contains options that have to do with using Emacs's crt0,
## which are only good with temacs.
LD_SWITCH_SYSTEM_TEMACS=$(LD_SWITCH_X_SITE_AUX)

## Flags to pass to ld only for temacs.
TEMACS_LDFLAGS = $(LD_SWITCH_SYSTEM) $(LD_SWITCH_SYSTEM_TEMACS)

## $LDFLAGS or empty if NS_IMPL_GNUSTEP (for some reason).
TEMACS_LDFLAGS2 = ${LDFLAGS}

## Some systems define this to request special libraries.
LIBS_SYSTEM=

## Where to find libgcc.a, if using gcc and necessary.
LIB_GCC=

CRT_DIR=/usr/lib/gcc/x86_64-linux-gnu/4.6/../../../x86_64-linux-gnu
## May use $CRT_DIR.
LIB_STANDARD=-lgcc -lc -lgcc $(CRT_DIR)/crtn.o
START_FILES = pre-crt0.o $(CRT_DIR)/crt1.o $(CRT_DIR)/crti.o

## -lm, or empty.
LIB_MATH=-lm

## -lpthreads, or empty.
LIB_PTHREAD=-lpthread

LIBTIFF=-ltiff
LIBJPEG=-ljpeg
LIBPNG=-lpng -lz -lm
LIBGIF=-lgif
LIBXPM=-lXpm
XFT_LIBS=-lXrender -lXft  
LIBX_EXTRA=$(LIBTIFF) $(LIBJPEG) $(LIBPNG) $(LIBGIF) $(LIBXPM) -lX11 $(XFT_LIBS)

FONTCONFIG_CFLAGS =  
FONTCONFIG_LIBS = -lfontconfig  
FREETYPE_CFLAGS = -I/usr/include/freetype2  
FREETYPE_LIBS = -lfreetype  
LIBOTF_CFLAGS = -I/usr/include/freetype2  
LIBOTF_LIBS = -lz -lotf -lfreetype  
M17N_FLT_CFLAGS =  
M17N_FLT_LIBS = -lm17n-flt -lm17n-core  

DBUS_CFLAGS = -I/usr/include/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include  
DBUS_LIBS = -ldbus-1 -lpthread -lrt  
## dbusbind.o if HAVE_DBUS, else empty.
DBUS_OBJ = dbusbind.o

SETTINGS_CFLAGS = -pthread -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include   -pthread -I/usr/include/gconf/2 -I/usr/include/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include  
SETTINGS_LIBS = -lgio-2.0 -lgobject-2.0 -lglib-2.0   -lgconf-2 -lglib-2.0  

## gtkutil.o if USE_GTK, else empty.
GTK_OBJ=gtkutil.o emacsgtkfixed.o

## -ltermcap, or -lncurses, or -lcurses, or "".
LIBS_TERMCAP=-lncurses
## terminfo.o if TERMINFO, else tparam.o.
TERMCAP_OBJ=terminfo.o

LIBXMU=-lXmu

LIBXSM=-lSM -lICE

LIBXTR6=

## $(LIBXMU) -lXt $(LIBXTR6) -lXext if USE_X_TOOLKIT, else $(LIBXSM).
## Only used if HAVE_X_WINDOWS.
LIBXT_OTHER=$(LIBXSM)

## If !HAVE_X11 || USE_GTK, empty.
## Else if USE_X_TOOLKIT really-lwlib, else really-oldxmenu.
OLDXMENU_TARGET=

## If !HAVE_X11 || USE_GTK, empty.
## Else if USE_X_TOOLKIT, $(lwlibdir)/liblw.a.
## Else $(oldXMenudir)/libXMenu11.a.
## (Actually, rather than being empty, it is set to "nothing".
## It is never actually used for anything in this case.
## This is done because there is a rule with target $(OLDXMENU) below,
## and I think it might be a syntax error with some makes to have
## an empty target, even if the associated rule is never run.
## http://lists.gnu.org/archive/html/help-make/2010-05/msg00058.html
## The alternative would be to put that rule in a makefile fragment.)
OLDXMENU=nothing

## If HAVE_X11 && !USE_GTK, $(OLDXMENU) ../src/$(OLDXMENU); else empty.
## We use stamp-xmenu with these two deps to both ensure that lwlib
## gets remade based on its dependencies in its own makefile,
## and remake temacs if lwlib gets changed by this.
OLDXMENU_DEPS=

## If !HAVE_X11 && HAVE_X_WINDOWS, -lXMenu (this case no longer possible).
## Else if !HAVE_X11 || USE_GTK, empty.
## Else $(OLDXMENU).
LIBXMENU=

## xmenu.o if HAVE_X_WINDOWS, else empty.
XMENU_OBJ=xmenu.o
## xterm.o xfns.o xselect.o xrdb.o fontset.o xsmfns.o fringe.o image.o
## xsettings.o xgselect.o if HAVE_X_WINDOWS, else empty.
XOBJ=xterm.o xfns.o xselect.o xrdb.o fontset.o xsmfns.o fringe.o image.o xsettings.o xgselect.o

TOOLKIT_LIBW=-lgtk-3 -lgdk-3 -latk-1.0 -lgio-2.0 -lpangocairo-1.0 -lgdk_pixbuf-2.0 -lcairo-gobject -lpango-1.0 -lcairo -lgobject-2.0 -lglib-2.0   -lXcomposite

## Only used if HAVE_X11, in LIBX_OTHER.
LIBXT=$(TOOLKIT_LIBW) $(LIBXT_OTHER)

## If HAVE_X11, $(LIBXT) $(LIBX_EXTRA), else empty.
LIBX_OTHER=$(LIBXT) $(LIBX_EXTRA)

## LIBXMENU is nil if !HAVE_X_WINDOWS.
## LD_SWITCH_X_SITE should not be used if not using X, but nothing
## sets it at present, and if something ever does, it should be
## configure, which should set it to nil in non-X builds.
LIBX_BASE=$(LIBXMENU) $(LD_SWITCH_X_SITE)

LIBSOUND= 
CFLAGS_SOUND= 

RSVG_LIBS= -lrsvg-2 -lm -lgio-2.0 -lgdk_pixbuf-2.0 -lcairo -lgobject-2.0 -lglib-2.0  
RSVG_CFLAGS= -pthread -I/usr/include/librsvg-2.0 -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/cairo -I/usr/include/libpng12 -I/usr/include/pixman-1 -I/usr/include/freetype2  

CLUTTER_LIBS= 
CLUTTER_CFLAGS= 

WEBKIT_LIBS= -lwebkitgtk-3.0 -lgtk-3 -lsoup-2.4 -ljavascriptcoregtk-3.0 -lgdk-3 -latk-1.0 -lpangocairo-1.0 -lgdk_pixbuf-2.0 -lcairo-gobject -lpango-1.0 -lcairo -lgio-2.0 -lgobject-2.0 -lglib-2.0  
WEBKIT_CFLAGS= -pthread -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/gtk-3.0 -I/usr/include/libsoup-2.4 -I/usr/include/pango-1.0 -I/usr/include/gio-unix-2.0/ -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/freetype2 -I/usr/include/pixman-1 -I/usr/include/libpng12 -I/usr/include/libxml2 -I/usr/include/webkitgtk-3.0  

IMAGEMAGICK_LIBS= 
IMAGEMAGICK_CFLAGS= 

LIBXML2_LIBS = -lxml2  
LIBXML2_CFLAGS = -I/usr/include/libxml2  

## widget.o if USE_X_TOOLKIT, otherwise empty.
WIDGET_OBJ=

## sheap.o if CYGWIN, otherwise empty.
CYGWIN_OBJ=

## dosfns.o msdos.o w16select.o if MSDOS.
MSDOS_OBJ =
## w16select.o termcap.o if MSDOS && HAVE_X_WINDOWS.
MSDOS_X_OBJ =

ns_appdir=
ns_appbindir=
ns_appsrc=
## fontset.o fringe.o image.o if HAVE_NS, else empty.
NS_OBJ=
## nsterm.o nsfns.o nsmenu.o nsselect.o nsimage.o nsfont.o if HAVE_NS.
NS_OBJC_OBJ=
## Only set if NS_IMPL_GNUSTEP.
GNU_OBJC_CFLAGS=

## Empty if !HAVE_X_WINDOWS
## xfont.o ftfont.o xftfont.o ftxfont.o if HAVE_XFT
## xfont.o ftfont.o ftxfont.o if HAVE_FREETYPE
## else xfont.o
FONT_OBJ=xfont.o ftfont.o xftfont.o ftxfont.o

LIBGPM = -lgpm

## -lresolv, or empty.
LIBRESOLV = 

LIBSELINUX_LIBS = 

LIBGNUTLS_LIBS = 
LIBGNUTLS_CFLAGS = 

LIB_PTHREAD_SIGMASK = 

INTERVALS_H = dispextern.h intervals.h composite.h

GETLOADAVG_LIBS = 

RUN_TEMACS = `/bin/pwd`/temacs

UNEXEC_OBJ = unexelf.o

CANNOT_DUMP=no

DEPDIR=deps
## -MMD -MF $(DEPDIR)/$*.d if AUTO_DEPEND; else empty.
DEPFLAGS=-MMD -MF ${DEPDIR}/$*.d -MP
## test -d $(DEPDIR) || mkdir $(DEPDIR) (if AUTO_DEPEND); else ':'.
MKDEPDIR=test -d ${DEPDIR} || mkdir ${DEPDIR} || test -d ${DEPDIR}

## DO NOT use -R.  There is a special hack described in lastfile.c
## which is used instead.  Some initialized data areas are modified
## at initial startup, then labeled as part of the text area when
## Emacs is dumped for the first time, and never changed again.
##
## -Demacs is needed to make some files produce the correct version
## for use in Emacs.
##
## -DHAVE_CONFIG_H is needed for some other files to take advantage of
## the information in `config.h'.
##
## C_SWITCH_X_SITE must come before C_SWITCH_X_SYSTEM
## since it may have -I options that should override those.
##
## FIXME? MYCPPFLAGS only referenced in etc/DEBUG.
ALL_CFLAGS=-Demacs -DHAVE_CONFIG_H $(MYCPPFLAGS) -I. -I$(srcdir) \
  -I$(lib) -I$(srcdir)/../lib \
  $(C_SWITCH_MACHINE) $(C_SWITCH_SYSTEM) $(C_SWITCH_X_SITE) \
  $(C_SWITCH_X_SYSTEM) $(CFLAGS_SOUND) $(RSVG_CFLAGS) $(IMAGEMAGICK_CFLAGS) \
  $(LIBXML2_CFLAGS) $(DBUS_CFLAGS) \
  $(WEBKIT_CFLAGS) $(CLUTTER_CFLAGS) \
  $(SETTINGS_CFLAGS) $(FREETYPE_CFLAGS) $(FONTCONFIG_CFLAGS) \
  $(LIBOTF_CFLAGS) $(M17N_FLT_CFLAGS) $(DEPFLAGS) $(PROFILING_CFLAGS) \
  $(LIBGNUTLS_CFLAGS) \
  $(C_WARNINGS_SWITCH) $(CFLAGS)
ALL_OBJC_CFLAGS=$(ALL_CFLAGS) $(GNU_OBJC_CFLAGS)

.SUFFIXES: .m
.c.o:
	@$(MKDEPDIR)
	$(CC) -c $(CPPFLAGS) $(ALL_CFLAGS) $<
.m.o:
	@$(MKDEPDIR)
	$(CC) -c $(CPPFLAGS) $(ALL_OBJC_CFLAGS) $<


## lastfile must follow all files whose initialized data areas should
## be dumped as pure by dump-emacs.
base_obj = dispnew.o frame.o scroll.o xdisp.o menu.o $(XMENU_OBJ) window.o \
	charset.o coding.o category.o ccl.o character.o chartab.o bidi.o \
	cm.o term.o terminal.o xfaces.o $(XOBJ) $(GTK_OBJ) $(DBUS_OBJ) \
	emacs.o keyboard.o macros.o keymap.o sysdep.o \
	buffer.o filelock.o insdel.o marker.o \
	minibuf.o fileio.o dired.o \
	cmds.o casetab.o casefiddle.o indent.o search.o regex.o undo.o \
	alloc.o data.o doc.o editfns.o callint.o \
	eval.o floatfns.o fns.o font.o print.o lread.o \
	syntax.o $(UNEXEC_OBJ) bytecode.o \
	process.o gnutls.o callproc.o \
	region-cache.o sound.o atimer.o \
	doprnt.o intervals.o textprop.o composite.o xml.o \
	xwidget.o \
	$(MSDOS_OBJ) $(MSDOS_X_OBJ) $(NS_OBJ) $(CYGWIN_OBJ) $(FONT_OBJ)
obj = $(base_obj) $(NS_OBJC_OBJ)

xwidget.o: xwidget.c xwidget.h
## Object files used on some machine or other.
## These go in the DOC file on all machines in case they are needed.
## Some of them have no DOC entries, but it does no harm to have them
## in the list, in case they ever add any such entries.
SOME_MACHINE_OBJECTS = dosfns.o msdos.o \
  xterm.o xfns.o xmenu.o xselect.o xrdb.o xsmfns.o fringe.o image.o \
  fontset.o dbusbind.o \
  nsterm.o nsfns.o nsmenu.o nsselect.o nsimage.o nsfont.o \
  w32.o w32console.o w32fns.o w32heap.o w32inevt.o \
  w32menu.o w32proc.o w32reg.o w32select.o w32term.o w32xfns.o \
  w16select.o widget.o xfont.o ftfont.o xftfont.o ftxfont.o gtkutil.o \
  xsettings.o xgselect.o termcap.o

## gmalloc.o if !SYSTEM_MALLOC && !DOUG_LEA_MALLOC, else empty.
GMALLOC_OBJ=

## vm-limit.o if !SYSTEM_MALLOC, else empty.
VMLIMIT_OBJ=vm-limit.o

## ralloc.o if !SYSTEM_MALLOC && REL_ALLOC, else empty.
RALLOC_OBJ=

## Empty on Cygwin, lastfile.o elsewhere.
PRE_ALLOC_OBJ=lastfile.o
## lastfile.o on Cygwin, empty elsewhere.
POST_ALLOC_OBJ=

## List of object files that make-docfile should not be told about.
otherobj= $(TERMCAP_OBJ) $(PRE_ALLOC_OBJ) $(GMALLOC_OBJ) $(RALLOC_OBJ) \
  $(POST_ALLOC_OBJ) $(VMLIMIT_OBJ) $(WIDGET_OBJ) $(LIBOBJS)


## Configure inserts the file lisp.mk at this point, defining $lisp.
### lisp.mk --- src/Makefile fragment for GNU Emacs

## Copyright (C) 1985, 1987-1988, 1993-1995, 1999-2012
##   Free Software Foundation, Inc.

## This file is part of GNU Emacs.

## GNU Emacs is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.

## GNU Emacs is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.

## You should have received a copy of the GNU General Public License
## along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

### Commentary:

## This is the list of all Lisp files that might be loaded into the
## dumped Emacs.  Some of them are not loaded on all platforms, but
## the DOC file on every platform uses them (because the DOC file is
## supposed to be platform-independent).
## It is arranged like this because it is easier to generate it
## semi-mechanically from loadup.el this way.
## Eg something like:
##   sed -e 's/"[ )].*//' -n -e '/(load "/ s/.*load "//p' loadup.el | \
##   grep -vE 'site-|ldefs-boot'
## minus any duplicates.
## Note that you cannot just add a ".elc" extension to every file,
## since some of them are no-byte-compile (eg some language/ ones).

## Confusingly, term/internal is not in loadup, but is unconditionally
## loaded by pc-win, which is.

## Note that this list should not include lisp files which might not
## be present, like site-load.el and site-init.el; this makefile
## expects them all to be either present or buildable.

## Place loaddefs.el first, so it gets generated first, since it is on
## the critical path (relevant in parallel compilations).

### Code:

## NB: This list is parsed by sed in the main src/Makefile.
## Do not change the formatting.
lisp = \
	$(lispsource)/loaddefs.el \
	$(lispsource)/loadup.el \
	$(lispsource)/emacs-lisp/byte-run.elc \
	$(lispsource)/emacs-lisp/backquote.elc \
	$(lispsource)/subr.elc \
	$(lispsource)/version.el \
	$(lispsource)/widget.elc \
	$(lispsource)/custom.elc \
	$(lispsource)/emacs-lisp/map-ynp.elc \
	$(lispsource)/cus-start.elc \
	$(lispsource)/international/mule.elc \
	$(lispsource)/international/mule-conf.elc \
	$(lispsource)/env.elc \
	$(lispsource)/format.elc \
	$(lispsource)/bindings.elc \
	$(lispsource)/files.elc \
	$(lispsource)/cus-face.elc \
	$(lispsource)/faces.elc \
	$(lispsource)/button.elc \
	$(lispsource)/startup.elc \
	$(lispsource)/minibuffer.elc \
	$(lispsource)/abbrev.elc \
	$(lispsource)/simple.elc \
	$(lispsource)/help.elc \
	$(lispsource)/jka-cmpr-hook.elc \
	$(lispsource)/epa-hook.elc \
	$(lispsource)/international/mule-cmds.elc \
	$(lispsource)/case-table.elc \
	$(lispsource)/international/characters.elc \
	$(lispsource)/composite.elc \
	$(lispsource)/international/charprop.el \
	$(lispsource)/language/chinese.elc \
	$(lispsource)/language/cyrillic.elc \
	$(lispsource)/language/indian.elc \
	$(lispsource)/language/sinhala.el \
	$(lispsource)/language/english.el \
	$(lispsource)/language/ethiopic.elc \
	$(lispsource)/language/european.elc \
	$(lispsource)/language/czech.el \
	$(lispsource)/language/slovak.el \
	$(lispsource)/language/romanian.el \
	$(lispsource)/language/greek.el \
	$(lispsource)/language/hebrew.elc \
	$(lispsource)/language/japanese.el \
	$(lispsource)/language/korean.el \
	$(lispsource)/language/lao.el \
	$(lispsource)/language/tai-viet.el \
	$(lispsource)/language/thai.el \
	$(lispsource)/language/tibetan.elc \
	$(lispsource)/language/vietnamese.elc \
	$(lispsource)/language/misc-lang.el \
	$(lispsource)/language/utf-8-lang.el \
	$(lispsource)/language/georgian.el \
	$(lispsource)/language/khmer.el \
	$(lispsource)/language/burmese.el \
	$(lispsource)/language/cham.el \
	$(lispsource)/indent.elc \
	$(lispsource)/window.elc \
	$(lispsource)/frame.elc \
	$(lispsource)/term/tty-colors.elc \
	$(lispsource)/font-core.elc \
	$(lispsource)/facemenu.elc \
	$(lispsource)/emacs-lisp/syntax.elc \
	$(lispsource)/font-lock.elc \
	$(lispsource)/jit-lock.elc \
	$(lispsource)/mouse.elc \
	$(lispsource)/scroll-bar.elc \
	$(lispsource)/select.elc \
	$(lispsource)/emacs-lisp/timer.elc \
	$(lispsource)/isearch.elc \
	$(lispsource)/rfn-eshadow.elc \
	$(lispsource)/menu-bar.elc \
	$(lispsource)/paths.el \
	$(lispsource)/emacs-lisp/lisp.elc \
	$(lispsource)/textmodes/page.elc \
	$(lispsource)/register.elc \
	$(lispsource)/textmodes/paragraphs.elc \
	$(lispsource)/emacs-lisp/lisp-mode.elc \
	$(lispsource)/textmodes/text-mode.elc \
	$(lispsource)/textmodes/fill.elc \
	$(lispsource)/replace.elc \
	$(lispsource)/buff-menu.elc \
	$(lispsource)/fringe.elc \
	$(lispsource)/image.elc \
	$(lispsource)/international/fontset.elc \
	$(lispsource)/dnd.elc \
	$(lispsource)/tool-bar.elc \
	$(lispsource)/dynamic-setting.elc \
	$(lispsource)/x-dnd.elc \
	$(lispsource)/term/common-win.elc \
	$(lispsource)/term/x-win.elc \
	$(lispsource)/w32-vars.elc \
	$(lispsource)/term/w32-win.elc \
	$(lispsource)/ls-lisp.elc \
	$(lispsource)/disp-table.elc \
	$(lispsource)/dos-w32.elc \
	$(lispsource)/w32-fns.elc \
	$(lispsource)/dos-fns.elc \
	$(lispsource)/dos-vars.elc \
	$(lispsource)/term/pc-win.elc \
	$(lispsource)/term/internal.elc \
	$(lispsource)/term/ns-win.elc \
	$(lispsource)/mwheel.elc \
	$(lispsource)/emacs-lisp/float-sup.elc \
	$(lispsource)/vc/vc-hooks.elc \
	$(lispsource)/vc/ediff-hook.elc \
	$(lispsource)/tooltip.elc


### lisp.mk ends here


## Construct full set of libraries to be linked.
## Note that SunOS needs -lm to come before -lc; otherwise, you get
## duplicated symbols.  If the standard libraries were compiled
## with GCC, we might need LIB_GCC again after them.
LIBES = $(LIBS) $(LIBX_BASE) $(LIBX_OTHER) $(LIBSOUND) \
   $(RSVG_LIBS) $(IMAGEMAGICK_LIBS) $(DBUS_LIBS) \
   $(WEBKIT_LIBS) $(CLUTTER_LIBS) \
   $(LIBXML2_LIBS) $(LIBGPM) $(LIBRESOLV) $(LIBS_SYSTEM) \
   $(LIBS_TERMCAP) $(GETLOADAVG_LIBS) $(SETTINGS_LIBS) $(LIBSELINUX_LIBS) \
   $(FREETYPE_LIBS) $(FONTCONFIG_LIBS) $(LIBOTF_LIBS) $(M17N_FLT_LIBS) \
   $(LIBGNUTLS_LIBS) $(LIB_PTHREAD) $(LIB_PTHREAD_SIGMASK) \
   $(LIB_GCC) $(LIB_MATH) $(LIB_STANDARD) $(LIB_GCC)

all: emacs$(EXEEXT) $(OTHER_FILES)

## Does anyone ever pay attention to the load-path-shadows output here?
## The dumped Emacs is as functional and more efficient than
## bootstrap-emacs, so we replace the latter with the former.
## Strictly speaking, emacs does not depend directly on all of $lisp,
## since not all pieces are used on all platforms.  But DOC depends
## on all of $lisp, and emacs depends on DOC, so it is ok to use $lisp here.
emacs$(EXEEXT): temacs$(EXEEXT) $(etc)/DOC $(lisp)
	if test "$(CANNOT_DUMP)" = "yes"; then \
	  ln -f temacs$(EXEEXT) emacs$(EXEEXT); \
	  EMACSLOADPATH=$(lispsource) ./emacs -batch \
	    -f list-load-path-shadows || true; \
	else \
	  LC_ALL=C $(RUN_TEMACS) -batch -l loadup dump || exit 1; \
	  ln -f emacs$(EXEEXT) bootstrap-emacs$(EXEEXT); \
	  ./emacs -batch -f list-load-path-shadows || true; \
	fi

## We run make-docfile twice because the command line may get too long
## on some systems.  The sed command operating on lisp.mk also reduces
## the length of the command line.  Unfortunately, no-one has any idea
## exactly how long the maximum safe command line length is on all the
## various systems that Emacs supports.  Obviously, the length depends
## on what your value of $srcdir is.  If the length restriction goes
## away, lisp.mk can be merged back into this file.
##
## $(SOME_MACHINE_OBJECTS) comes before $(obj) because some files may
## or may not be included in $(obj), but they are always included in
## $(SOME_MACHINE_OBJECTS).  Since a file is processed when it is mentioned
## for the first time, this prevents any variation between configurations
## in the contents of the DOC file.
##
$(etc)/DOC: $(libsrc)/make-docfile$(EXEEXT) $(obj) $(lisp)
	-rm -f $(etc)/DOC
	$(libsrc)/make-docfile -d $(srcdir) $(SOME_MACHINE_OBJECTS) $(obj) > $(etc)/DOC
	$(libsrc)/make-docfile -a $(etc)/DOC -d $(lispsource) `sed -n -e 's| \\\\||' -e 's|^[ 	]*$$(lispsource)/||p' $(srcdir)/lisp.mk`

$(libsrc)/make-docfile$(EXEEXT):
	cd $(libsrc); $(MAKE) $(MFLAGS) make-docfile$(EXEEXT)

buildobj.h: Makefile
	echo "#define BUILDOBJ \"$(obj) $(otherobj) " "\"" > buildobj.h

globals.h: gl-stamp; @true

GLOBAL_SOURCES = $(base_obj:.o=.c) $(NS_OBJC_OBJ:.o=.m)

gl-stamp: $(libsrc)/make-docfile$(EXEEXT) $(GLOBAL_SOURCES)
	@rm -f gl-tmp
	$(libsrc)/make-docfile -d $(srcdir) -g $(SOME_MACHINE_OBJECTS) $(obj) > gl-tmp
	$(srcdir)/../build-aux/move-if-change gl-tmp globals.h
	echo timestamp > $@

$(obj) $(otherobj): globals.h

$(lib)/libgnu.a: $(config_h)
	cd $(lib) && $(MAKE) libgnu.a

temacs$(EXEEXT): $(START_FILES) stamp-oldxmenu $(obj) $(otherobj) $(lib)/libgnu.a
	$(CC) $(LD_FIRSTFLAG) $(ALL_CFLAGS) $(TEMACS_LDFLAGS) $(TEMACS_LDFLAGS2) \
	  -o temacs $(START_FILES) $(obj) $(otherobj) $(lib)/libgnu.a $(LIBES)

## The following oldxmenu-related rules are only (possibly) used if
## HAVE_X11 && !USE_GTK, but there is no harm in always defining them
## (provided we take a little care that OLDXMENU is never empty).
really-lwlib: globals.h
	cd $(lwlibdir); $(MAKE) $(MFLAGS) \
    CC='$(CC)' CFLAGS='$(CFLAGS)' MAKE='$(MAKE)'
	@true  # make -t should not create really-lwlib.
.PHONY: really-lwlib

really-oldXMenu:
	cd $(oldXMenudir); $(MAKE) $(MFLAGS) \
    CC='$(CC)' CFLAGS='$(CFLAGS)' MAKE='$(MAKE)'
	@true  # make -t should not create really-oldXMenu.
.PHONY: really-oldXMenu

## We do not really need this when OLDXMENU_DEPS is empty, but as
## things stand we need something to satisfy the temacs dependency.
stamp-oldxmenu: $(OLDXMENU_DEPS)
	touch stamp-oldxmenu

## Supply an ordering for parallel make.
../src/$(OLDXMENU): $(OLDXMENU)

$(OLDXMENU): $(OLDXMENU_TARGET)

../config.status:: epaths.in
	@echo "The file epaths.h needs to be set up from epaths.in."
	@echo "Please run the `configure' script again."
	exit 1

../config.status:: config.in
	@echo "The file config.h needs to be set up from config.in."
	@echo "Please run the `configure' script again."
	exit 1

doc.o: buildobj.h


## If HAVE_NS, some ns-specific rules (for OTHER_FILES) are inserted here.


mostlyclean:
	rm -f temacs$(EXEEXT) core *.core \#* *.o libXMenu11.a liblw.a
	rm -f ../etc/DOC
	rm -f bootstrap-emacs$(EXEEXT) emacs-$(version)$(EXEEXT)
	rm -f buildobj.h
	rm -f globals.h gl-stamp
clean: mostlyclean
	rm -f emacs-*.*.*$(EXEEXT) emacs$(EXEEXT)
	-rm -rf $(DEPDIR)
	test "X$(ns_appdir)" = "X" || rm -rf $(ns_appdir)

## bootstrap-clean is used to clean up just before a bootstrap.
## It should remove all files generated during a compilation/bootstrap,
## but not things like config.status or TAGS.
bootstrap-clean: clean
	rm -f epaths.h config.h config.stamp stamp-oldxmenu ../etc/DOC-*
	if test -f ./.gdbinit; then \
	  mv ./.gdbinit ./.gdbinit.save; \
	  if test -f "$(srcdir)/.gdbinit"; then rm -f ./.gdbinit.save; \
	  else mv ./.gdbinit.save ./.gdbinit; fi; \
	fi
## This is used in making a distribution.
## Do not use it on development directories!
distclean: bootstrap-clean
	rm -f Makefile
maintainer-clean: distclean
	@echo "This command is intended for maintainers to use;"
	@echo "it deletes files that may require special tools to rebuild."
	rm -f TAGS
versionclean:
	-rm -f emacs$(EXEEXT) emacs-*.*.*$(EXEEXT) ../etc/DOC*
extraclean: distclean
	-rm -f *~ \#* m/?*~ s/?*~

## Arrange to make a tags table TAGS-LISP for ../lisp,
## plus TAGS for the C files, which includes ../lisp/TAGS by reference.

ctagsfiles1 = [xyzXYZ]*.[hcm]
ctagsfiles2 = [a-wA-W]*.[hcm]

TAGS: $(srcdir)/$(ctagsfiles1) $(srcdir)/$(ctagsfiles2) $(M_FILE) $(S_FILE)
	../lib-src/etags --include=TAGS-LISP --include=$(lwlibdir)/TAGS \
	  --regex='/[ 	]*DEFVAR_[A-Z_ 	(]+"\([^"]+\)"/' \
	  $(srcdir)/$(ctagsfiles1) $(srcdir)/$(ctagsfiles2) $(M_FILE) $(S_FILE)
frc:
TAGS-LISP: frc
	$(MAKE) -f $(lispdir)/Makefile TAGS-LISP ETAGS=../lib-src/etags

$(lwlibdir)/TAGS:
	(cd $(lwlibdir); $(MAKE) -f $(lwlibdir)/Makefile tags ETAGS=../lib-src/etags)

tags: TAGS TAGS-LISP $(lwlibdir)/TAGS
.PHONY: tags


### Bootstrapping.

## Bootstrapping right is difficult because of the circular dependencies.
## Furthermore, we have to deal with the fact that many compilation targets
## such as loaddefs.el or *.elc can typically be produced by any old
## Emacs executable, so we would like to avoid rebuilding them whenever
## we build a new Emacs executable.
## To solve the circularity, we use 2 different Emacs executables,
## "emacs" is the main target and "bootstrap-emacs" is the one used
## to build the *.elc and loaddefs.el files.
## To solve the freshness issue, we used to use a third file "witness-emacs"
## which was used to witness the fact that there is a bootstrap-emacs
## executable, and then have dependencies on witness-emacs rather than
## bootstrap-emacs, but that lead to problems in parallel builds (because
## witness-emacs needed to be free from dependencies (to avoid rebuilding
## it), so it was compiled in parallel, leading typically to having 2
## processes dumping bootstrap-emacs at the same time).
## So instead, we replace the witness-emacs dependencies by conditional
## bootstrap-dependencies (via $(BOOTSTRAPEMACS)).  Of course, since we do
## not want to rely on GNU Make features, we have to rely on an external
## script to do the conditional part of the dependency
## (i.e. see the $(SUBDIR) rule ../Makefile.in).

.SUFFIXES: .elc .el

## These suffix rules do not allow additional dependencies, sadly, so
## instead of adding a $(BOOTSTRAPEMACS) dependency here, we add it
## separately below.
## With GNU Make, we would just say "%.el : %.elc $(BOOTSTRAPEMACS)"
.el.elc:
	@cd ../lisp; $(MAKE) $(MFLAGS) compile-onefile \
	                     THEFILE=$< EMACS=$(bootstrap_exe)

## Since the .el.elc rule cannot specify an extra dependency, we do it here.
$(lisp): $(BOOTSTRAPEMACS)

## VCSWITNESS points to the file that holds info about the current checkout.
## We use it as a heuristic to decide when to rebuild loaddefs.el.
$(lispsource)/loaddefs.el: $(BOOTSTRAPEMACS) $(VCSWITNESS)
	cd ../lisp; $(MAKE) $(MFLAGS) autoloads EMACS=$(bootstrap_exe)

## Dump an Emacs executable named bootstrap-emacs containing the
## files from loadup.el in source form.
bootstrap-emacs$(EXEEXT): temacs$(EXEEXT)
	cd ../lisp; $(MAKE) $(MFLAGS) update-subdirs
	if test "$(CANNOT_DUMP)" = "yes"; then \
	  ln -f temacs$(EXEEXT) bootstrap-emacs$(EXEEXT); \
	else \
	  $(RUN_TEMACS) --batch --load loadup bootstrap || exit 1; \
	  mv -f emacs$(EXEEXT) bootstrap-emacs$(EXEEXT); \
	fi
	@: Compile some files earlier to speed up further compilation.
	cd ../lisp; $(MAKE) $(MFLAGS) compile-first EMACS=$(bootstrap_exe)

## Insert either autodeps.mk (if AUTO_DEPEND), else deps.mk.
### autodeps.mk --- src/Makefile fragment for GNU Emacs

## This is inserted in src/Makefile if AUTO_DEPEND=yes.

ALLOBJS=$(START_FILES) ${obj} ${otherobj}
-include $(ALLOBJS:%.o=${DEPDIR}/%.d)


### Makefile.in ends here
