$fn=32;

// Basic dimensions of the dish
width=90;
depth=80;
height=20;
wall=3;

// Inside and outside fillets
m_outer=5;
m_inner=10;

// Radius of handle style 1
r_handle=20;

trivet(width,depth,5);
//translate([(width/2),r_handle/3,height*0.7])
//    handle_1(r_handle);


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

module dish() {
    difference() {
        dish_block(width,depth,height,m_outer);
        i_w=width-wall-wall;
        d_w=depth-wall-wall;
        translate([wall,wall,wall]) dish_block(i_w,d_w,height,m_inner);
    }
}

module dish_block(w,d,h,r) {
    difference(){
        
        translate([r,r,r]) minkowski() {
            cube([w-r-r,d-r-r,h-r]);
            sphere(r=r);
        }
            
        
        translate([0,0,h])  cube([w,d,h]);
        
    }
}

module trivet(w,d,h) {
    r=10;
    s=r+1;
    
    bar=2;
    
   
    minkowski() {
        {
            for ( i=[1:5] ) {
                translate([i*s,0,0]) cube([bar,d,bar]);
            }
    
            for ( i=[1:5] ) {
                translate([0, i*s,0]) cube([d, bar,bar]);
            }
        }
        sphere(r=1);
    }
    
    

}

