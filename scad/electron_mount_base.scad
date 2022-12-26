// Adapts a Hope bike light to an Electron Nano 9 bar mount.
$fn=50;
include <nutsnbolts/cyl_head_bolt.scad>;
include <nutsnbolts/materials.scad>;
include <libs/utils.scad>;
include <libs/nwh_utils.scad>;

module head_and_hole(xlate=[0,0,0],type="M5") {
	translate(xlate) rotate([0,180,0]) {
			hole_through(name=type, l=50, cl=0.1, h=6, hcl=0.1);
	}
}

module roundedRect(size, r) {

	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z) hull() {
    	// place 4 circles in the corners, with the given radius
    	translate([r,r,0])     circle(r=r);
    	translate([r,y-r,0])   circle(r=r);
    	translate([x-r,y-r,0]) circle(r=r);
    	translate([x-r,r,0])   circle(r=r);

	}

}

module body () {
	roundedRect([mainw,mainl,8], 2);
	translate([(mainw-topw)/2,0,mainh+sloth]) roundedRect([topw,topl,5], 2);
	translate([(mainw-topw)/2,slotl,0]) roundedRect([topw,topl-slotl,mainh+sloth], 2);
}



sloth = 2.7;
slotl = 43.3-1.5;
middw = 9.35;

mainw = 13.5;
mainl = 60;
mainh = 2.5;

slotw = (mainw-middw)/2;

topw = 18;
topl = 60;

pitw=8;
pitl=4.1;
pith=1.5;

rotate([180,0,0]) difference() {

	body();

	// Side slots
	translate([0,0,2.51]) cube([slotw,slotl,sloth]);	
	translate([mainw-slotw,0,2.51]) cube([slotw,slotl,sloth]);

	// Pit
	translate([(mainw-pitw)/2,1.7,0]) cube([pitw,pitl,pith]);

	// Small M3 hole and nut trap in case you fancy doing extra bolty things
	nut_and_hole(xlate=[mainw/2,18,-0.01],type="M3",lx=6);
	nut_and_hole(xlate=[mainw/2,33,-0.01],type="M3",lx=6);
	nut_and_hole(xlate=[mainw/2,48,-0.01],type="M3",lx=6);

	// Where the Hope light screws to the bracket
	//head_and_hole(xlate=[mainw/2,49,-0.01],type="M5");

}