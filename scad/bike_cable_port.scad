$fn=32;

// Port, blank or multi hole for bicycle frame ( carbon fiber ).


// Measured dimensions
port_width      = 9;    // Width of port hole
port_length     = 24;   // Total length of hole
port_depth      = 2;    // Thickness of the frame wall
brake_hose_dia  = 6;    // Brake hose hole diameter
gear_dia        = 4.8;  // Dropper / Gear cable sleeve diameter.

// Arbitrary dimensions
height_in   = 1.5;      // How deep into the tube the plug goes
lip_r       = 2;        // Lip overhang.
lip_h1      = 1;        // Lip height straight
lip_h2      = 1;        // Lip height taper
cable_len   = 100;      // Cable/hose length for cutting holes in the grommet.
cable_angle = -50;       // entry angle of canbles, shallow as possible
dropper_offset = -0.3;    // Moves cable hole up and down the slot
hose_offset = brake_hose_dia+3; // Moves brake hose hole up and down the slot
grommet_r   = 1;
grommet_h   = 1;

slot_w      = 0.8;      // The slot we can cut into it to make insertion easier

// Calculated dimensions
radius_inner = port_width / 2;
inside_height = height_in + port_depth;
total_height = height_in + port_depth + lip_h1 + lip_h2;
center_length = port_length - port_width;


// Blank port, then holes
difference() {
    port_blank();
        
    // Dropper cable hole
    translate([0,dropper_offset,0]) rotate([cable_angle,0,0]) translate([0,0,-cable_len/2]) cylinder(h=cable_len, d=gear_dia);
    
    // Brake hose hole
    translate([0,hose_offset,0]) rotate([cable_angle,0,0]) translate([0,0,-cable_len/2]) cylinder(h=cable_len, d=brake_hose_dia);
    
    // A slot for the brake hose, dont have to dissassemble the brake to install.
    translate([0,port_length - (port_width/2) ,0]) rotate([-45,0,0]) cube([slot_w, port_width, total_height*3], center=true);

}

        


module port_blank() {
    
    // Inside the hole
    hull() {
        cylinder(  h=inside_height, r=radius_inner );
        translate([0, center_length , 0])   cylinder(  h=inside_height, r=radius_inner );
    }  
   
//    // Dropper cable protruding bit to hold into place
//    dropper_outer = gear_dia+4;
//    dropper_outer_l = center_length*0.8;
//    difference() {
//        translate([0,dropper_offset,0]) rotate([cable_angle,0,0]) translate([0,0,-dropper_outer_l/2])  cylinder(h=dropper_outer_l, d=dropper_outer);
//        translate([-dropper_outer/2,-1,inside_height]) cube([dropper_outer,dropper_outer,dropper_outer]);
//    } 
//    
//    // brake hose protruding bit unecessarily
//    hose_outer = brake_hose_dia+2;
//    hose_outer_l = center_length*0.8;
//    difference() {
//        translate([0,hose_offset,0]) rotate([cable_angle,0,0]) translate([0,0,-hose_outer_l/2])  cylinder(h=hose_outer_l, d=hose_outer);
//        translate([-hose_outer/2,hose_offset,inside_height]) cube([hose_outer,hose_outer,hose_outer]);
//    } 
        
    // Above, outside the hole
    translate([0,0, inside_height]) hull() {
        cylinder(  h=lip_h2, r=radius_inner +lip_r);
        translate([0, center_length , 0]) cylinder(  h=lip_h2, r=radius_inner +lip_r);

        cylinder(  h=lip_h2 + lip_h1, r=radius_inner -lip_r);
        translate([0, center_length , 0]) cylinder(  h=lip_h2 + lip_h1,  r=radius_inner -lip_r);
    }
    
    // small bumps to hold in place
    //bump_ring( bump_r , height_in - bump_r);
    
    translate([0,0,0]) grommet_ring( grommet_r , grommet_h);

}

// A ring of bumps of the insert to hold it in place
module grommet_ring(ring_r,height) {
    
    translate([0,center_length, height]) rotate_extrude(convexity = 10, angle=180, $fn = 100)
        translate([port_width/2, 0, 0]) circle(r = ring_r, $fn = 100);
    
    translate([0,0, height]) rotate_extrude(convexity = 10, angle=180, $fn = 100)
        translate([-port_width/2, 0, 0]) circle(r = ring_r, $fn = 100);
    
    translate([port_width/2,0,ring_r]) rotate([-90,0,0]) linear_extrude(center_length) circle(r = ring_r, $fn = 100);   
   
    translate([-port_width/2,0,ring_r]) rotate([-90,0,0]) linear_extrude(center_length) circle(r = ring_r, $fn = 100);
    
    
    
    
}

// A ring of bumps of the insert to hold it in place
module bump_ring(bump_r,bump_h) {
    
    // Sides
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
    
    // Ends
    translate([0, -radius_inner , bump_h]) sphere(bump_r);
    //translate([0, center_length + radius_inner , bump_h]) sphere(bump_r);
    
    // 45 deg ends
    translate([radius_inner*sin(45), -radius_inner*sin(45) , bump_h]) sphere(bump_r);
    translate([-radius_inner*sin(45), -radius_inner*sin(45) , bump_h]) sphere(bump_r); 
    translate([radius_inner*sin(45), center_length + radius_inner*sin(45) , bump_h]) sphere(bump_r);
    translate([-radius_inner*sin(45), center_length + radius_inner*sin(45) , bump_h]) sphere(bump_r);
    
    // 20 degrees
    translate([radius_inner*sin(20), center_length + radius_inner*cos(20) , bump_h]) sphere(bump_r);
    translate([-radius_inner*sin(20), center_length + radius_inner*cos(20) , bump_h]) sphere(bump_r);
    translate([radius_inner*sin(20), -radius_inner*cos(20) , bump_h]) sphere(bump_r);
    translate([-radius_inner*sin(20), -radius_inner*cos(20) , bump_h]) sphere(bump_r);
}
