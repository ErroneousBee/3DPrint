$fn=180;
GOLDENRATIO = 1.618;

BASE_HEIGHT=20; // At least 10, more to move bulb to center of globe
BASE_RADIUS=58/2; // Measured
BASE_WALL=4;

GLOBE_RADIUS=50;
GLOBE_WALL=3;
GLOBE_SCALE=1.5;

SKIN_THICKNESS=0.4;

SHAPE_RADIUS=5;

BASE_OFFSET = sqrt( ( GLOBE_RADIUS * GLOBE_RADIUS ) - ( BASE_RADIUS * BASE_RADIUS ) );



// The main globe, with the base cut off and placed on the xy plane.
difference() {
    scale([1,1,GLOBE_SCALE]) translate([0,0,BASE_OFFSET]) mainshade();
    translate([0,0,-GLOBE_RADIUS]) cylinder(h=GLOBE_RADIUS, r=BASE_RADIUS, $fn=30);  
}

// Base, moved below the xy plane
difference() {
    translate([0,0,-BASE_HEIGHT]) cylinder(h=BASE_HEIGHT, r=BASE_RADIUS);  
    translate([0,0,-BASE_HEIGHT-1]) cylinder(h=BASE_HEIGHT+2, r=BASE_RADIUS-BASE_WALL);  
}
    


// A guide for a golfball sized bulb in roughly the right height from bottom of shade
//translate([100,0,100-BASE_HEIGHT]) sphere(15);


module mainshade() {
   
    N=200; // number of points to distribue

    // An array of shapes
    sides = rands(2,6.999,N+1);
   
    // height angle (given as multiple of PI) until which to distribute holes.
    max_height_angle = 1.7;
  
    difference() {
        sphere(GLOBE_RADIUS);
        sphere(GLOBE_RADIUS - GLOBE_WALL);
              
        // Holes all the way through
        for(i=[1:N]) {
            radius = GLOBE_RADIUS;
            theta = 360*i / GOLDENRATIO;  // (0..N*360°) / 1.618
            phi = acos(1 - max_height_angle*i/N);
            shape = sides[i] < 3 ? 30 : floor(sides[i]);
            rotate([0,phi,theta]) translate([0,0,GLOBE_RADIUS-GLOBE_WALL-1]) {
                cylinder(h=GLOBE_WALL+2, r=SHAPE_RADIUS, $fn=shape);
            }
        }
    }
    
    // Outer skin
    difference() {
        sphere(GLOBE_RADIUS);
        sphere(GLOBE_RADIUS - SKIN_THICKNESS);
    }
}
