$fn=50;
include <nutsnbolts/cyl_head_bolt.scad>;
include <nutsnbolts/materials.scad>;
include <libs/utils.scad>;

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
	translate([0,-inrad,0]) cylinder(r1=6,r2=6,h=height);

	// Lug
	translate([-lugw/2,0,0])	cube([lugw,length,height]);

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


r = 27.2/2; 
h = 30;
l = 40;
wall=3;
slotw = 8;
connw = slotw-1;
lugw = r+wall+6;

module lug_chunk(width=10,length=40,h=40) {
	union() {
		rotate([0,0,-60]) cube([width*2,width*2,h]);
		cube([width*2,length,h]);
	}
}

module bolthole(l=10) {
	union() {
			hole_through(name="M4", l=l, cld=.5, h=0, hcl=0.5);
			hole_through(name="M4", l=0, cld=0, h=4, hcl=0.5);
			translate([0,0,-l+4]) nutcatch_parallel("M4",l=5);
	}
}

module bracket() {
	difference() {
		mainbody(inrad=r,wall=wall,height=h,length=l,lugw=lugw);
		cylinder(r1=r,r2=r,h=h);
		translate([0,-r,0]) cylinder(r1=4,r2=4,h=h+3);

		// Inner hollow to put a gripper in
		translate([0,0,h/4]) tube(r=r,wall=1,h=h/2,angle=0);

		// Slot
		translate([-slotw/2,0,0])	cube([slotw,l,h]);

		// Round the edge
		translate([-20,40-4	,h-4]) roundel(l=40,r=4);

		// Holes  through
		translate([lugw/2,l-10,h-8]) rotate([0,90,0])  bolthole(l=lugw);
		translate([lugw/2,l-10,8]) rotate([0,90,0])  bolthole(l=lugw);

	}	
}



module connector() {
	difference() {
		translate([0,l-20,0]) union() {
			translate([-connw/2,0,0]) cube([connw,80,h]);
			translate([-10,20,0]) cube([20,60,h]);
		}

	translate([l/2,l-10,h-8]) rotate([0,90,0]) hole_through(name="M4", l=l, cld=.5, h=0, hcl=0.5);
	translate([l/2,l-10,8]) rotate([0,90,0]) hole_through(name="M4", l=l, cld=.5, h=0, hcl=0.5);
	}
}

bracket();
connector();















