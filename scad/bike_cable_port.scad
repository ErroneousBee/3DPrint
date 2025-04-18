$fn=32;

// Port, blank or multi hole for bicycle frame ( carbon fiber ).


// Measured dimensions
port_width      = 9;    // Width of port hole
port_length     = 25;   // Total length of hole
port_depth      = 2;    // Thickness of the frame wall
brake_hose_dia  = 6;    // Brake hose hole diameter
gear_dia        = 4.8;  // Dropper / Gear cable sleeve diameter.


// Arbitrary dimensions
height_in   = 1.5;      // How deep into the tube the plug goes
lip_r       = 2;        // Lip overhang.
lip_h1      = 1;        // Lip height straight
lip_h2      = 1;        // Lip height taper
bump_r      = 0.6;      // retention bump radius
cable_len   = 100;      // Cable/hose length for cutting holes in the grommet.
slot_w      = 1;        // The slot we can cut into it to make insertion easier


// Calculated dimensions
radius_inner = port_width / 2;
inside_height = height_in + port_depth;
total_height = height_in + port_depth + lip_h1 + lip_h2;
center_length = port_length - port_width;


// Blank port, then holes
difference() {
    port_blank();
        
    // Dropper cable
    rotate([-45,0,0]) translate([0,0,-cable_len/2]) cylinder(h=100, d=gear_dia);
    
    // Brake hose hole
    rotate([-45,0,0]) translate([0,brake_hose_dia+2,-cable_len/2]) cylinder(h=cable_len, d=brake_hose_dia);
    
    // A slot for the brake hose, dont have to dissassemble the brake to install.
    //translate([0,port_length - (port_width/2) ,0]) rotate([-45,0,0]) cube([brake_hose_dia-2, port_width, total_height*3], center=true);
    
    // A long slot for the brake hose, for easier insertion
    translate([-slot_w/2,3 ,-5])  cube([slot_w, port_length, total_height*3]);

}

        


module port_blank() {
    
    // Inside the hole
    hull() {
        cylinder(  h=inside_height, r=radius_inner );
        translate([0, center_length , 0])   cylinder(  h=inside_height, r=radius_inner );
    }   
        
    // Above, outside the hole
    translate([0,0, inside_height]) hull() {
        cylinder(  h=lip_h2, r=radius_inner +lip_r);
        translate([0, center_length , 0]) cylinder(  h=lip_h2, r=radius_inner +lip_r);

        cylinder(  h=lip_h2 + lip_h1, r=radius_inner -lip_r);
        translate([0, center_length , 0]) cylinder(  h=lip_h2 + lip_h1,  r=radius_inner -lip_r);
    }
    
    // small bumps to hold in place
    bump_ring( bump_r , height_in - bump_r);
    bump_ring( bump_r , bump_r);

}

module bump_ring(bump_r,bump_h) {
    translate([radius_inner, 0 , bump_h]) sphere(bump_r);
    translate([-radius_inner, 0 , bump_h]) sphere(bump_r);
    translate([radius_inner, center_length , bump_h]) sphere(bump_r);
    translate([-radius_inner, center_length , bump_h]) sphere(bump_r);  
    translate([radius_inner, center_length*0.5 , bump_h]) sphere(bump_r);
    translate([-radius_inner, center_length*0.5 , bump_h]) sphere(bump_r);   
    translate([radius_inner, center_length*0.25, bump_h]) sphere(bump_r);
    translate([-radius_inner, center_length*0.25 , bump_h]) sphere(bump_r);  
    translate([radius_inner, center_length*0.75 , bump_h]) sphere(bump_r);
    translate([-radius_inner, center_length*0.75 , bump_h]) sphere(bump_r);
    
    translate([0, -radius_inner , bump_h]) sphere(bump_r);
    translate([0, center_length + radius_inner , bump_h]) sphere(bump_r);
    translate([radius_inner*sin(45), -radius_inner*sin(45) , bump_h]) sphere(bump_r);
    translate([-radius_inner*sin(45), -radius_inner*sin(45) , bump_h]) sphere(bump_r); 
    translate([radius_inner*sin(45), center_length + radius_inner*sin(45) , bump_h]) sphere(bump_r);
    translate([-radius_inner*sin(45), center_length + radius_inner*sin(45) , bump_h]) sphere(bump_r);
}
