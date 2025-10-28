#
# Simple awk script to create a "digest" of key results in a
# SIESTA .out file.
# This digest can then be compared with a reference to help in
# finding discrepancies.
# The tolerances (widths of decimal fields) in this version are
# hard-wired.
#
# A. Garcia, Feb. 2011. Modified by F. Pedron 2023.

# Basic geometry
/Cell vector modules / {printf "%-20s %20.4f%20.4f%20.4f\n", "CellVec", $7, $8, $9}
/Cell angles /     {printf "%-20s %20.4f%20.4f%20.4f\n", "CellAng", $6, $7, $8}

# energy components
/siesta: Ebs / {printf "%-20s %20.4f\n", "Ebs", $4}
/siesta: Eions /  {printf "%-20s %20.4f\n", "Eions", $4}
/siesta: Ena   /  {printf "%-20s %20.4f\n", "Ena", $4}
/siesta: DEna   /  {printf "%-20s %20.4f\n", "DEna", $4}
/siesta: Ekin  /  {printf "%-20s %20.4f\n", "Ekin", $4}
/siesta: Edftu /  {printf "%-20s %20.4f\n", "Edftu", $4}
/siesta: Eso   /  {printf "%-20s %20.4f\n", "Eso", $4}
/siesta: Enl   / {printf "%-20s %20.4f\n", "Enl", $4}
/siesta: Exc   / {printf "%-20s %20.4f\n", "Exc", $4}
/siesta: Eharris / {printf "%-20s %20.4f\n", "Eharris", $4}
/siesta: Etot / {printf "%-20s %20.4f\n", "Etot", $4}
/siesta: FreeEng / {printf "%-20s %20.4f\n", "FreeEng", $4}
/siesta: EbV   / {printf "%-20s %20.4f\n", "EbV", $4}
/siesta: Emolmec / {printf "%-20s %20.4f\n", "Emolmec", $4}
/siesta: Emadel / {printf "%-20s %20.4f\n", "Emadel", $4}
/siesta: Ekinion / {printf "%-20s %20.4f\n", "Ekinion", $4}
/siesta:     Bulk bias / {printf "%-20s %20.4f\n", "Bulk bias", $4}
/siesta:       Ion-ion / {printf "%-20s %20.4f\n", "IonIon", $4}
/siesta:   Ext\. field / {printf "%-20s %20.4f\n", "ExtField", $4}
/siesta: D3 dispersion / {printf "%-20s %20.4f\n", "D3dispersion", $4}
/siesta:         Fermi / {printf "%-20s %20.4f\n", "Fermi", $4}

#forces
/sqrt\( Sum f/ {printf "%-20s %20.4f\n", "ResForce", $2}
/constrained/ {printf "%-20s %20.4f\n", "MaxForce", $2}

#pressure
/Stress tensor Voigt/ {printf "%-20s %10.2f%10.2f%10.2f%10.2f%10.2f%10.2f\n", "Stress", $3, $4, $5, $6, $7, $8}

# polarization
/Along the lattice vectors / {printf "%-20s %20.4f%20.4f%20.4f\n", "PolLatt", $6, $7, $8}
/Along cartesian / {printf "%-20s %20.4f%20.4f%20.4f\n", "PolCart", $5, $6, $7}

# optical
/Checking f-sum rule/  {printf "%-20s %20.4f\n", "fSumRule", $5}

# spin
/\(Qup-Qdown\)/ {printf "%-20s %20.4f\n", "SpinPol", $7}

# mulliken
/mulliken: Qtot / {printf "%-20s %20.4f\n", "Mulliken", $4}

