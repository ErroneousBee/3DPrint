$fn=32;

// Basic dimensions of the dish
width=90;
depth=80;
height=30;
wall=3;

// Inside and outside fillets of the dish
m_outer=5;
m_inner=10;

// Radius of handle style 1
r_handle=20;

// Height of the trivet from bottom of dish
h_trivet=15;

// A trivet that fits in the dish
difference() {
    translate([wall+2,wall+2,wall])
        trivet(width-(wall*2)-4,depth-(wall*2)-4,h_trivet-wall,grid=[15,19],bar=3);
    dish(width,depth,height,wall,m_inner,m_outer);
}


//// A dish with no handle ( e.g. soap dish
//dish(width,depth,height,wall,m_inner,m_outer);

//// A fat catcher dish, with a small handle
//translate([(width/2),r_handle/3,height*0.7])
//    handle_1(r_handle);
//dish(width,depth,height,wall,m_inner,m_outer);


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
module dish_block(w,d,h,r) {
    difference(){
        
        translate([r,r,r]) minkowski() {
            cube([w-r-r,d-r-r,h-r]);
            sphere(r=r);
        }
            
        
        translate([0,0,h])  cube([w,d,h]);
        
    }
}

/**
 * A peice to rest soap bars on, that can rest inside the dish
 */
module trivet(w,d,h,bar=2,grid=[12,12]) {
      
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
 * A rounded wall peice that we create the trivet from 
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

