#*************************************************************************
#
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
# 
# Copyright 2000, 2010 Oracle and/or its affiliates.
#
# OpenOffice.org - a multi-platform office productivity suite
#
# This file is part of OpenOffice.org.
#
# OpenOffice.org is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License version 3
# only, as published by the Free Software Foundation.
#
# OpenOffice.org is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License version 3 for more details
# (a copy is included in the LICENSE file that accompanied this code).
#
# You should have received a copy of the GNU Lesser General Public License
# version 3 along with OpenOffice.org.  If not, see
# <http://www.openoffice.org/license.html>
# for a copy of the LGPLv3 License.
#
#*************************************************************************

PRJ=../..
PRJNAME=l10n
TARGET=l10n_kid

##########################################################################
#
# Use me to update the key id file.
# DO NOT USE FOR MIXED REPOSSITORIES 
#
#########################################################################

# --- Targets ------------------------------------------------------
.INCLUDE : settings.mk

MYTEMP:=$(mktmp ) 

.INCLUDE : target.mk


blah:
    $(LOCALIZE_SL) -e -l en-US -f $(MYTEMP)
    $(RM) 	$(PRJ)$/source$/kid$/localize.sdf
    $(PERL) $(SOLARVER)$/$(INPATH)$/bin$(UPDMINOREXT)$/keyidGen.pl $(MYTEMP) $(PRJ)$/source$/kid$/localize.sdf_tmp
    $(TYPE) lic.header $(PRJ)$/source$/kid$/localize.sdf_tmp | sed -e "s/\ten-US\t/\tkid\t/" > $(PRJ)$/source$/kid$/localize.sdf
    $(RM) $(MYTEMP) $(PRJ)$/source$/kid$/localize.sdf_tmp


ALLTAR : blah 

