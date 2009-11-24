#!/bin/tcsh

set files = `echo "$*" | cut -d" " -f1 --complement`
if ( $# <= 2 ) then
    echo "Process a sed expression onto a set of files"
    echo "call me fix_l10n.sh <sed expression> <file>"
    echo "e.g.    fix_l10n.sh s/test/ivo/g *.sdf"
    exit( -1 )
endif  

foreach file ( $files )
    echo "Processing $1 on file $file"
    cat $file | sed -e "$1" > $file.tmp
    mv $file.tmp $file
end
