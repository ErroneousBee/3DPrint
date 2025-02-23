$fn=32;

// Parameterised dish and trivet, for creating dishes/pots of various use, such as:
// Soap dish
// Cress growing
// Plant pot
// Drip catcher for countertop grills
// Pen holder

// Measured dimensions of the tube and plywood
dia_inner=61;   // Inner size of square drainpipe
dia_outer=66;   // Outer size of square drainpipe
plywood=15;     // Thickness of plywood sheet
hardboard=4;    // Thickness of hardboard sheet
acgtext="Ashplats Conservation Group"; // Also adds roughness to the surface

// Arbitrary/derived dimensions
pipewall= (dia_outer - dia_inner)/2; // Drainpipe wall thickness
depth=40;           // How deep into the tube the inktray goes
height=3;           // Thickness of the ink tray and 
wall=1;             // Ink tray wall thickness 
base_d=15;          // How 'deep' the base plate non-dish part is
prot_r=3;           // Radius of protrusion holding the board to the bottom of the tube
prot_l=6;          // Length of protrusion ( How much it overhangs, not entire length ) 

// Inside and outside fillets of the ink tray
m_outer=1;
m_inner=2;

// Clip dimensions
clip_w=3;       // Width of clip side wall
clip_top=10;    // Height of top clippy part of clip

// The upper plate and its clip ( comment one out )
//top_plate();
clip(hardboard);


module clip(board_height) {
    
    // Base
    translate([-clip_w,0,0]) cube([dia_inner+clip_w+clip_w, base_d, pipewall]);
    
    // Writing on the base
    translate([dia_inner/2,base_d/2,pipewall]) color("red") linear_extrude(height=0.2) 
        text(acgtext,3,"Liberation Sans", valign = "center", halign = "center");
    
    // 2 side clips
    translate([0,0,0]) clip_side(board_height + height);
    translate([dia_inner,0,0]) mirror([1,0,0]) clip_side(board_height + height);
    
    #translate([(dia_outer-5)/2, base_d - prot_l ,0]) clip_protrusion(prot_l , prot_r);

}

// Protrusion to hold the whole assembly onto the drainpipe
module clip_protrusion(length, radius) {
    scale([1,length/radius,1]) translate([0,radius,0]) difference() {
          sphere(r=radius);
          translate([-radius,-radius,0]) cube([radius*2,radius*2,radius+1]) ;
    }
}

module clip_side(board_height) {

    // Post
    translate([-clip_w,0,0]) 
        cube([clip_w,base_d,pipewall+board_height+clip_top]);
    translate([-(clip_w/2),0,pipewall+board_height+clip_top]) rotate([270,0,0]) 
        cylinder(base_d,clip_w/2,clip_w/2);
    
    // Clip part 15deg slope and the indent tp catch on top plate
    translate([0,0,clip_top+pipewall+board_height]) 
    difference() {
        translate([0,0,-clip_top]) cube([clip_w,base_d,clip_top]);
        rotate([0,-15,0])  translate([0,-1,-clip_top*1.5]) cube([clip_w,base_d+2,clip_top*1.5]);
       
        // Inverse of the lug on the top plate
        translate([1,1,-clip_top]) rotate([270,0,0]) cylinder(base_d-2,1,1);

    }
    
}
    
    


module top_plate() {
 
    dish(dia_inner,depth,height,wall,m_inner,m_outer);
    translate([0,-base_d+m_inner,0]) cube([dia_inner,base_d,height]);


    // Lugs the clip hooks over
    translate([1,1,3]) rotate([90,0,0]) cylinder(base_d-2,1,1);
    translate([dia_inner-1,1,3]) rotate([90,0,0]) cylinder(base_d-2,1,1);

    // Text
    translate([dia_inner/2,-base_d/2,3]) color("red") linear_extrude(height=0.4) 
        text(acgtext,3,"Liberation Sans", valign = "center", halign = "center");

}







/**
 * A basic rectangular dish with fillets where walls join.
 */
module dish(width,depth,height,wall,fillet_inner,fillet_outer) {
    difference() {
        dish_block(width,depth,height,fillet_outer);
        i_w=width-wall-wall;
        d_w=depth-wall-wall;
        translate([wall,wall,wall]) dish_block(i_w,d_w,height,fillet_inner);
    }
}

/**
 * Utility to create a block for the dish, we subtract outer from inner in dish()
 */
module dish_block(w,d,h,r) {
    difference(){
        
        translate([r,r,r]) minkowski() {
            cube([w-r-r,d-r-r,h-r]);
            sphere(r=r);
        }       
        translate([0,0,h])  cube([w,d,h]);
        
    }
}

