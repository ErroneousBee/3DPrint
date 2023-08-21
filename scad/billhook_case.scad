/**
 * Holder for Billhooks
 */
include <libs/nutsnbolts/cyl_head_bolt.scad>;
include <libs/nutsnbolts/materials.scad>;
include <libs/nwh_utils.scad>;
 
$fn=60;

// Measured 
toolthickness = 4;
toollength = 240;
toolwidth = 130;

// Derived/decided
wallh = 3;
wallw = 8;
totalh = 16;
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
    translate([width/2,length - wallw/2,0]) nut_and_hole(xlate=[0,0,0],type="M3",catch_clearance=1,length=totalh, head_depth=3);

    // Side holes
    translate([wallw/2,5+length/3,0]) nut_and_hole(xlate=[0,0,0],type="M3",catch_clearance=1,length=totalh, head_depth=3);   
    translate([wallw/2,-5+length/3,0]) nut_and_hole(xlate=[0,0,0],type="M3",catch_clearance=1,length=totalh, head_depth=3);
  
    translate([wallw/2,5+length/3*2,0]) nut_and_hole(xlate=[0,0,0],type="M3",catch_clearance=1,length=totalh, head_depth=3);  
    translate([wallw/2,-5+length/3*2,0]) nut_and_hole(xlate=[0,0,0],type="M3",catch_clearance=1,length=totalh, head_depth=3);
    
    translate([width -wallw/2,5+length/3,0]) nut_and_hole(xlate=[0,0,0],type="M3",catch_clearance=1,length=totalh, head_depth=3);   
    translate([width -wallw/2,-5+length/3,0]) nut_and_hole(xlate=[0,0,0],type="M3",catch_clearance=1,length=totalh, head_depth=3);
    
    translate([width -wallw/2,-5+length/3*2,0]) nut_and_hole(xlate=[0,0,0],type="M3",catch_clearance=1,length=totalh, head_depth=3);
    translate([width -wallw/2,5+length/3*2,0]) nut_and_hole(xlate=[0,0,0],type="M3",catch_clearance=1,length=totalh, head_depth=3);
    
    // Halver BOTTOM / TOP
    //translate([-1,-1,totalh/2]) cube([width+2,length+2,totalh]);
    translate([-1,-1,-totalh/2]) cube([width+2,length+2,totalh]);
    
    // Lengther 1/3 and 2/3 BOT
    //translate([-1,length/3 -1]) cube([width+2,length,2*totalh]);
    //translate([-1,-length/3*2, -1]) cube([width+2,length,2*totalh]);

    // Lengther 1/3 and 2/3 TOP
    //translate([-1,length/3*2, -1]) cube([width+2,length+2,2*totalh]);
    translate([-1,-length/3, -1]) cube([width+2,length+2,2*totalh]);
}


// Solid case, we will subtract the tool part elsewhare
module case() {
    
    // Bottom part
    cube([width,length,wallh]);

    // Top part
    translate([0,0,totalh-wallh]) cube([width,length,wallh]);
    
    // internal grid
    translate([0,2,0]) 
        trivet_grid(width-4,length-4,totalh/2 - toolthickness/2,grid=[12,0],bar=2);
    translate([width,2,totalh]) rotate([0,180,0])
        trivet_grid(width-4,length-4,totalh/2 - toolthickness/2,grid=[20,0],bar=2);
    
    // 4 walls
    cube([width,wallw,totalh]);
    cube([wallw,length,totalh]);
    translate([width-wallw,0,0]) cube([wallw,length,totalh]);
    translate([0,length-wallw,0]) cube([width,wallw,totalh]);
    
}

module tool() {
    cube([toolwidth, toollength, toolthickness]);
}



