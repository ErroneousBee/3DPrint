/**
 * Fits over the end of a Harris paint pole to convert it into a clothes line prop.
 */
 
$fn=180;
innerwidth_base=23/2;
innerwidth_top=20/2;
wall=6;
base_height=60;
fork_height=20;
slot_width=(innerwidth_base+wall)/2;



module base(length, innerwidth_base, innerwidth_top, wall) {
    
    difference() {
	cylinder(length,innerwidth_base+wall,innerwidth_base+wall);
    cylinder(length,innerwidth_base,innerwidth_top);

    }

}

module fork(base,height,slot_width) {

    difference() {
        
        // Extend the base
        cylinder(height,base,base);
        
        // Cut a slot and round
        translate([-base/4, -base, (height/2) +1]) {
            cube([slot_width, base*3, height]);           
        }
        translate([0,base+1,height/2]) rotate([90,0,0]) cylinder(base*3,slot_width/2,slot_width/2);

        translate([0,-base,height-12])  rotate([0,-45,0])  cube([base,base*3,base]); 
    }
    
    
}

base(base_height,innerwidth_base,innerwidth_top,wall);

translate([0,0,base_height]) {
    fork(innerwidth_base+wall,fork_height, slot_width);
}

