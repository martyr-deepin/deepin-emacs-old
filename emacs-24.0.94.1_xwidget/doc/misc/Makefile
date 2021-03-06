#### Makefile for documentation other than the Emacs manual.

# Copyright (C) 1994, 1996-2012  Free Software Foundation, Inc.

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

SHELL = /bin/sh

# Where to find the source code.  $(srcdir) will be the man-aux
# subdirectory of the source tree.  This is
# set by the configure script's `--srcdir' option.
srcdir=/home/andy/emacs-xwidget/doc/misc

# Tell make where to find source files; this is needed for the makefiles.
# Note the other doc Makefiles do not use VPATH anymore, instead
# they set infodir to an absolute path.  Not doing that here in
# case INFO_TARGETS gets too long for some feeble shells.
# (cf src/Makefile.in's passing of $lisp to make-docfile)
VPATH=/home/andy/emacs-xwidget/doc/misc

## Where the output files go.
## Note that the setfilename command in the .texi files assumes this.
infodir=../../info
## Directory with emacsver.texi.
## Currently only used by efaq and calc.
emacsdir = $(srcdir)/../emacs

# The makeinfo program is part of the Texinfo distribution.
# Use --force so that it generates output even if there are errors.
MAKEINFO = /usr/bin/makeinfo
MAKEINFO_OPTS = --force -I$(emacsdir)

# Also add new entries to INFO_FILES in the top-level Makefile.in.
INFO_TARGETS = \
	$(infodir)/ada-mode \
	$(infodir)/auth \
	$(infodir)/autotype \
	$(infodir)/calc \
	$(infodir)/ccmode \
	$(infodir)/cl \
	$(infodir)/dbus \
	$(infodir)/dired-x \
	$(infodir)/ebrowse \
	$(infodir)/ede \
	$(infodir)/ediff \
	$(infodir)/edt \
	$(infodir)/eieio \
	$(infodir)/emacs-mime \
	$(infodir)/epa \
	$(infodir)/erc \
	$(infodir)/ert \
	$(infodir)/eshell \
	$(infodir)/eudc \
	$(infodir)/efaq \
	$(infodir)/flymake \
	$(infodir)/forms \
	$(infodir)/gnus \
	$(infodir)/idlwave \
	$(infodir)/info \
	$(infodir)/mairix-el \
	$(infodir)/message \
	$(infodir)/mh-e \
	$(infodir)/newsticker \
	$(infodir)/nxml-mode \
	$(infodir)/org \
	$(infodir)/pcl-cvs \
	$(infodir)/pgg \
	$(infodir)/rcirc \
	$(infodir)/remember \
	$(infodir)/reftex \
	$(infodir)/sasl \
	$(infodir)/sc \
	$(infodir)/semantic \
	$(infodir)/ses \
	$(infodir)/sieve \
	$(infodir)/smtpmail \
	$(infodir)/speedbar \
	$(infodir)/tramp \
	$(infodir)/url \
	$(infodir)/vip \
	$(infodir)/viper \
	$(infodir)/widget \
	$(infodir)/woman

DVI_TARGETS = \
	ada-mode.dvi \
	auth.dvi \
	autotype.dvi \
	calc.dvi \
	cc-mode.dvi \
	cl.dvi \
	dbus.dvi \
	dired-x.dvi \
	ebrowse.dvi \
	ede.dvi \
	ediff.dvi \
	edt.dvi \
	eieio.dvi \
	emacs-mime.dvi \
	epa.dvi \
	erc.dvi \
	ert.dvi \
	eshell.dvi \
	eudc.dvi \
	faq.dvi \
	flymake.dvi \
	forms.dvi \
	gnus.dvi \
	idlwave.dvi \
	info.dvi \
	mairix-el.dvi \
	message.dvi \
	mh-e.dvi \
	newsticker.dvi \
	nxml-mode.dvi \
	org.dvi \
	pcl-cvs.dvi \
	pgg.dvi \
	rcirc.dvi \
	reftex.dvi \
	remember.dvi \
	sasl.dvi \
	sc.dvi \
	semantic.dvi \
	ses.dvi \
	sieve.dvi \
	smtpmail.dvi \
	speedbar.dvi \
	tramp.dvi \
	url.dvi \
	vip.dvi \
	viper.dvi \
	widget.dvi \
	woman.dvi

