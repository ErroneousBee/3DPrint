$fn=32;

// Parameterised dish and trivet, for creating dishes/pots of various use, such as:
// Soap dish
// Cress growing
// Plant pot
// Drip catcher for countertop grills
// Pen holder

// Measured dimensions of the tube and plywood
dia_inner=61;
dia_outer=66;
ply_height=11;

// Arbitrary dimensions
depth=40;
height=3;
wall=1;

// Inside and outside fillets of the dish
m_outer=1;
m_inner=2;

// How much we overhang on the side.
xshift = (dia_outer - dia_inner) /2;

// Clip dimentions
clip_w=5;       // Width of clip side wall
clip_top=10;    // Height of top clippy part of clip
clip_bot=height+ply_height;


// The upper plate and its clip ( comment one out )
top_plate();
clip();


module clip() {
    
    // Base
    translate([-xshift-clip_w,0,0]) cube([dia_outer+clip_w+clip_w,10,height]);
    translate([30,4,3]) color("red") linear_extrude(height=0.2) 
        text("Ashplats Conservation Group",3.5,"Liberation Sans", valign = "center", halign = "center");
    
    // 2 side clips
    translate([-xshift,0,0]) clip_side();
    translate([dia_inner+xshift,0,0]) mirror([1,0,0]) clip_side();

}

module clip_side() {

    // Post
    translate([-clip_w,0,0]) 
        cube([clip_w,10,height+ply_height+clip_top]);
    translate([-(clip_w/2),0,height+ply_height+clip_top]) rotate([270,0,0]) 
        cylinder(10,clip_w/2,clip_w/2);
    
    // Clip part 15deg slope and the indent tp catch on top plate
    translate([0,0,clip_top+height+ply_height]) 
    difference() {
        translate([0,0,-clip_top]) cube([clip_w,10,clip_top]);
        rotate([0,-15,0])  translate([0,-1,-clip_top*1.5]) cube([clip_w,12,clip_top*1.5]);
       
        // Inverse of the lug on the top plate
        translate([1,1,-clip_top]) rotate([270,0,0]) cylinder(8,1,1);

    }
    
}
    
    


module top_plate() {
 
    dish(dia_inner,depth,height,wall,m_inner,m_outer);
    translate([-xshift,-8,0]) cube([dia_outer,10,height]);


    // Lugs the clip hooks over
    translate([-xshift+1,1,3]) rotate([90,0,0]) cylinder(8,1,1);
    translate([dia_inner+xshift-1,1,3]) rotate([90,0,0]) cylinder(8,1,1);

    // Text
    translate([30,-4,3]) color("red") linear_extrude(height=0.4) 
        text("Ashplats Conservation Group",3,"Liberation Sans", valign = "center", halign = "center");

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

