$fn=32;

// Basic dimensions of the big knife
blade_length=200;
blade_height=45;  // Depth of the biggest blade ( mine is 45mm )
handle_width=30;  // Handle width (23mm) plus a bit more
handle_height=30;  // Usedto calculate blade drop

// Small blade
small_height=20;  // general height
small_length=20;  // total length
small_blade_l=20; // length of longest small blade

width=handle_width*4;
length=250+100;
height=45+10;
slot=2; // Blade width, couple of mm.
wall=2; // End and base thickness

difference() {
    block(width,length,height);
    translate([-1,blade_length,blade_height-handle_height]) cube([width+2,length,height]);
    big_slots();
    

}

/**
 * A basic rectangular dish with fillets where walls join.
 */
module block(width,depth,height) {
    difference() {
        cube([width,depth,height]);
    }
}

module big_slots() {
    
    blade_depths=[45,20,20,20];
    
    for ( i=[0:3] ) {
        h=wall + blade_height - blade_depths[i];
        translate([(i * handle_width ) + handle_width/2, wall , h])
            slot(length,slot,height);
    }

}

module slot(l,w,h) {
    difference() {
        translate([0,l/2,h/2]) cube([w,l,h],center=true);
        rotate([0,20,0]) translate([w/2,l/2-1,h/2]) cube([w,l+3,h],center=true);
        rotate([0,-20,0]) translate([-w/2,l/2-1,h/2]) cube([w,l+3,h],center=true);
    }
}
    
    
