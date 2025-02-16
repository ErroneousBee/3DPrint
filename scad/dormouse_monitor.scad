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
ply_height=15;  // Thickness of plywood sheet
acgtext="Ashplats Conservation Group"; // Also adds roughness to the surface

// Arbitrary dimensions
depth=40;       // How deep into the tube the inktray goes
height=3;       // Thickness of the ink tray
wall=1;         // Ink tray wall thickness 
base_d=15;      // How 'deep' the base plate non-dish part is

// Inside and outside fillets of the dish
m_outer=1;
m_inner=2;

// Clip dimentions
clip_w=5;       // Width of clip side wall
clip_top=10;    // Height of top clippy part of clip
clip_bot=height+ply_height;


// The upper plate and its clip ( comment one out )
top_plate();
//clip();


module clip() {
    
    // Base
    translate([-clip_w,0,0]) cube([dia_inner+clip_w+clip_w,base_d,height]);
    translate([dia_inner/2,base_d/2,3]) color("red") linear_extrude(height=0.2) 
        text(acgtext,3,"Liberation Sans", valign = "center", halign = "center");
    
    // 2 side clips
    translate([0,0,0]) clip_side();
    translate([dia_inner,0,0]) mirror([1,0,0]) clip_side();

}

module clip_side() {

    // Post
    translate([-clip_w,0,0]) 
        cube([clip_w,base_d,height+ply_height+clip_top]);
    translate([-(clip_w/2),0,height+ply_height+clip_top]) rotate([270,0,0]) 
        cylinder(base_d,clip_w/2,clip_w/2);
    
    // Clip part 15deg slope and the indent tp catch on top plate
    translate([0,0,clip_top+height+ply_height]) 
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

