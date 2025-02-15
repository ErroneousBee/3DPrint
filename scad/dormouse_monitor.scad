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

top_plate();

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

