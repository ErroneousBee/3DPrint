include <libs/nutsnbolts/cyl_head_bolt.scad>;
include <libs/nutsnbolts/materials.scad>;
include <libs/nwh_utils.scad>;
$fn=150;

module clamp(length=30,inner_diameter=26,wall_thickness=4,angle=0) {
	base_width = 32;
	radius=inner_diameter/2;

	difference(){
		union() {
			cylinder(h=length,r=radius+wall_thickness);
			translate([-base_width/2,radius+1,0]) cube([base_width,8,length]);
			rotate([0,0,32]) translate([-2,radius+1,0]) cube([4,4,length]);
			rotate([0,0,-32]) translate([-2,radius+1,0]) cube([4,4,length]);

		}

		// Hollw cylinder and gap
		translate([0,0,-1]) cylinder(h=length+2,r=radius);
		translate([-20,-radius*2.7,-1]) cube([40,inner_diameter,length+2]); 
		rotate([0,0,-30]) translate([wall_thickness/2+radius,0,0]) rotate([0,0,180]) tubesector(r=wall_thickness/2,wall=3,h=length,angle=180);
rotate([0,0,30]) translate([-wall_thickness/2-radius,0,0]) rotate([0,0,180]) tubesector(r=wall_thickness/2,wall=3,h=length,angle=180);
	

		// Holes
		m3_hole(12,radius+2,angle);
		m3_hole(22,radius+1,angle);
		m3_hole(32,radius,angle);
  		//recess_hole(x=length/2,diameter=8,radius=radius+9.1,angle=angle);

		// Slant to raise camera angle
		translate([-20,radius+wall_thickness+6,-5]) rotate([angle,0,0])cube([40,20,50]);


	}


}

// replay XD dia=28
// Exposure diablo and stick dia = 23.2
clamp(length=38, inner_diameter=27, angle = 5); 
//clamp(length=36.5, inner_diameter=15, angle = 10);
