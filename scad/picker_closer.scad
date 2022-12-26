//include <libs/nutsnbolts/cyl_head_bolt.scad>;
//include <libs/nutsnbolts/materials.scad>;
//include <libs/utils.scad>;
//include <libs/nwh_utils.scad>;
include <libs/MCAD/utilities.scad>;
include <libs/MCAD/involute_gears.scad>;

gear();
tab=true; // attachment tab, or pull arm

//translate([0,0,0]) {
//        translate([0,5,0])
//            rack(modul=1, length=100, height=5, width=5, pressure_angle=20, helix_angle=00);
//        mirror([0,1,0]) 
//            translate([0,5,0])
//            rack(modul=1, length=100, height=5, width=5, pressure_angle=20, helix_angle=00);
//
//}


//cube([10,10,10]);
