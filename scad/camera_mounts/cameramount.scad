
module clamp(length,diameter) {
	xlate=36.5-length;
	radius=diameter/2;
	translate([xlate,15,22]) {
  
			difference(){
				union() {
					cylinder(h=length,r=radius+3,center=false);
					translate([-15,14,0]){
						cube([30,3,length]);
					}
				}

				cylinder(h=length,r=radius);
				translate([-20,-38,0]){
					cube([40,30,length]);
				}
			}

	
		
	}
}

clamp(36.5,27);
