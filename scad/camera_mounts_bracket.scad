// Bracket for attaching headcams to a pole, for use near a birdbox
$fn=50;
include <libs/nutsnbolts/cyl_head_bolt.scad>;
include <libs/nutsnbolts/materials.scad>;
include <libs/nwh_utils.scad>;


rod_d=8.5; 
rod_r=rod_d/2+0.1; 	// rod radius with clearance

rod_h = 30;
rod_w = rod_d+6;



module rod_end() {
	difference() {
 		translate([-rod_w/2,-rod_w/2,0]) cube([rod_w,rod_w,rod_h]);
		cylinder(r1=rod_r,r2=rod_r,h=rod_h);
	}
	translate([-10,-16,0]) cube([50,46,5]);
	translate([-10,-16,0]) cube([5,46,rod_h]);


}




difference() {
rod_end();

translate([12,-10,15]) hole_through(name="M3", l=30, cl=0.1, h=0, hcl=0.1);	
translate([12,0,15])  hole_through(name="M3", l=30, cl=0.1, h=0, hcl=0.1);	
translate([12,10,15]) hole_through(name="M3", l=30, cl=0.1, h=0, hcl=0.1);	

translate([22,0,15])  hole_through(name="M3", l=30, cl=0.1, h=0, hcl=0.1);	
translate([32,0,15])  hole_through(name="M3", l=30, cl=0.1, h=0, hcl=0.1);	

translate([12,-10,6]) nutcatch_parallel("M3",l=3);	
translate([12,0,6]) nutcatch_parallel("M3",l=3);	
translate([12,10,6]) nutcatch_parallel("M3",l=3);	

translate([22,0,6]) nutcatch_parallel("M3",l=3);	
translate([32,0,6]) nutcatch_parallel("M3",l=3);	


// vert holes

translate([0,13,10]) rotate([0,90,0])  hole_through(name="M3", l=30, cl=0.1, h=0, hcl=0.1);	
translate([0,13,20]) rotate([0,90,0])  hole_through(name="M3", l=30, cl=0.1, h=0, hcl=0.1);	
translate([0,23,20]) rotate([0,90,0])  hole_through(name="M3", l=30, cl=0.1, h=0, hcl=0.1);	

translate([-4,13,10]) rotate([0,90,0])  nutcatch_parallel("M3",l=3);
translate([-4,13,20]) rotate([0,90,0])  nutcatch_parallel("M3",l=3);
translate([-4,23,20]) rotate([0,90,0])  nutcatch_parallel("M3",l=3);

// Champher like you mean it
translate([-10,35,0])  rotate([0,0,-30]) cube([450,450,5]);
translate([30,-80,0])  rotate([0,0,30]) cube([60,60,5]);
translate([-10,-49.5,0]) rotate([-19,0,0])	cube([5,30,rod_h*2]);

}