PDF_TARGETS = \
	ada-mode.pdf \
	auth.pdf \
	autotype.pdf \
	calc.pdf \
	cc-mode.pdf \
	cl.pdf \
	dbus.pdf \
	dired-x.pdf \
	ebrowse.pdf \
	ede.pdf \
	ediff.pdf \
	edt.pdf \
	eieio.pdf \
	emacs-mime.pdf \
	epa.pdf \
	erc.pdf \
	ert.pdf \
	eshell.pdf \
	eudc.pdf \
	faq.pdf \
	flymake.pdf \
	forms.pdf \
	gnus.pdf \
	idlwave.pdf \
	info.pdf \
	mairix-el.pdf \
	message.pdf \
	mh-e.pdf \
	newsticker.pdf \
	nxml-mode.pdf \
	org.pdf \
	pcl-cvs.pdf \
	pgg.pdf \
	rcirc.pdf \
	reftex.pdf \
	remember.pdf \
	sasl.pdf \
	sc.pdf \
	semantic.pdf \
	ses.pdf \
	sieve.pdf \
	smtpmail.pdf \
	speedbar.pdf \
	tramp.pdf \
	url.pdf \
	vip.pdf \
	viper.pdf \
	widget.pdf \
	woman.pdf

HTML_TARGETS = emacs-faq.html

TEXI2DVI = texi2dvi
TEXI2PDF = texi2pdf

ENVADD = TEXINPUTS="$(srcdir):$(emacsdir):$(TEXINPUTS)" \
         MAKEINFO="$(MAKEINFO) $(MAKEINFO_OPTS)"

mkinfodir = @cd ${srcdir}; test -d ${infodir} || mkdir ${infodir} || test -d ${infodir}

.PHONY: info dvi pdf

info: $(INFO_TARGETS)

# please modify this for all the web manual targets
webhack: clean
	$(MAKE) pdf MAKEINFO_OPTS="-DWEBHACKDEVEL $(MAKEINFO_OPTS)"

dvi: $(DVI_TARGETS)

pdf: $(PDF_TARGETS)

# Note that all the Info targets build the Info files
# in srcdir.  There is no provision for Info files
# to exist in the build directory.
# In a distribution of Emacs, the Info files should be up to date.

## "short" target names for convenience, to just rebuild one manual.
ada-mode : $(infodir)/ada-mode
$(infodir)/ada-mode: ada-mode.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
ada-mode.dvi: ${srcdir}/ada-mode.texi
	$(ENVADD) $(TEXI2DVI) $<
ada-mode.pdf: ${srcdir}/ada-mode.texi
	$(ENVADD) $(TEXI2PDF) $<

auth : $(infodir)/auth
$(infodir)/auth: auth.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
auth.dvi: ${srcdir}/auth.texi
	$(ENVADD) $(TEXI2DVI) $<
auth.pdf: ${srcdir}/auth.texi
	$(ENVADD) $(TEXI2PDF) $<

autotype : $(infodir)/autotype
$(infodir)/autotype: autotype.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
autotype.dvi: ${srcdir}/autotype.texi
	$(ENVADD) $(TEXI2DVI) $<
autotype.pdf: ${srcdir}/autotype.texi
	$(ENVADD) $(TEXI2PDF) $<

calc : $(infodir)/calc
$(infodir)/calc: calc.texi $(emacsdir)/emacsver.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
calc.dvi: ${srcdir}/calc.texi $(emacsdir)/emacsver.texi
	$(ENVADD) $(TEXI2DVI) $<
calc.pdf: ${srcdir}/calc.texi $(emacsdir)/emacsver.texi
	$(ENVADD) $(TEXI2PDF) $<

ccmode : $(infodir)/ccmode
$(infodir)/ccmode: cc-mode.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
cc-mode.dvi: ${srcdir}/cc-mode.texi
	$(ENVADD) $(TEXI2DVI) $<
