#!/usr/bin/bash

rm -f *.lmp

a=3.55

atomsk --create fcc $a Ni orient [-110] [111] [11-2] -duplicate 162 41 70 edge_Ni_110_top.cfg

atomsk --create fcc $a Ni orient [-110] [111] [11-2] -duplicate 161 41 70 edge_Ni_110_bottom.cfg

atomsk edge_Ni_110_top.cfg -deform X -0.003086419753 0.0 edge_Ni_110_top_deformed.cfg

atomsk edge_Ni_110_bottom.cfg -deform X 0.003105590062 0.0 edge_Ni_110_bottom_deformed.cfg

atomsk --merge Y 2 edge_Ni_110_bottom_deformed.cfg edge_Ni_110_top_deformed.cfg edge_Ni.cfg

atomsk edge_Ni.cfg -select random 1293502 Ni -sub Ni Co NiCo.cfg

atomsk NiCo.cfg -select random 1293502 Ni -sub Ni Cr NiCoCr.cfg

atomsk NiCoCr.cfg -select random 1293502 Ni -sub Ni Fe NiCoCrFe.cfg

atomsk NiCoCrFe.cfg -select random 388050 Ni -sub Ni Al data.NiCoCrFeAl_random_edge.cfg

#atomsk data.NiCoCrFeAl_random_edge.cfg -info
#atomsk edge_Ni.cfg -info

#atomsk data.NiCoCrFeAl_random_edge.cfg -remove-atoms select within_sphere 200.0 250.0 150.0 5 data.NiCoCrFeAl_random_void.cfg
#atomsk data.NiCoCrFeAl_random_edge.cfg -select in sphere 0.85*box 0.50*box 0.50*box 48.4 -rmatom select final.cfg lmp
atomsk data.NiCoCrFeAl_random_edge.cfg -select in sphere 0.85*box 0.50*box 0.50*box 48.4 -rmatom select sphere.cfg

atomsk --create CsCl 2.882 Ni orient [1-11] [110] [-112] -duplicate 80 123 43 new_Ni.cfg

#atomsk --create CsCl 2.882 Al Ni orient [1-1-2] [110] [1-11] -duplicate 57 122 60 B2.cfg

atomsk new_Ni.cfg -select out sphere 344.592 252.100 152.175 48.3 -rmatom select sphere_Ni.cfg

atomsk sphere_Ni.cfg -select random 19706 Ni -sub Ni Al sphere_NiAl.cfg

#atomsk final.cfg --insert final1.cfg 257.486 61.834 131.170 output.cfg lmp
atomsk --merge 2 sphere.cfg sphere_NiAl.cfg output.cfg lmp
#atomsk final.cfg -translate 0.5*box 0.50*box 0.50*box final1.cfg output.cfg lmp

mv output.lmp data.HEA_edge_B2_random

#rm *.cfg *.xyz *.lmp
