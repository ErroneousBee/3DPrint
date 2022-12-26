include <libs/nutsnbolts/cyl_head_bolt.scad>;
include <libs/nutsnbolts/materials.scad>;

module countersink(r1,r2) {

	cylinder(r2,r1,r2);
	translate([0,0,-r1]) cylinder(r1,r1,r1);
}

module m3_hole(x=12,radius) {
		translate([0,radius,x]) {
		 	//rotate([270,0,0]) countersink(r1=2.75, r2=1.5, h1=1.5, h2=1.5);
		 	rotate([270,0,0]) countersink(r1=2.75, r2=1.5);

			rotate([90,0,0]) hole_through(name="M3", l=30, cl=0.1, h=0, hcl=0.1);	
		}
}



module clamp(length=30,inner_diameter=27,wall_thickness=3) {
	wall_thickness = 3;
	base_width = 32;
	xlate=36.5-length;
	radius=inner_diameter/2;
	translate([xlate,15,22]) {
  
			difference(){
				union() {
					cylinder(h=length,r=radius+wall_thickness);
					translate([-base_width/2,radius+1,0]){
						cube([base_width,3,length]);
					}
				}

				cylinder(h=length,r=radius);
				translate([-20,-1-radius*2.5,0]) cube([40,inner_diameter,length]); 

				m3_hole(12,radius);
				m3_hole(22,radius);
				m3_hole(32,radius);

			}


	}
}


clamp(length=36.5, inner_diameter=23.4);