cc-mode.pdf: ${srcdir}/cc-mode.texi
	$(ENVADD) $(TEXI2PDF) $<

cl : $(infodir)/cl
$(infodir)/cl: cl.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
cl.dvi: ${srcdir}/cl.texi
	$(ENVADD) $(TEXI2DVI) $<
cl.pdf: ${srcdir}/cl.texi
	$(ENVADD) $(TEXI2PDF) $<

dbus : $(infodir)/dbus
$(infodir)/dbus: dbus.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
dbus.dvi: ${srcdir}/dbus.texi
	$(ENVADD) $(TEXI2DVI) $< 
dbus.pdf: ${srcdir}/dbus.texi
	$(ENVADD) $(TEXI2PDF) $<

dired-x : $(infodir)/dired-x
$(infodir)/dired-x: dired-x.texi $(emacsdir)/emacsver.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
dired-x.dvi: ${srcdir}/dired-x.texi $(emacsdir)/emacsver.texi
	$(ENVADD) $(TEXI2DVI) $<
dired-x.pdf: ${srcdir}/dired-x.texi $(emacsdir)/emacsver.texi
	$(ENVADD) $(TEXI2PDF) $<

ebrowse : $(infodir)/ebrowse
$(infodir)/ebrowse: ebrowse.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
ebrowse.dvi: ${srcdir}/ebrowse.texi
	$(ENVADD) $(TEXI2DVI) $<
ebrowse.pdf: ${srcdir}/ebrowse.texi
	$(ENVADD) $(TEXI2PDF) $<

ede : $(infodir)/ede
$(infodir)/ede: ede.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
ede.dvi: ${srcdir}/ede.texi
	$(ENVADD) $(TEXI2DVI) $<
ede.pdf: ${srcdir}/ede.texi
	$(ENVADD) $(TEXI2PDF) $<

ediff : $(infodir)/ediff
$(infodir)/ediff: ediff.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
ediff.dvi: ${srcdir}/ediff.texi
	$(ENVADD) $(TEXI2DVI) $<
ediff.pdf: ${srcdir}/ediff.texi
	$(ENVADD) $(TEXI2PDF) $<

edt : $(infodir)/edt
$(infodir)/edt: edt.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
edt.dvi: ${srcdir}/edt.texi
	$(ENVADD) $(TEXI2DVI) $<
edt.pdf: ${srcdir}/edt.texi
	$(ENVADD) $(TEXI2PDF) $<

eieio : $(infodir)/eieio
$(infodir)/eieio: eieio.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
eieio.dvi: ${srcdir}/eieio.texi
	$(ENVADD) $(TEXI2DVI) $<
eieio.pdf: ${srcdir}/eieio.texi
	$(ENVADD) $(TEXI2PDF) $<

emacs-mime : $(infodir)/emacs-mime
$(infodir)/emacs-mime: emacs-mime.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) --enable-encoding $<
emacs-mime.dvi: ${srcdir}/emacs-mime.texi
	$(ENVADD) $(TEXI2DVI) $<
emacs-mime.pdf: ${srcdir}/emacs-mime.texi
	$(ENVADD) $(TEXI2PDF) $<

epa : $(infodir)/epa
$(infodir)/epa: epa.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
epa.dvi: ${srcdir}/epa.texi
	$(ENVADD) $(TEXI2DVI) $<
epa.pdf: ${srcdir}/epa.texi
	$(ENVADD) $(TEXI2PDF) $<

erc : $(infodir)/erc
$(infodir)/erc: erc.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
erc.dvi: ${srcdir}/erc.texi
	$(ENVADD) $(TEXI2DVI) $<
erc.pdf: ${srcdir}/erc.texi
	$(ENVADD) $(TEXI2PDF) $<

ert : $(infodir)/ert
$(infodir)/ert: ert.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
ert.dvi: ${srcdir}/ert.texi
	$(ENVADD) $(TEXI2DVI) $<
ert.pdf: ${srcdir}/ert.texi
	$(ENVADD) $(TEXI2PDF) $<

eshell : $(infodir)/eshell
$(infodir)/eshell: eshell.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
eshell.dvi: ${srcdir}/eshell.texi
	$(ENVADD) $(TEXI2DVI) $<
