// For mounting a plaster skull onto a jingle stick.
d_inner=23;
d_outer=30;
height=50;
h_base=4;
wall=5;
h_cut=height-15;

r_inner=d_inner/2;
r_outer=d_outer/2;
r_base=r_outer+15;

    
cut_cube=60;


module inside(r=20,h=20) {
	cylinder(r1=r-1,r2=r,h=h);
	translate([0,0,h]) sphere(r=r);
}

module top_chop(r=20,h=20) {
	difference() {
		cylinder(r1=r,r2=r,h=r);
		sphere(r=r);
		translate([0,0,-r]) cylinder(r1=r,r2=r,h=r);
	}
}

difference() {

    
	union() {
		
		// Mian body
		cylinder(r1=r_outer,r2=r_outer,h=height+r_outer+5);

		// Base and curve in to body	
		cylinder(r1=r_base,r2=r_base,h=h_base);	
		translate([0,0,h_base]) cylinder(r1=r_outer+1,r2=r_outer,h=2);
		translate([0,0,h_base]) cylinder(r1=r_outer+3,r2=r_outer,h=1);

		// sticky outy bit to grip inside
		translate([0,0,h_base+7.5]) cylinder(r1=r_outer+4,r2=r_inner,h=20);
		translate([0,0,h_base+4.5]) cylinder(r1=r_inner,r2=r_outer+4,h=3);
	}
	
	// Hollow out
	inside(r=r_inner,h=height);

	// Rount off the top
	translate([0,0,height+5])	top_chop(r=r_outer);

	// Cut away the legs
	translate([6,6,0])  cube([cut_cube,cut_cube,h_cut]);
	translate([6,-66,0])  cube([cut_cube,cut_cube,h_cut]);
	translate([-66,6,0])  cube([cut_cube,cut_cube,h_cut]);
	translate([-66,-66,0])  cube([cut_cube,cut_cube,h_cut]);
	rotate([0,0,45]) cube([8,70,2*h_cut],center=true);
	rotate([0,0,-45]) cube([8,70,2*h_cut],center=true);
    translate([-8,-8,h_cut]) rotate([90,0,-45]) cylinder(r1=1,r2=8,h=22,center=true);
    translate([8,-8,h_cut]) rotate([90,0,45]) cylinder(r1=1,r2=8,h=22,center=true);
    translate([8,8,h_cut]) rotate([90,0,135]) cylinder(r1=1,r2=8,h=22,center=true);
    translate([-8,8,h_cut]) rotate([90,0,-135]) cylinder(r1=1,r2=8,h=22,center=true);

	//translate([0,0,h_cut]) rotate([90,0,-45]) cylinder(r1=4,r2=4,h=70,center=true);
	//translate([0,0,h_cut]) rotate([90,0,45]) cylinder(r1=4,r2=4,h=70,center=true);

	//cube([50,50,400]);
}

//translate([8,8,h_cut]) rotate([90,0,135]) cylinder(r1=1,r2=8,h=20,center=true);




