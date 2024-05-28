#!/bin/zsh

echo "# Colors I like. Subject to change without notice" > color.cxc
echo "" >> color.cxc

PALETTE=( "#0077BB" "#EE7733" "#EE3377" "#009988" "#CC3311" )
LPALETTE=( "#6ECAFF" "#FFA36E" "#ED8CB0" "#44DBCA" "#FF5F3B")
declare -i index=1

DEFAULT_COLORS="vol defaultvalues initialColors ${(j.,.)PALETTE}"
echo $DEFAULT_COLORS >> color.cxc
echo "" >> color.cxc

echo "# icol for Initial Color" >> color.cxc
for color in $PALETTE; do
    echo "color name icol$index $color" >> color.cxc
    index+=1
done

echo "" >> color.cxc
echo "# lcol for Lighter Color" >> color.cxc
index=1
for color in $LPALETTE; do
    echo "color name lcol$index $color" >> color.cxc
    index+=1
done