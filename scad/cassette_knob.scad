include <nutsnbolts/cyl_head_bolt.scad>;
include <nutsnbolts/materials.scad>;
include <libs/utils.scad>;

// size is the XY plane size, height in Z
module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}

r1=9.8/2;
l1=12;

r2=7/2;
l2=20;

r3=6/2;
ltot=47.5;
l3= ltot-l1-l2;
offset=(6-4.3);

module body() {
	cylinder(r1=r1,r2=r1,h=l1);
	translate([0,0,l1]) cylinder(r1=r2,r2=r2,h=l2);
	translate([0,0,l1+l2]) cylinder(r1=r3,r2=r3,h=l3);
}

difference() {
	body();
	translate([0,0,5]) hexagon(6,10);
	translate([0,0,9.8]) cylinder(r1=3.2,r2=0.1,h=6);
	translate([-10,offset,ltot-13]) cube([20,20,13]);

}


