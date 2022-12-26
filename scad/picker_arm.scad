include <libs/nutsnbolts/cyl_head_bolt.scad>;
include <libs/nutsnbolts/materials.scad>;
include <libs/utils.scad>;
include <libs/nwh_utils.scad>;


module arm(bl=30, bw=20, bh=30, tab=false, pullarm=true) {
    
    // Pull arm extending away for leverage
    if (pullarm) {
        translate([bl,0,0]) rotate([0,0,-30]) block(w=bw,l=bl*2,h=bh);   
    }
    
    translate([-bl,0,0]) block(w=bw,l=bl*2,h=bh);   
    translate([-bl,0,0]) rotate([0,0,150]) block(w=bw,l=bl,h=bh);   
    translate([-bl-(bl*cos(30)),bl*sin(30),0]) rotate([0,0,90]) block(w=bw,l=bl,h=bh);   
    translate([-bl-(bl*cos(30)),(bl*sin(30))+bl,0]) rotate([0,0,45]) block(w=bw,l=bl/2,h=bh);
    
    // Arm grabber end is flat
    translate([-bl-(bl*cos(30))+(bl/2*sin(45)),(bl*sin(30))+bl+(bl/2*sin(45)),bh/2]) rotate([0,0,45]) cube([bw,bw,bh],true);
    
    // A tab to attach to the main body
    if (tab) {
        rotate([0,0,-90]) block(w=bw,l=bl,h=bh);      
    }
        
}

module block(w=10,h=10,l=30) {
    hull() {
        
        cylinder(d=w,h=h);
        translate([l,0,0]) cylinder(d=w,h=h);
        
    }
}

bl=30;
bw=20;
bh=30;
tab=true; // attachment tab, or pull arm


difference() {
    
    // The arm
    arm(bl,bw,bh,tab,!tab);
    
    // Subtract a mirror and anything on pull arm
    translate([0,0,bh/2]) mirror([1,0,0]) arm(bl,bw,bh,tab,true);
    translate([0,-bl*4,bh/2]) cube([bl*10,bl*10,bh]);

    // pivot hole
    nut_and_hole(xlate=[0,0,0],type="M4",lh=bh,lx=0);

    if (tab) {
    
        // holes to attach to body
        nut_and_hole(xlate=[0,-bl+10,0],type="M4",lh=bh,lx=4);
        nut_and_hole(xlate=[0,-bl,0],type="M4",lh=bh,lx=4);
        
    } else {

        // pull hole on arm
        nut_and_hole(xlate=[bl+(2*bl*cos(30)),-(2*bl*sin(30)),0],type="M6",lh=bh+6,lx=0);
        
        // Hole to attach opener elastic via bolt or threaded through
        translate([-bl-(bl*cos(30)),bl*sin(30)]) nut_and_hole(xlate=[0,0,0],type="M4",lh=bh,lx=0);


    }
    
    // holes into the grab surface
    translate([-5-bl-(bl*cos(30))+(bl/2*sin(45)),(bl*sin(30))+bl+(bl/2*sin(45)),bh/2])
    rotate([-90,0,-45])
    nut_and_hole(xlate=[0,0,0],type="M3",lh=bh,lx=0);

    translate([5-bl-(bl*cos(30))+(bl/2*sin(45)),(bl*sin(30))+bl+(bl/2*sin(45)),bh*0.7])
    rotate([-90,0,-45])
    nut_and_hole(xlate=[0,0,0],type="M3",lh=bh,lx=0);

    translate([5-bl-(bl*cos(30))+(bl/2*sin(45)),(bl*sin(30))+bl+(bl/2*sin(45)),bh*0.3])
    rotate([-90,0,-45])
    nut_and_hole(xlate=[0,0,0],type="M3",lh=bh,lx=0);    
}





