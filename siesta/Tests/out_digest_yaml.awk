#
# Simple awk script to create a "digest" in YAML format of key results in a
# SIESTA .out file.
# This digest can then be compared with a reference to help in
# finding discrepancies.
#
# A. Garcia, Sep 2023
#
#  Section names and organization are tentative
#  There is an "unsorted" section whose values are directly printed
#  when found. For the stress and multi-valued variables in general one
#  could use awk arrays to store the values and print at the end.
#
#  More variables could be added in an obvious manner.
#
# basic params
#
BEGIN{
    print "%YAML 1.2"; print "---";
    print ""; print "unsorted:"
}
#
# basic geometry
#
/Cell vector modules / {cellvx = $7; cellvy = $8; cellvz = $9}
/Cell angles / {cellaa = $6; cellab = $7; cellac = $8}
#
# energy components
#
/siesta: Ebs / {Ebs = $4}
/siesta: Eions / {Eions = $4}
/siesta: Ena   / {Ena = $4}
/siesta: Ekin  / {Ekin = $4}
/siesta: Edftu / {Edftu = $4}
/siesta: Eso   / {Eso = $4}
/siesta: Enl   / {Enl = $4}
/siesta: Eharris / {Eharris = $4}
/siesta: Etot / {Etot = $4}
/siesta: FreeEng / {FreeEng = $4}
/siesta: E_KS\(eV\)/ {KS_E = $4}
/siesta: Eharris\(eV\)/ {Harris_E = $4 }
/siesta: D3 dispersion/ {E_DFTD3 = $5}
#
#forces
#
/sqrt\( Sum f/ {Res_force = $2}
/constrained/ {Max_force = $2}
#
#pressure
#
/Stress-tensor-Voigt/ { stress1 = $3; stress2 = $4; stress3 = $5; stress4 = $6; stress5 = $7; stress6 = $8}
#
# polarization
#
/Along the lattice vectors / { haspoll=1; pollatt1=$6; pollat2=$7; pollat3=$8 }
/Along cartesian / { haspolc=1; polcart1=$6; polcart2=$7; polcart3=$8}
#
# optical
#
/Checking f-sum rule/ {optical=1; f_sum_rule = $5}
#
# spin
#
/\(Qup-Qdown\)/ {spin=1; Spin_pol = $7}
#
# mulliken
#
/mulliken: Qtot / {mulliken=1; Qtot = $4}

END{
    #
    # Print in sets all the variables that could be gathered
    # Note that these will be the last values seen (for example, for energies)
    #
    print "energies:"
    printf "  %-20s %20.6f\n", "Ebs:", Ebs
    printf "  %-20s %20.6f\n", "Eions:", Eions
    printf "  %-20s %20.6f\n", "Ena:", Ena
    printf "  %-20s %20.6f\n", "Ekin:", Ekin
    printf "  %-20s %20.6f\n", "Edftu:", Edftu
    printf "  %-20s %20.6f\n", "Eso:", Eso
    printf "  %-20s %20.6f\n", "Enl:", Enl
    printf "  %-20s %20.6f\n", "Eharris:", Eharris
    printf "  %-20s %20.6f\n", "FreeEng:", FreeEng
    printf "  %-20s %20.6f\n", "KS_E:", KS_E
    printf "  %-20s %20.6f\n", "Harris_E:", Harris_E
    printf "  %-20s %20.6f\n", "EDFTD3:", E_DFTD3
    printf "  %-20s %20.6f\n", "Etot:", Etot
    print "forces:"
    printf "  %-20s %20.6f\n", "Res_force:", Res_force
    printf "  %-20s %20.6f\n", "Max_force:", Max_force

    if (spin)  print "spin:"
    if (spin) printf "  %-20s %20.6f\n", "Spin_pol:", Spin_pol
    if (mulliken) print "mulliken:"
    if (mulliken) printf "  %-20s %20.6f\n", "Qtot:", Qtot
    if (optical) print "optical:"
    if (optical) printf "  %-20s %20.6f\n", "f_sum_rule:", f_sum_rule

    print "geometry:"
    printf "  %-20s [%10.6f,%10.6f,%10.6f]\n", "Cellvec:", cellvx, cellvy, cellvz
    printf "  %-20s [%10.4f,%10.4f,%10.4f]\n", "Cellang:", cellaa, cellab, cellac
    printf "  %-20s [%10.2f,%10.2f,%10.2f,%10.2f,%10.2f,%10.2f]\n", "Stress:", stress1, stress2, stress3, stress4, stress5, stress6

    if (haspoll) printf "  %-20s [%20.6f,%20.6f,%20.6f]\n", "Pol-latt:", pollat1, pollat2, pollat3
    if (haspolc) printf "  %-20s [%20.6f,%20.6f,%20.6f]\n", "Pol-cart:", polcar1, polcar2, polcar3
}
