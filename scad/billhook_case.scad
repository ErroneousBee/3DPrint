/**
 * Holder for Billhooks
 */
include <libs/nutsnbolts/cyl_head_bolt.scad>;
include <libs/nutsnbolts/materials.scad>;
include <libs/nwh_utils.scad>;
 
$fn=180;

// Measured 
toolthickness = 4;
toollength = 300;
toolwidth = 200;

// Derived/decided
wallh = 5;
wallw = 10;
totalh = 20;
clearance = 3;
width=toolwidth + 2*(wallw + clearance);
length=toollength + 2*(wallw + clearance);



difference() {
    
    case();
    
    // Space for the tool
    translate([(width-toolwidth)/2,0,(totalh-toolthickness)/2]) tool();
    
    // Marker text
    translate([width/2, 40 ,totalh-0.5]) linear_extrude(height=0.5) 
        rotate([0,0,180]) text("A C G",32,"Liberation Sans", valign = "center", halign = "center");
    
    // Corner holes
    translate([wallw/2,wallw/2,0]) nut_and_hole(xlate=[0,0,0],type="M3",catch_clearance=1,length=totalh, head_depth=3);
    translate([width - wallw/2,wallw/2,0]) nut_and_hole(xlate=[0,0,0],type="M3",catch_clearance=1,length=totalh, head_depth=3);
    translate([wallw/2,length - wallw/2,0]) nut_and_hole(xlate=[0,0,0],type="M3",catch_clearance=1,length=totalh, head_depth=3);
    translate([width - wallw/2,length - wallw/2,0]) nut_and_hole(xlate=[0,0,0],type="M3",catch_clearance=1,length=totalh, 
    head_depth=3);
    
    // End holes
    #translate([width/2,length - wallw/2,0]) nut_and_hole(xlate=[0,0,0],type="M3",catch_clearance=1,length=totalh, head_depth=3);

    // Side holes
    translate([wallw/2,length/3,0]) nut_and_hole(xlate=[0,0,0],type="M3",catch_clearance=1,length=totalh, head_depth=3);
    translate([wallw/2,length/3*2,0]) nut_and_hole(xlate=[0,0,0],type="M3",catch_clearance=1,length=totalh, head_depth=3);
    translate([width -wallw/2,length/3,0]) nut_and_hole(xlate=[0,0,0],type="M3",catch_clearance=1,length=totalh, head_depth=3);
    translate([width -wallw/2,length/3*2,0]) nut_and_hole(xlate=[0,0,0],type="M3",catch_clearance=1,length=totalh, head_depth=3);
    
    // Halver
    // translate([-1,-1,totalh/2]) cube([width+2,length+2,totalh]);
    translate([-1,-1,-totalh/2]) cube([width+2,length+2,totalh]);
}


// Solid case, we will subtract the tool part elsewhare
module case() {
    
    // Bottom part
    cube([width,length,wallh]);

    // Top part
    translate([0,0,totalh-wallh]) cube([width,length,wallh]);
    
    // internal grid
    trivet_grid(width,length,totalh/2 - toolthickness/2,grid=[12,12],bar=5);
    translate([width,0,totalh]) rotate([0,180,0]) trivet_grid(width,length,totalh/2 - toolthickness/2,grid=[12,12],bar=5);

    // 4 walls
    cube([width,wallw,totalh]);
    cube([wallw,length,totalh]);
    translate([width-wallw,0,0]) cube([wallw,length,totalh]);
    translate([0,length-wallw,0]) cube([width,wallw,totalh]);
    
}

module tool() {
    cube([toolwidth, toollength, toolthickness]);
}



