// A small plug to go into the bottom of a stepladder

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

width=23;
length=30.2;
height=13; // Long side depth
height2=6.5; // short side depth
wall = 2; // wall thickness of the bit that inserts into the metal ladder
plugw=20; // Dimensions of the plug
plugl=28;
plugh=10;

module pluggy() {
	roundedRect([width,length,height],3);

	translate([(width-plugw)/2,(length-plugl)/2,0]) difference() {
		roundedRect([plugw,plugl,height+plugh],3);
		translate([wall,wall,0]) roundedRect([plugw-(wall*2),plugl-(wall*2),height+plugh],3);
	}	
}

deg = atan(height2/length);
difference() {
	rotate([-deg,0,0]) pluggy();
	translate([0,0,-height]) cube([width,length*2,height]);
	translate([((width-3)/2)+5,3,0]) cube([3,length-6,height2-3]);
	translate([((width-3)/2)-5,3,0]) cube([3,length-6,height2-3]);

}
