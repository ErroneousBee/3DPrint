$fn=50;
include <libs/nutsnbolts/cyl_head_bolt.scad>;
include <libs/nutsnbolts/materials.scad>;
include <libs/nwh_utils.scad>;

mainw=15;
mainl=30;
mainh=10;

difference() {
    roundedRect([mainw,mainl,mainh], 5);
    translate([0,10,0]) cube([5,mainl-10,mainh]);
    translate([5,5,0])  roundedRect([1,mainl,mainh],1);
    
    translate([mainw-5,0,0]) cube([10,mainl-10,mainh]);
    translate([mainw-5,5,0]) cube([2,mainl-10,mainh]);

}


module bar_01() {
}

MODULE SPIRAL_DISKSPIRAL_DISK()    {
}