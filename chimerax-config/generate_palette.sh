#!/bin/zsh

echo "# Colors I like. Subject to change without notice" > color.cxc
echo "" >> color.cxc

PALETTE=( "#0077BB" "#EE7733" "#EE3377" "#009988" "#CC3311" )
LPALETTE=( "#6ECAFF" "#FFA36E" "#ED8CB0" "#44DBCA" "#FF5F3B" )
ARCH_PALETTE=( "#93B1E9" "#492376" "#955B87" "#FEA398" "#C83320" "#FC9000" "#FFD700" )
CROSS_PALETTE=( "#FAB06E" "#E4766E" "#E7723D" "#99A87C" "#6B968D" "#73A2A9" "#005E75" "#0E2E61" "#D67FB0")
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

echo "" >> color.cxc
echo "# Archambault palette" >> color.cxc
index=1
for color in $ARCH_PALETTE; do
    echo "color name archcol$index $color" >> color.cxc
    index+=1
done

echo "" >> color.cxc
echo "# Cross palette" >> color.cxc
index=1
for color in $CROSS_PALETTE; do
    echo "color name crosscol$index $color" >> color.cxc
    index+=1
done

echo "" >> color.cxc
echo "color name slidebg #f0f4ff" >> color.cxc
echo "color name egyptRed #E66735" >> color.cxc
echo "color name egyptBlue #008EB2" >> color.cxc
echo "color name egyptGreen #4FBD96" >> color.cxc
echo "color name egyptYellow #FCBF67" >> color.cxc
