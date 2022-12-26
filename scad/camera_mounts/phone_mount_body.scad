$fn=150;
include <nutsnbolts/cyl_head_bolt.scad>;
include <nutsnbolts/materials.scad>;
include <libs/utils.scad>;
include <libs/nwh_utils.scad>;

// Phone
pl = 150;
pw = 78;
ph = 9.5;

// main bracket
mb_l = 50;
mb_wall = 4;
overhang = 4;
round_r=3;

bandlug_w=4;
bandlug_off = (pw/2)-8;

bufferslot_w = 10;


// Block out the general shape.
module mainbody_rough() {

    w = pw+mb_wall+mb_wall;
    l = mb_l;
    h = ph+mb_wall+mb_wall;

    // block bigger than phone, then cut phone sized hole, and a smaller slot. 
	translate([-w/2,-l/2,-h/2]) {
        difference() {
            cube([w,l,h]);
           	translate([mb_wall,-1,mb_wall]) cube([pw,l+2,ph]);
           	translate([mb_wall+overhang,-1,mb_wall]) cube([pw-overhang-overhang,l+2,ph+mb_wall+1]);
        }
    }
    
}

// A sort of thing where bands can be put.
module bandlug() {
    
    difference() {
        translate([-bandlug_w/2,-mb_l/2,-bandlug_w]) cube([bandlug_w,mb_l,bandlug_w]);
        translate([-1-bandlug_w/2,-1-mb_l/2,-bandlug_w/2]) cube([1+bandlug_w/2,mb_l+2,bandlug_w/2]);
    }
}

// To cut a slot for the buffer to run in.
module bufferslot() {    
   translate([-bufferslot_w/2,-mb_l,(-ph/2)-bufferslot_w-mb_wall+1]) cube([bufferslot_w,mb_l,bufferslot_w]);
   translate([0,-mb_l/4,-1]) m3_hole(-0.1-ph/2,0,270);
}

// To cut a slot for the buffer to run in.
module buffer() {    

   //translate([-bufferslot_w/2,-mb_l,(-ph/2)-bufferslot_w-mb_wall+1])    
    
   cube([bufferslot_w,mb_wall,ph+overhang]);

  difference() { 
    cube([bufferslot_w,mb_l,mb_wall+2]);
    nut_and_hole(xlate=[bufferslot_w/2,mb_l-8,-1],lx=5,type="M3");
    nut_and_hole(xlate=[bufferslot_w/2,mb_l-16,-1],lx=5,type="M3");
    nut_and_hole(xlate=[bufferslot_w/2,mb_l-24,-1],lx=5,type="M3");
   }
}

module mainbody() {
    
    h_offset = mb_wall+(ph/2);
    

    
    difference() {
        mainbody_rough();
        translate([mb_wall+(pw/2),0,-h_offset]) corner_rounder(l=mb_l+2,r=round_r,align="y",quadrant=1);
        translate([-mb_wall-(pw/2),0,-h_offset]) corner_rounder(l=mb_l+2,r=round_r,align="y",quadrant=0);
        translate([-mb_wall-(pw/2),0,h_offset]) corner_rounder(l=mb_l+2,r=round_r,align="y",quadrant=3);
        translate([mb_wall+(pw/2),0,h_offset]) corner_rounder(l=mb_l+2,r=round_r,align="y",quadrant=2);
        translate([(pw/2)-overhang,0,h_offset]) corner_rounder(l=mb_l+2,r=round_r,align="y",quadrant=3);
        translate([-(pw/2)+overhang,0,h_offset]) corner_rounder(l=mb_l+2,r=round_r,align="y",quadrant=2);
    }

    // Lower roundings
    translate([-(pw/2),0,-ph/2]) corner_rounder(l=mb_l,r=3,align="y",quadrant=0);
    translate([(pw/2),0,-ph/2]) corner_rounder(l=mb_l,r=3,align="y",quadrant=1);
    
    // Upper roundings
    translate([-(pw/2),0,ph/2]) corner_rounder(l=mb_l,r=2,align="y",quadrant=3);
    translate([(pw/2),0,ph/2]) corner_rounder(l=mb_l,r=2,align="y",quadrant=2);
    
    // Rails for putting bands on
    //translate([bandlug_off,0,(-ph/2)-mb_wall]) rotate([0,0,180]) bandlug();
    //translate([-bandlug_off,0,(-ph/2)-mb_wall]) bandlug();


}


// Cross of 5 screwholes to mount to the other parts
module screwholes() {
    m3_hole(-0.1-ph/2,0,270);
    m3_hole(-0.1-ph/2,-15,270);
    m3_hole(-0.1-ph/2,15,270);
}

difference() {
    mainbody();
    
    // Lines of 3 screwholes
    translate([0,0,0]) rotate([0,0,0]) screwholes();
    translate([15,0,0]) rotate([0,0,90]) screwholes();
    
    //translate([25,0,0]) bufferslot();
    //translate([-25,0,0]) bufferslot();
    
    // Cut slot for bands
    translate([(pw/2)-6,mb_l/2,-2-ph/2])  cube([4,6,6],center=true); 
    translate([-(pw/2)+6,mb_l/2,-2-ph/2])  cube([4,6,6],center=true); 
    translate([(pw/2)-6,-mb_l/2,-2-ph/2])  cube([4,6,6],center=true); 
    translate([-(pw/2)+6,-mb_l/2,-2-ph/2])  cube([4,6,6],center=true); 
}

// Round the slots
translate([(pw/2)-6,mb_l/2-3,-2-ph/2])  rotate([0,90,0]) cylinder(r1=mb_wall/2,r2=mb_wall/2,h=10,center=true);
translate([-(pw/2)+6,mb_l/2-3,-2-ph/2])  rotate([0,90,0]) cylinder(r1=mb_wall/2,r2=mb_wall/2,h=10,center=true);
translate([(pw/2)-6,-mb_l/2+3,-2-ph/2])  rotate([0,90,0]) cylinder(r1=mb_wall/2,r2=mb_wall/2,h=10,center=true);
translate([-(pw/2)+6,-mb_l/2+3,-2-ph/2])  rotate([0,90,0]) cylinder(r1=mb_wall/2,r2=mb_wall/2,h=10,center=true);


