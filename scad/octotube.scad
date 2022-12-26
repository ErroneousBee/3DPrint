// An attempt at a hoctagonal tin whistle
module octocyl(r=5,length=60) {

	xd=2*sqrt(r*r/2);

	difference() {


		translate([-r,-r,0]) cube([2*r,2*r,length]);



		translate([xd,xd,0])   rotate([0,0,45]) translate([-r,-r,0]) cube([2*r,2*r,length]);
		translate([-xd,-xd,0]) rotate([0,0,45]) translate([-r,-r,0]) cube([2*r,2*r,length]);
		translate([-xd,xd,0])  rotate([0,0,45]) translate([-r,-r,0]) cube([2*r,2*r,length]);
		translate([xd,-xd,0])  rotate([0,0,45]) translate([-r,-r,0]) cube([2*r,2*r,length]);
	}
}

module octotube(r1=5, r2=4,length=60) {

	difference() {
		octocyl(r1,length);
		octocyl(r2,length);
	}

}

	
module bottom(length) {
	translate([-80,0,0]) difference() {
		octotube(r1=20,r2=14,length=l);
		translate([0,0,l-10]) octotube(r1=17,r2=14,length=l);
	}
}
 	
module middle(length) {

	translate([-180,0,0]) difference() {
		octotube(r1=20,r2=14,length=l);
		translate([0,0,l-10]) octotube(r1=20,r2=17,length=l);
	}
}


module fipbase(radius,length) {
	difference() {

		union() {
			//octotube(r1=radius,r2=radius-2,length=20);
			translate([0,0,0]) octotube(r1=radius,r2=radius-2,length=length+20);
		
			// backstop and mouthpeice 
			translate([0,0,length]) octocyl(r=radius,length=30);
			
			//windhole extrude
			translate([-(radius)/2,-radius+1.5,0]) cube([radius,radius/5,length]);	 	}

		// Windhole
		translate([-(radius-1)/2,-radius+2,0]) cube([radius-1,radius/5,100]);

		// Mouthpeice cutaway
		translate([-30,-3,length+20]) cube([60,60,60]);
		translate([-30,12,length+20]) rotate([0,90,0]) cylinder(r=15,h=60);  
		translate([-30,41,length+20]) rotate([45,0,0]) cube([60,60,60]);


	}
}

module hole(r) {
	width=r-1;
	translate([-width/2,-30,-10]) difference() {
		rotate([-25,0,0]) cube([width,10,25]);
		translate([0,0,18]) cube([width,20,10]);
	}
}

module brace(r) {
	width=3/2*r;	
	c1 = sqrt(2*r*r);

	difference() {
		translate([0,2,r/2]) rotate([180,0,0]) difference() {
			cube([width,r,r],center=true);
			translate([0,r/2,r/2]) rotate([45,0,0]) cube([width,c1,c1],center=true);
		}
		octotube(r2=r,r1=r+2,length=r);
	}
}


l=95;
r=8;
//bottom(l);
//middle(l);
difference() {
	fipbase(r,20);
	translate([0,6,15]) hole(r);
	translate([0,-100,0]) cube([200,200,200]);
}


translate([0,0,12]) brace(r);




		
