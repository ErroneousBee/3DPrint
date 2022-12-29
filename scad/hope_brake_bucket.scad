$fn=50;
include <libs/nutsnbolts/cyl_head_bolt.scad>;
include <libs/nutsnbolts/materials.scad>;
include <libs/nwh_utils.scad>;


// Hope V4 Brake bleed bucket
// Sits on top of the resevoir, held on with silicon band ( less fuss than screwing it on )
// If you prefer screw holes, look at screw_sep and band_sep vars.

// Size of the flat base
mainw = 20;
mainl = 60;
mainh = 3;

// Size of the fill bucket
cylh=40; 
cylr=mainw/2;
baseh=8; // Height of the inside slope

screw_sep=39; // Distance between screw holes. Set to 0 ( zero ) for none
//screw_sep=0;
band_peg_sep=17; // Rubberband lugs for easy attach. Set to 0 ( zero ) for none
//band_peg_sep=0; 

difference() {
    body();
    color("red") hole();
    color("blue") screw_holes(); // Dont need screw holes, its easier to use a rubber band
}

/**
 * The main blank shape
 */
module body() {
    roundedRect([mainw,mainl,mainh], 2);
    translate([mainw/2,mainl/2,cylh/2 + mainh])  cylinder(h=cylh, r1=cylr, r2=cylr ,center=true);
    band_pegs();
}

/**
 * Hollow out the bucket and use a M5 hole in the bottom 
 * to keep resevoir topped up
 */
module hole() {
    translate([mainw/2, mainl/2, mainh+cylh]) hole_through(name="M5", l=mainh+cylh, cld=0, h=0, hcld=0);
    translate([mainw/2, mainl/2, 1])  cylinder(r1=2, r2=cylr-1, h=baseh);
    translate([mainw/2, mainl/2, 1+baseh+cylh/2]) cylinder(h=cylh, r1=cylr-1, r2=cylr-1, center=true); 
}

/**
 * Two screw holes with a bit of uncleared at thebottom to 
 * keep fluid in until broken through
 */
module screw_holes() {  
    hole_offset=mainl/2-screw_sep/2;
    hole_crust=0.5; // undrilled bit of hole, to allow non-screw use
    translate([mainw/2, hole_offset, mainh+hole_crust]) hole_through(name="M2", l=mainh-hole_crust, cld=0, h=0, hcld=0);
    translate([mainw/2, hole_offset+screw_sep, mainh+hole_crust]) hole_through(name="M2", l=mainh-hole_crust, cld=0, h=0, hcld=0);   
}

/**
 * four pegs for hooking bands over
 */
module band_pegs() {  
    module peg() {
        difference() {
            cylinder(h=5, r1=2, r2=3 ,center=false);
            translate([0,-4,0]) cube([8,8,5]);
        }     
    }
    peg_offset=mainl/2;
    translate([mainw,peg_offset+band_peg_sep,mainh-2])  peg();
    translate([mainw,peg_offset-band_peg_sep,mainh-2])  peg();
    translate([0,peg_offset+band_peg_sep,mainh-2])  rotate([0,0,180]) peg();
    translate([0,peg_offset-band_peg_sep,mainh-2])  rotate([0,0,180]) peg();
}






