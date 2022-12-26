include <libs/nutsnbolts/cyl_head_bolt.scad>;
include <libs/nutsnbolts/materials.scad>;
include <libs/nwh_utils.scad>;


outer_w=32;
inner_w=22.5;
outer_l=46;
inner_l=26;
base_h=7;
tab_h=4.3;

sideslot_l=25;

arm_w=3;
arm_l=15;
arm_h=4.3;

w=32;
d=8;
round=10;
slot_w=6;
slot_d=4;
gap_w=22;

lug_w=6;

//body();

arm();

module body() {
    difference() {
        union() {
            baseback();

           // translate([0,(w/2)-6,0]) roundedRect([l-10,12,d], 3);
           // translate([l-16,(w/2)-8,0]) roundedRect([10,16,d], 3);
        }
       // translate([3,(w/2)-(slot_w/2),0]) cube([l,slot_w,slot_d]);
       // arm();

    }
}

module arm() {
    cube([arm_l,arm_w,arm_h]);
    hull() {
        translate([arm_l,arm_w,0]) cylinder(arm_h,arm_w,arm_w);
        translate([arm_l+arm_w,arm_w+arm_w,0]) cylinder(arm_h,arm_w,arm_w);
    }
}



module baseback() {
    difference() {
        union() { 
            roundedRect([inner_l,outer_w,d], round);
            translate([inner_l-round,0,0]) cube([round,outer_w,d]);

        }
        translate([inner_l,outer_w -6,0]) rotate([0,0,20]) cube([outer_w,outer_w,d]);
        translate([inner_l,6,0]) rotate([0,0,-20]) translate([0,-outer_w,0]) cube([outer_w,outer_w,d]);
              translate([8,0,0]) rotate([0,0,90]) roundel(r=8);



    }
}

module sideslot() {
}



    