$fn=32;

// Parameterised dish and trivet, for creating dishes/pots of various use, such as:
// Soap dish
// Cress growing
// Plant pot
// Drip catcher for countertop grills
// Pen holder

// Basic dimensions of the dish
width=100;
depth=70;
height=20;
wall=3;

// Inside and outside fillets of the dish
m_outer=10;
m_inner=8;

// Radius of handle style 1
r_handle=20;

// Height of the trivet from bottom of dish
h_trivet=10;



// A dish with no handle ( e.g. soap dish ) 
// dish(width,depth,height,wall,m_inner,m_outer);


//translate([wall+2,wall+2,0])
//    trivet_grid_holder( width-(wall*2)-4, depth-(wall*2)-4, wall+8, grid=[15,19], bar=3);
    
// A trivet that fits in the dish
//difference() {
//    translate([wall+2,wall+2,wall])
//        trivet_grid(width-(wall*2)-4,depth-(wall*2)-4,h_trivet-wall,grid=[17,17],bar=3);
//    dish(width,depth,height,wall,m_inner,m_outer);
//}



//// A fat catcher dish, with a small handle
//translate([(width/2),r_handle/3,height*0.7])
//    handle_1(r_handle);
//dish(width,depth,height,wall,m_inner,m_outer);

// Plant or pen holder.
//dish(100,100,100,2,10,5);

// Cress grower, use a paper towel over the grid
//dish(50,50,40,2,10,5);

// Grid for cress grower
//trivet_grid(35,35,7,bar=1,grid=[6.5,6.5]);

glass_inner();


/**
 * A semicircular handle with a bit of an undercut
 */
module handle_1(r) {
    
    minkowski() {
        difference() {
            cylinder(3,r,r);
            cylinder(3,r,0);
            translate([-r,-r/3,0]) cube([r*2,r*2,3]);
        }
        sphere(r=1);
    }
    
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
module dish_block(w,d,h,fillet=1) {
    // TODO: warn when width/depth are too small to support fillet
    difference() {   
        translate([fillet,fillet,fillet]) minkowski() {
            cube([w-fillet-fillet,d-fillet-fillet,h-fillet]);
            sphere(r=fillet);
        } 
        translate([0,0,h]) cube([w,d,h]);
    }
}

/**
 * A grid to rest soap bars on, that can rest inside the dish. 
 * Suggested use is to use difference() with the container its in.
 * @parm w width of trivet in mm
 * @parm d depth or length in mm
 * @parm h height of bars in mm
 * @parm bar width of an individual bar  in mm
 * @parm grid[x,y] size of a single cell in the grid in mm
 */
module trivet_grid(w,d,h,bar=2,grid=[12,12]) {
      
    // How many bars on the x and y axes
    xbars=abs(w/(2*grid[0]));
    ybars=abs(d/(2*grid[1]));
   
    for ( i=[0:xbars]) {
            translate([w/2-(bar/2)+(i*grid[0]),0,0]) rounded_bar([bar,d,h]);
            translate([w/2-(bar/2)-(i*grid[0]),0,0]) rounded_bar([bar,d,h]);
    }
        for ( i=[0:ybars]) {
            translate([0,d/2-(bar/2)+(i*grid[1]),0]) rounded_bar([w,bar,h]);
            translate([0,d/2-(bar/2)-(i*grid[1]),0]) rounded_bar([w,bar,h]);
    }
    
}

/**
 * A mesh grid on legs to go in bottom of pot. 
 * @parm w width of trivet in mm
 * @parm d depth or length in mm
 * @parm h height of bars in mm. Caller is under an obligation to difference() the dish 
 *         so that the trivet fits in the dish bottom
 * @parm bar width of an individual bar  in mm
 * @parm grid[x,y] number of bars in each direction
 */
module trivet_mesh(w,d,h,bar=2,grid=[12,12]) {
    
    module bar(l,r) {
        cylinder(l,r,r,center=false);
        translate([0,0,0]) sphere(r);
        translate([0,0,l]) sphere(r);
    }
        
      
    // How many bars on the x and y axes
    x_gap=w/(grid[0]-1);
    y_gap=d/(grid[1]-1);
   
    for ( i=[0:x_gap:w] ) {
            translate([i,0,0]) rotate([270,0,0]) bar(d,bar/2);
    }
    for ( i=[0:y_gap:d] ) {
        translate([0,i,0]) rotate([0,90,0]) bar(w,bar/2);
    }
    
    for ( i=[1:grid[0]-2] ) {
        #for ( j=[1:grid[1]-2] ) {
            hull() {
                translate([(i*x_gap)-3,(j*y_gap),0]) bar(h,bar/2);
                translate([(i*x_gap)+3,(j*y_gap),0]) bar(h,bar/2);
            }
            hull() {
                translate([(i*x_gap),(j*y_gap)-3,0]) bar(h,bar/2);
                translate([(i*x_gap),(j*y_gap)+3,0]) bar(h,bar/2);
            }
            
        }
    }
    
}

/**
 * Four pegs in the base of the dish, to stop the trivet rising when the soap is lifted.
 * @parm w width of trivet in mm
 * @parm d depth or length in mm
 * @parm h height of bars in mm. Caller is under an obligation to difference() the dish 
 *         so that the trivet fits in the dish bottom
 * @parm bar width of an individual bar  in mm
 * @parm grid[x,y] size of a single cell in the grid in mm
 */
module trivet_grid_holder(w,d,h,bar=2,grid=[12,12]) {
    
    xbars=abs(w/(2*grid[0]));
    ybars=abs(d/(2*grid[1]));
    
    x1=(w/2) - (1*grid[0]) + bar/2;
    y1=(d/2) - (1*grid[1]) + bar/2;
    x2=(w/2) + (1*grid[0]) - bar/2*3;
    y2=(d/2) + (1*grid[1]) - bar/2*3;
      
    translate([x1,y1,0]) rounded_bar([bar,bar,h]);
    translate([x1,y2,0]) rounded_bar([bar,bar,h]);
    translate([x2,y1,0]) rounded_bar([bar,bar,h]);
    translate([x2,y2,0]) rounded_bar([bar,bar,h]);
}

/**
 * A rounded wall peice that we use to create the trivet and holder pegs. 
 */
module rounded_bar(dim) {
    w=dim[0];
    d=dim[1];
    h=dim[2];
    
    r=(min(w,d)/2);
    tx=( w<d ) ? r : w-r;
    ty=( w<d ) ? d-r : r;
    
    hull() {
        translate([r,r,0]) {
            cylinder(r1=r,r2=r,h=h-r);
            translate([0,0,h-r]) sphere(r=r);
        }
        translate([tx,ty,0]) {
            cylinder(r1=r,r2=r,h=h-r);
            translate([0,0,h-r]) sphere(r=r);
        }
    }
}

/**
 * A shape representing the inside of a glass grower that just needs a trivet
 */
module glass_inner() {
    
    r1 = 15;
    d1 = 20;
    
    minkr = 2;
    
    minkowski() {
        difference() {
               square([20,20],center=true);
               #translate([d1,0,0]) circle(r1);
               #translate([-d1,0,0]) circle(r1);
               #translate([0,d1,0]) circle(r1);
               #translate([0,-d1,0]) circle(r1);
        }
            
        circle(minkr);
    }
    
    
    
}

