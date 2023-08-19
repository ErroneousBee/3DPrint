// Bracket for attaching headcams to a pole, for use near a birdbox
$fn=50;
include <libs/nutsnbolts/cyl_head_bolt.scad>;
include <libs/nutsnbolts/materials.scad>;
include <libs/nwh_utils.scad>;


top_d=95;
top_r=top_d/2;
wall=2;

difference() {
cylinder(10, top_r+wall, top_r+wall);
translate([0,0,wall]) cylinder(10, top_r, top_r);
}




