
r1=20;
r2=6;
wall1=2.5;
wall2=3;

h1=15;
h2=10;
h3=20;

translate([0,0,h3]) {
    difference() {
        cylinder(r1=r1,r2=r2,h=h1);
        cylinder(r1=r1-wall2,r2=r2-wall2,h=h1);
    }
    translate([0,0,h1]) difference() {
        cylinder(r1=r2,r2=r2,h=h2);
        cylinder(r1=r2-wall1,r2=r2-wall1,h=h2);
    }
}
difference() {
    cylinder(r1=r1,r2=r1,h=h3);
    cylinder(r1=r1-wall2,r2=r1-wall2,h=h3);
}

