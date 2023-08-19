$fn=120;
r1=58/2;

r2=15;

difference() {
    union() {
        cylinder(10,r1,r1);
        translate([0,0,10]) cylinder(80,r1,r1+r2);
        translate([0,0,90]) cylinder(80,r1+r2,r1);
    }
    
    #scale([0.9,0.9,1]) {
        cylinder(10,r1,r1);
        translate([0,0,10]) cylinder(80,r1,r1+r2);
        translate([0,0,90]) cylinder(80,r1+r2,r1);
    }
 

}