eshell.pdf: ${srcdir}/eshell.texi
	$(ENVADD) $(TEXI2PDF) $<

eudc : $(infodir)/eudc
$(infodir)/eudc: eudc.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
eudc.dvi: ${srcdir}/eudc.texi
	$(ENVADD) $(TEXI2DVI) $<
eudc.pdf: ${srcdir}/eudc.texi
	$(ENVADD) $(TEXI2PDF) $<

efaq : $(infodir)/efaq
$(infodir)/efaq: faq.texi $(emacsdir)/emacsver.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
faq.dvi: ${srcdir}/faq.texi $(emacsdir)/emacsver.texi
	$(ENVADD) $(TEXI2DVI) $<
faq.pdf: ${srcdir}/faq.texi $(emacsdir)/emacsver.texi
	$(ENVADD) $(TEXI2PDF) $<
## This is the name used on the Emacs web-page.
## sed fixes up links to point to split version of the manual.
emacs-faq.html: ${srcdir}/faq.texi $(emacsdir)/emacsver.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) --no-split \
	  --css-ref='/layout.css' --html -o $@ $<
	sed -i -e 's|a href="\([a-z]*\)\.html#\([^"]*\)"|a href="manual/html_node/\1/\2.html"|g' \
	  -e 's|/Top\.html|/|g' $@
emacs-faq.text: ${srcdir}/faq.texi $(emacsdir)/emacsver.texi
	$(MAKEINFO) $(MAKEINFO_OPTS) --plaintext -o $@ $<

flymake : $(infodir)/flymake
$(infodir)/flymake: flymake.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
flymake.dvi: ${srcdir}/flymake.texi
	$(ENVADD) $(TEXI2DVI) $<
flymake.pdf: ${srcdir}/flymake.texi
	$(ENVADD) $(TEXI2PDF) $<

forms : $(infodir)/forms
$(infodir)/forms: forms.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
forms.dvi: ${srcdir}/forms.texi
	$(ENVADD) $(TEXI2DVI) $<
forms.pdf: ${srcdir}/forms.texi
	$(ENVADD) $(TEXI2PDF) $<

# gnus/message/emacs-mime/sieve/pgg are part of Gnus:
gnus : $(infodir)/gnus
$(infodir)/gnus: gnus.texi gnus-faq.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
gnus.dvi: ${srcdir}/gnus.texi gnus-faq.texi
	sed -e '/@iflatex/,/@end iflatex/d' $< > gnustmp.texi
	$(ENVADD) $(TEXI2DVI) gnustmp.texi
	cp gnustmp.dvi $*.dvi
	rm gnustmp.*
gnus.pdf: ${srcdir}/gnus.texi gnus-faq.texi
	sed -e '/@iflatex/,/@end iflatex/d' $< > gnustmp.texi
	$(ENVADD) $(TEXI2PDF) gnustmp.texi
	cp gnustmp.pdf $@
	rm gnustmp.*

# This is produced with --no-split to avoid making files whose
# names clash on DOS 8+3 filesystems
idlwave : $(infodir)/idlwave
$(infodir)/idlwave: idlwave.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) --no-split $<
idlwave.dvi: ${srcdir}/idlwave.texi
	$(ENVADD) $(TEXI2DVI) $<
idlwave.pdf: ${srcdir}/idlwave.texi
	$(ENVADD) $(TEXI2PDF) $<

# The following target uses an explicit -o switch to work around
# the @setfilename directive in info.texi, which is required for
# the Texinfo distribution.
###info : $(infodir)/info   # circular!
$(infodir)/info: info.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) --no-split $< -o $@
info.dvi: ${srcdir}/info.texi
	$(ENVADD) $(TEXI2DVI) $<
info.pdf: ${srcdir}/info.texi
	$(ENVADD) $(TEXI2PDF) $<

mairix-el : $(infodir)/mairix-el
$(infodir)/mairix-el: mairix-el.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
mairix-el.dvi: ${srcdir}/mairix-el.texi
	$(ENVADD) $(TEXI2DVI) $<
