#*************************************************************************
#
#   $RCSfile: makefile.mk,v $
#
#   $Revision: 1.2 $
#
#   last change: $Author: hjs $ $Date: 2007/07/18 16:22:31 $
#
#   The Contents of this file are made available subject to the terms of
#   either of the following licenses
#
#          - GNU Lesser General Public License Version 2.1
#          - Sun Industry Standards Source License Version 1.1
#
#   Sun Microsystems Inc., October, 2000
#
#   GNU Lesser General Public License Version 2.1
#   =============================================
#   Copyright 2000 by Sun Microsystems, Inc.
#   901 San Antonio Road, Palo Alto, CA 94303, USA
#
#   This library is free software; you can redistribute it and/or
#   modify it under the terms of the GNU Lesser General Public
#   License version 2.1, as published by the Free Software Foundation.
#
#   This library is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   Lesser General Public License for more details.
#
#   You should have received a copy of the GNU Lesser General Public
#   License along with this library; if not, write to the Free Software
#   Foundation, Inc., 59 Temple Place, Suite 330, Boston,
#   MA  02111-1307  USA
#
#
#   Sun Industry Standards Source License Version 1.1
#   =================================================
#   The contents of this file are subject to the Sun Industry Standards
#   Source License Version 1.1 (the "License"); You may not use this file
#   except in compliance with the License. You may obtain a copy of the
#   License at http://www.openoffice.org/license.html.
#
#   Software provided under this License is provided on an "AS IS" basis,
#   WITHOUT WARRUNTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING,
#   WITHOUT LIMITATION, WARRUNTIES THAT THE SOFTWARE IS FREE OF DEFECTS,
#   MERCHANTABLE, FIT FOR A PARTICULAR PURPOSE, OR NON-INFRINGING.
#   See the License for the specific provisions governing your rights and
#   obligations concerning the Software.
#
#   The Initial Developer of the Original Code is: Sun Microsystems, Inc..
#
#   Copyright: 2000 by Sun Microsystems, Inc.
#
#   All Rights Reserved.
#
#   Contributor(s): _______________________________________
#
#
#
#*************************************************************************

PRJ=..
PRJNAME=l10n
TARGET=l10n_merge

# --- Targets ------------------------------------------------------
.INCLUDE : settings.mk

.IF "$(WITH_LANG)" == ""

@all:
    @echo "Nothing to do - en-US only build."
.ELSE

.IF "$(USE_SHELL)"!="4nt"
all_sdfs:=$(shell cd $(PRJ)$/source && ls -1 *$/localize.sdf)
.ELSE          # "$(USE_SHELL)"!="4nt"
all_sdfs:=$(shell $(CDD) $(PRJ)$/source && find * -name localize.sdf)
all_sdfs!:=$(subst,/,\ $(all_sdfs))
.ENDIF          # "$(USE_SHELL)"!="4nt"

.INCLUDE .IGNORE : $(COMMONMISC)$/sdf$/lock.mk

.INCLUDE : target.mk

ALLTAR : $(COMMONMISC)$/merge.done

$(COMMONMISC)$/merge.done : $(all_sdfs)
.IF "$(L10N_LOCK)" != "YES"
#	$(IFEXIST) $(COMMONMISC)$/sdf $(THEN) rm -rf $(COMMONMISC)$/sdf
    $(IFEXIST) $(COMMONMISC)$/sdf $(THEN) $(RENAME) $(COMMONMISC)$/sdf $(COMMONMISC)$/sdf$(INPATH)_begone $(FI)
    -rm -rf $(COMMONMISC)$/sdf$(INPATH)_begone
    -$(MKDIRHIER) $(COMMONMISC)$/sdf
.ENDIF			# "$(L10n_LOCK)" != "YES"
    $(PERL) $(SOLARVER)$/$(INPATH)$/bin$(UPDMINOREXT)$/fast_merge.pl -sdf_files $(mktmp $<) -merge_dir $(COMMONMISC)$/sdf && $(TOUCH) $@

.ENDIF
