/**
 * Holder for Billhooks
 */
include <libs/nutsnbolts/cyl_head_bolt.scad>;
include <libs/nutsnbolts/materials.scad>;
include <libs/nwh_utils.scad>;
 
$fn=60;

// Measured 
//toolthickness = 3.5;
//toolhiltthickness = 5;
//toollength = 240;
//toolwidth = 130;
toolthickness = 3.5;
toolhiltthickness = 5;
toollength = 215;
toolwidth = 115;

// Derived/decided
wallh = 3;      // thin walls up against the blade
wallw = 8;      // walls round the outside, gives structure
totalh = 12;    // Enough space for the tool and the walls. Make this a metric bolt length for easy bolting
clearance = 2;  // Enough room for the tool to slide in down the sides
width=toolwidth + 2*(wallw + clearance);
length=toollength + 2*(wallw + clearance);



difference() {
    
    case();
    
    // Space for the tool
    tool();
    
    // A hole for attaching a belthook
    belthook_offset=10;
    translate([belthook_offset,20,0])  belthook_hole();
    translate([width-belthook_offset,20,0])  belthook_hole();
    translate([belthook_offset,60,0]) belthook_hole();
    translate([width-belthook_offset,60,0])  belthook_hole();
    
    // Screw it all together after printing
    boltholes();
    
    // Marker text
    translate([width/2, (length/2), totalh-0.5]) linear_extrude(height=totalh+2) 
        rotate([0,0,180]) text("A C G",32,"Liberation Sans", valign = "center", halign = "center");
    

    
    // Halver BOTTOM / TOP
    //translate([-1,-1,totalh/2]) cube([width+2,length+2,totalh]);
    //translate([-1,-1,-totalh/2]) cube([width+2,length+2,totalh]);
    
    // Lengther 1/3 and 2/3 BOT
    //translate([-1,length/3 -1]) cube([width+2,length,2*totalh]);
    //translate([-1,-length/3*2, -1]) cube([width+2,length,2*totalh]);

    // Lengther 1/3 and 2/3 TOP
    //translate([-1,-length/3, -1]) cube([width+2,length+2,2*totalh]);
    //translate([-1,length/3*2, -1]) cube([width+2,length+2,2*totalh]);
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
        trivet_grid(width-4,length-4,totalh/2 - toolthickness/2,grid=[12,0],bar=2);
    
    // 4 walls
    cube([width,wallw,totalh]);
    cube([wallw,length,totalh]);
    translate([width-wallw,0,0]) cube([wallw,length,totalh]);
    translate([0,length-wallw,0]) cube([width,wallw,totalh]);
    
}

// Basic shape of the billhook to make sure it slides into the case
module tool() {
    
    // Bulk of the Billhook
    translate([(width-toolwidth)/2,0,(totalh-toolthickness)/2]) cube([toolwidth, toollength, toolthickness]);
    
    // Blade thickens towards the handle
    translate([width/2,0,(totalh/2)]) resize([toolwidth,toollength/3,toolhiltthickness]) sphere(r=10);
    
}

module belthook_hole(size="M6") {
    
    translate([0,0,-1]) rotate([180,0,0]) hole_through(name=size, l=totalh+2, cld=0.1, h=0, hcld=0.2);
}

// bolt holes in the corners and sides for putting it together
module boltholes() {
    
    // Corner holes
    translate([wallw/2,wallw/2,0]) bolthole();
    translate([width - wallw/2,wallw/2,0]) bolthole();
    translate([wallw/2,length - wallw/2,0]) bolthole();
    translate([width - wallw/2,length - wallw/2,0]) bolthole();
    
    // End holes
    translate([width/2,length - wallw/2,0]) bolthole();

    // Side holes
    translate([wallw/2,5+length/3,0]) bolthole();
    translate([wallw/2,-5+length/3,0]) bolthole();
  
    translate([wallw/2,5+length/3*2,0]) bolthole(); 
    translate([wallw/2,-5+length/3*2,0]) bolthole();
    
    translate([width -wallw/2,5+length/3,0]) bolthole();
    translate([width -wallw/2,-5+length/3,0]) bolthole();
    
    translate([width -wallw/2,-5+length/3*2,0]) bolthole();
    translate([width -wallw/2,5+length/3*2,0]) bolthole();
}

module bolthole() {
    //nut_and_hole(xlate=[0,0,0],type="M3",catch_clearance=1,length=totalh, head_depth=3);
    countersink_with_nutcatch(type="M3", catch_clearance=1, length=totalh);    
}