mairix-el.pdf: ${srcdir}/mairix-el.texi
	$(ENVADD) $(TEXI2PDF) $<

message : $(infodir)/message
$(infodir)/message: message.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
message.dvi: ${srcdir}/message.texi
	$(ENVADD) $(TEXI2DVI) $<
message.pdf: ${srcdir}/message.texi
	$(ENVADD) $(TEXI2PDF) $<

mh-e : $(infodir)/mh-e
$(infodir)/mh-e: mh-e.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
mh-e.dvi: ${srcdir}/mh-e.texi
	$(ENVADD) $(TEXI2DVI) $<
mh-e.pdf: ${srcdir}/mh-e.texi
	$(ENVADD) $(TEXI2PDF) $<

newsticker : $(infodir)/newsticker
$(infodir)/newsticker: newsticker.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
newsticker.dvi: ${srcdir}/newsticker.texi
	$(ENVADD) $(TEXI2DVI) $<
newsticker.pdf: ${srcdir}/newsticker.texi
	$(ENVADD) $(TEXI2PDF) $<

nxml-mode : $(infodir)/nxml-mode
$(infodir)/nxml-mode: nxml-mode.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
nxml-mode.dvi: ${srcdir}/nxml-mode.texi
	$(ENVADD) $(TEXI2DVI) $<
nxml-mode.pdf: ${srcdir}/nxml-mode.texi
	$(ENVADD) $(TEXI2PDF) $<

org : $(infodir)/org
$(infodir)/org: org.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
org.dvi: ${srcdir}/org.texi
	$(ENVADD) $(TEXI2DVI) $<
org.pdf: ${srcdir}/org.texi
	$(ENVADD) $(TEXI2PDF) $<

pcl-cvs : $(infodir)/pcl-cvs
$(infodir)/pcl-cvs: pcl-cvs.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
pcl-cvs.dvi: ${srcdir}/pcl-cvs.texi
	$(ENVADD) $(TEXI2DVI) $<
pcl-cvs.pdf: ${srcdir}/pcl-cvs.texi
	$(ENVADD) $(TEXI2PDF) $<

pgg : $(infodir)/pgg
$(infodir)/pgg: pgg.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
pgg.dvi: ${srcdir}/pgg.texi
	$(ENVADD) $(TEXI2DVI) $<
pgg.pdf: ${srcdir}/pgg.texi
	$(ENVADD) $(TEXI2PDF) $<

rcirc : $(infodir)/rcirc
$(infodir)/rcirc: rcirc.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
rcirc.dvi: ${srcdir}/rcirc.texi
	$(ENVADD) $(TEXI2DVI) $<
rcirc.pdf: ${srcdir}/rcirc.texi
	$(ENVADD) $(TEXI2PDF) $<

reftex : $(infodir)/reftex
$(infodir)/reftex: reftex.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
reftex.dvi: ${srcdir}/reftex.texi
	$(ENVADD) $(TEXI2DVI) $<
reftex.pdf: ${srcdir}/reftex.texi
	$(ENVADD) $(TEXI2PDF) $<

remember : $(infodir)/remember
$(infodir)/remember: remember.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
remember.dvi: ${srcdir}/remember.texi
	$(ENVADD) $(TEXI2DVI) $<
remember.pdf: ${srcdir}/remember.texi
	$(ENVADD) $(TEXI2PDF) $<

sasl : $(infodir)/sasl
$(infodir)/sasl: sasl.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
sasl.dvi: ${srcdir}/sasl.texi
	$(ENVADD) $(TEXI2DVI) $<
sasl.pdf: ${srcdir}/sasl.texi
	$(ENVADD) $(TEXI2PDF) $<

sc : $(infodir)/sc
$(infodir)/sc: sc.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
sc.dvi: ${srcdir}/sc.texi
	$(ENVADD) $(TEXI2DVI) $<
sc.pdf: ${srcdir}/sc.texi
	$(ENVADD) $(TEXI2PDF) $<

semantic : $(infodir)/semantic
$(infodir)/semantic: semantic.texi sem-user.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
semantic.dvi: ${srcdir}/semantic.texi sem-user.texi
	$(ENVADD) $(TEXI2DVI) $<
