$fn=60;
GOLDENRATIO = 1.618;

difference() {
    mainshade();
    translate([0,0,-31]) cylinder(h=14, r=19, $fn=60);

}




module mainshade() {
    translate([0,0,-30]) cylinder(h=10, r=20, $fn=60);
    
    N=200; // number of points to distribue
    sides = rands(2,6.999,N+1);
  

    resize([60,60,60]) {
      difference() {
        sphere(10);
        sphere(9.9);
    
        // height angle (given as multiple of PI) until which to distribute holes.
        max_height_angle = 1.5;
        for(i=[0:N]) {
          radius = 10 - 2;
          theta = 360*i / GOLDENRATIO;  // (0..N*360°) / 1.618
          phi = acos(1 - max_height_angle*i/N);
          // translate (theta, phi, r) to cartesian coords
          xi = cos(theta)*sin(phi) * radius;
          yi = sin(theta)*sin(phi) * radius;
          zi = cos(phi) * radius;
          shape = sides[i] < 3 ? 30 : floor(sides[i]);
          translate([xi,yi,zi]) rotate([0,phi,theta]) cylinder(h=2, r=0.5, $fn=shape);
        }
      }
    }
}