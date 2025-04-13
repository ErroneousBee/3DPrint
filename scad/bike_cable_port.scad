$fn=32;

// Port, blank or multi hole for bicycle frame ( carbon fiber ).


// Measured dimensions
port_width=10;       // Width of port hole
port_length=25;     // Total length of hole
port_depth=2;       // Thickness of the frame wall
brake_hose_dia=6;  // Brake hose hole diameter
gear_outer_dia=4.8;    // Dropper / Gear cable sleeve diameter.


// Arbitrary dimensions
height_out=2;       // How far out it protrudes
height_in=3;       // How deep into the tube the plug goes
lip_r = 2;
lip_h = 1;
bump_r = 0.4;



// Calculated dimensions
radius_inner = port_width / 2;
inside_height = height_in + port_depth;
center_length = port_length - port_width;
lip_raise = inside_height - height_out;


// Blank port, then holes
difference() {
        port_blank();
        //rotate([-45,0,0]) translate([0,0,-50]) cylinder(h=100, d=brake_hose_dia);
        //rotate([-45,0,0]) translate([0,brake_hose_dia,-50]) cylinder(h=100, d=gear_outer_dia);
}

        


module port_blank() {
    
    // Inside the hole
    hull() {
        cylinder(  h=inside_height, r=radius_inner );
        translate([0, center_length , 0])   cylinder(  h=inside_height, r=radius_inner );
    }
        
    // Above, outside the hole
    translate([0,0, inside_height]) hull() {
        cylinder(  h=1, r=radius_inner +lip_r);
        translate([0, center_length , 0]) cylinder(  h=1, r=radius_inner +lip_r);
        cylinder(  h=height_out, r=radius_inner -lip_r);
        translate([0, center_length , 0]) cylinder(  h=height_out,  r=radius_inner -lip_r);
    }
    
    // small bumps to hold in place
    bump_h1 = height_in + 0.5;
    translate([radius_inner, 0 , bump_h1]) sphere(bump_r);
    translate([-radius_inner, 0 , bump_h1]) sphere(bump_r);
    translate([radius_inner, center_length , bump_h1]) sphere(bump_r);
    translate([-radius_inner, center_length , bump_h1]) sphere(bump_r);  
    translate([radius_inner, center_length*0.5 , bump_h1]) sphere(bump_r);
    translate([-radius_inner, center_length*0.5 , bump_h1]) sphere(bump_r);   
    translate([radius_inner, center_length*0.25, bump_h1]) sphere(bump_r);
    translate([-radius_inner, center_length*0.25 , bump_h1]) sphere(bump_r);  
    translate([radius_inner, center_length*0.75 , bump_h1]) sphere(bump_r);
    translate([-radius_inner, center_length*0.75 , bump_h1]) sphere(bump_r);
    
    translate([0, -radius_inner , bump_h1]) sphere(bump_r);
    translate([0, center_length + radius_inner , bump_h1]) sphere(bump_r);
    translate([radius_inner*sin(45), -radius_inner*sin(45) , bump_h1]) sphere(bump_r);
    translate([-radius_inner*sin(45), -radius_inner*sin(45) , bump_h1]) sphere(bump_r); 
    translate([radius_inner*sin(45), center_length + radius_inner*sin(45) , bump_h1]) sphere(bump_r);
    translate([-radius_inner*sin(45), center_length + radius_inner*sin(45) , bump_h1]) sphere(bump_r);


    
    bump_h2 = height_in/2;
    translate([radius_inner, 0 , bump_h2]) sphere(bump_r);
    translate([-radius_inner, 0 , bump_h2]) sphere(bump_r);
    translate([radius_inner, center_length , bump_h2]) sphere(bump_r);
    translate([-radius_inner, center_length , bump_h2]) sphere(bump_r);  
    translate([radius_inner, center_length/2 , bump_h2]) sphere(bump_r);
    translate([-radius_inner, center_length/2 , bump_h2]) sphere(bump_r);   
    translate([0, -radius_inner , bump_h2]) sphere(bump_r);
    translate([0, center_length + radius_inner , bump_h2]) sphere(bump_r);




  
    


}