semantic.pdf: ${srcdir}/semantic.texi sem-user.texi
	$(ENVADD) $(TEXI2PDF) $<

ses : $(infodir)/ses
$(infodir)/ses: ses.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
ses.dvi: ${srcdir}/ses.texi
	$(ENVADD) $(TEXI2DVI) $<
ses.pdf: ${srcdir}/ses.texi
	$(ENVADD) $(TEXI2PDF) $<

sieve : $(infodir)/sieve
$(infodir)/sieve: sieve.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
sieve.dvi: ${srcdir}/sieve.texi
	$(ENVADD) $(TEXI2DVI) $<
sieve.pdf: ${srcdir}/sieve.texi
	$(ENVADD) $(TEXI2PDF) $<

smtpmail : $(infodir)/smtpmail
$(infodir)/smtpmail: smtpmail.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
smtpmail.dvi: ${srcdir}/smtpmail.texi
	$(ENVADD) $(TEXI2DVI) $<
smtpmail.pdf: ${srcdir}/smtpmail.texi
	$(ENVADD) $(TEXI2PDF) $<

speedbar : $(infodir)/speedbar
$(infodir)/speedbar: speedbar.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
speedbar.dvi: ${srcdir}/speedbar.texi
	$(ENVADD) $(TEXI2DVI) $<
speedbar.pdf: ${srcdir}/speedbar.texi
	$(ENVADD) $(TEXI2PDF) $<

tramp : $(infodir)/tramp
$(infodir)/tramp: tramp.texi trampver.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) -D emacs $<
tramp.dvi: ${srcdir}/tramp.texi trampver.texi
	$(ENVADD) $(TEXI2DVI) $<
tramp.pdf: ${srcdir}/tramp.texi trampver.texi
	$(ENVADD) $(TEXI2PDF) $<

url : $(infodir)/url
$(infodir)/url: url.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
url.dvi: ${srcdir}/url.texi
	$(ENVADD) $(TEXI2DVI) $<
url.pdf: ${srcdir}/url.texi
	$(ENVADD) $(TEXI2PDF) $<

vip : $(infodir)/vip
$(infodir)/vip: vip.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
vip.dvi: ${srcdir}/vip.texi
	$(ENVADD) $(TEXI2DVI) $<
vip.pdf: ${srcdir}/vip.texi
	$(ENVADD) $(TEXI2PDF) $<

viper : $(infodir)/viper
$(infodir)/viper: viper.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
viper.dvi: ${srcdir}/viper.texi
	$(ENVADD) $(TEXI2DVI) $<
viper.pdf: ${srcdir}/viper.texi
	$(ENVADD) $(TEXI2PDF) $<

widget : $(infodir)/widget
$(infodir)/widget: widget.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
widget.dvi: ${srcdir}/widget.texi
	$(ENVADD) $(TEXI2DVI) $<
widget.pdf: ${srcdir}/widget.texi
	$(ENVADD) $(TEXI2PDF) $<

woman : $(infodir)/woman
$(infodir)/woman: woman.texi
	$(mkinfodir)
	cd $(srcdir); $(MAKEINFO) $(MAKEINFO_OPTS) $<
woman.dvi: ${srcdir}/woman.texi
	$(ENVADD) $(TEXI2DVI) $<
woman.pdf: ${srcdir}/woman.texi
	$(ENVADD) $(TEXI2PDF) $<


.PHONY: mostlyclean clean distclean maintainer-clean

mostlyclean:
	rm -f *.aux *.log *.toc *.cp *.cps *.fn *.fns *.ky *.kys \
	  *.op *.ops *.pg *.pgs *.tp *.tps *.vr *.vrs
	rm -f gnustmp.*

clean: mostlyclean
	rm -f $(DVI_TARGETS) $(PDF_TARGETS) $(HTML_TARGETS) emacs-faq.text

distclean: clean
#	rm -f Makefile

## infodir is relative to srcdir.
maintainer-clean: distclean
	cd $(srcdir); for file in $(INFO_TARGETS); do \
	  rm -f $${file} $${file}-[1-9] $${file}-[1-9][0-9]; \
	done

### Makefile ends here
