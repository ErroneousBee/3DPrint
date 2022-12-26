$fn=150;
include <libs/nutsnbolts/cyl_head_bolt.scad>;
include <libs/nutsnbolts/materials.scad>;
//include <libs/scad-lenbok-utils/utils.scad>;
include <libs/nwh_utils.scad>;

module tube(r=20,wall=3,h=5) {
	difference() {
		cylinder(r1=r+wall,r2=r+wall,h=h);
		cylinder(r1=r,r2=r,h=h);
	}
}

module tubesector(r=20,wall=3,h=5,angle=45) {
	cube_side=(wall+r)*2;
	difference() {
		tube(r=r,wall=wall,h=h);
		rotate([0,0,angle]) translate([-cube_side/2,0,0]) cube([cube_side,cube_side,h]);
		rotate([0,0,-angle]) translate([-cube_side/2,0,0]) cube([cube_side,cube_side,h]);
	}

}

// Block out the general shape.
module mainbody(inrad = 20,wall=5,height= 20,length=10, lugw=20) {

	// Main tube
	cylinder(r1=inrad+wall,r2=inrad+wall,h=height);	

	// Bendy bit
	translate([0,inrad,0]) cylinder(r1=6,r2=6,h=height);

	// Lug for rods
	translate([-r-wall,0,0])	cube([lugw,length,height]);

	// Lug for bolt clamp
	translate([-clampw/2,-clampl,0])	cube([clampw,clampl,height]);
}

// Block out the general shape. Upper peice
module mainbody_upper(inrad = 20,wall=5,height= 20,length=10, lugw=20) {

	// Main tube
	cylinder(r1=inrad+wall,r2=inrad+wall,h=height);	

	// Bendy bit
	translate([0,-inrad,0]) cylinder(r1=6,r2=6,h=height);

	// Lug
	translate([-r-wall,0,0])	cube([lugw,length,height]);

}

module roundel(l=40, r=3) {

	r2 = r*2;

	// Round the edge by 3
	rotate([-90,0,0]) rotate([0,90,0]) difference() {
		cylinder(r1=r2,r2=r2,h=l);
		cylinder(r1=r,r2=r,h=l);
		translate([-r2,0,0]) cube([r2*2,r2,l]);
		translate([0,-r2,0]) cube([r2,r2*2,l]);
	}

}


r = 39/2; 
h = 26;
wall=4;

l = 65; // lower bracket length
ul=150; // upper bracket length

angle1=12;
angle2=angle1+15;




rod_d=8.5; 
rod_r=rod_d/2+0.2; 	// rod radius with clearance
rod_insh=10; 			// height u rod inserts onto bottom bracket

lugw = rod_d+(wall*3);
clampw=20;
clampl=r+16;
slotw = 3;
connw = slotw-1;

module bolthole(l=10) {
	union() {
			hole_through(name="M4", l=l, cld=.5, h=0, hcl=0.5);
			hole_through(name="M4", l=0, cld=0, h=4, hcl=0.5);
			translate([0,0,-l+4]) nutcatch_parallel("M4",l=5);
	}
}

module lower_bracket() {
	difference() {
		mainbody(inrad=r,wall=wall,height=h,length=l,lugw=lugw);

		// Bendy bit
		translate([0,r,0]) cylinder(r1=4,r2=4,h=h+3);

		// Main tube and gripper instert
		cylinder(r1=r,r2=r,h=h);
		translate([0,0,h/4]) tube(r=r,wall=1,h=h/2,angle=0);

		// Slot
		translate([-slotw/2,-l,0])	cube([slotw,l,h]);

		// Round the edges
		translate([-r-wall, l-4	,h-4]) roundel(l=40,r=4);
		translate([clampw/2+0.5, -clampl+4	,h-4]) rotate([0,0,180]) roundel(l=clampw+1,r=4);

		// Round some verticle edges
		translate([clampw/2-4,-clampl+4,0]) rotate([0,270,180]) roundel(l=h,r=4);
		translate([-clampw/2+4,-clampl+4,0]) rotate([0,270,90]) roundel(l=h,r=4);
		translate([-r,l-4,0]) rotate([0,270,0]) roundel(l=h,r=4);
		translate([-r-wall+lugw-4,l-4,0]) rotate([0,270,-90]) roundel(l=h,r=4);

		// Bolt holes through clamp
		translate([-clampw/2-0.1,-r-8,h-7]) rotate([0,270,0])  bolthole(l=clampw);
		translate([-clampw/2-0.1,-r-8,7]) rotate([0,270,0])  bolthole(l=clampw);

		// rod inserts
		translate([-r-wall+(lugw/2),r+10,rod_insh]) rotate([-angle1,0,0]) cylinder(r1=rod_r,r2=rod_r,h=h);
		translate([-r-wall+(lugw/2),r+28,rod_insh]) rotate([-angle2,0,0]) cylinder(r1=rod_r,r2=rod_r,h=h);

	}	
}


mirror([1,0,0]) lower_bracket();














