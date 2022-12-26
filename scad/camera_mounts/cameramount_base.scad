include <libs/nutsnbolts/cyl_head_bolt.scad>;
include <libs/nutsnbolts/materials.scad>;
include <libs/utils.scad>;


module base(length,width,innerwidth) {
	cube([length,width,2.8]);
	translate([1.5,(width-innerwidth)/2,2.8]){
		cube([length-1.5,innerwidth,3]);
	}
}

module tab(centeron) {

	width=25.8;
	length=9;
	tablen=5;
	width_slot=4;
	indent=(centeron-width)/2;
	indentslot=(centeron-width_slot)/2;

	h1=1.5;
	h2=3.1;

	difference() {
	

		translate([-length,indent,0]) {
			cube([length,width,h1]);
			cube([tablen,width,h2]);	
		}

		translate([-length,indentslot,0]) {
			cube([length,width_slot,h2]);
 		}

	}

	
}

module slot(mainwidth,length,width,height,indent) {
	
	translate([4,indent,0]) {
		cube([length-8,width,height]);
	}

}

module m3_nut_and_hole(xlate=[0,0,0]) {
		translate(xlate) rotate([0,180,0]) {
		nutcatch_parallel("M3",l=5);
		hole_through(name="M3", l=50, cld=0.1, h=0, hcld=0.1);
	}
}
	

outer_width = 32;
inner_width = 28.3;
main_length = 36;
slot_width = 4;
fudge=0;

difference() {
	base(main_length,outer_width,inner_width);
	
	// back end corners off
	translate([38,0,0]) rotate([0,0,-20]) translate([-5,-15,0]) cube([10,30,10]);
	translate([38,outer_width,0]) rotate([0,0,20]) translate([-5,-15,0]) cube([10,30,10]);
	
	// Trim the front sides a smidge to make entry easier
	translate([10,-5,0])  rotate([0,0,85]) translate([-5,-15,0]) cube([10,30,10]);
	translate([10,outer_width+5,0])  rotate([0,0,95]) translate([-5,-15,0]) cube([10,30,10]);

	// underside slots
	slot(outer_width,main_length,slot_width,3,5);
	slot(outer_width,main_length,slot_width,3,outer_width-5-slot_width);
	
	// center bolt holes 10mm apart
	m3_nut_and_hole([8,outer_width/2,-1]); 
	m3_nut_and_hole([18,outer_width/2,-1]);
	m3_nut_and_hole([28,outer_width/2,-1]);


}
tab(outer_width);



