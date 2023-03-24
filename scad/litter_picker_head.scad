$fn=50;
include <libs/nutsnbolts/cyl_head_bolt.scad>;
include <libs/nutsnbolts/materials.scad>;
include <libs/nwh_utils.scad>;


// Size of the internal slot
mainw = 12;
mainl = 40;

// wall size of external body
wall=6;

// gripper
studw=6;
studh=3;
studl=7;

// Hook
hookw=3;
hookh=(mainw/2)-wall/2;
hookr=5;
hookr_hook=30;

difference() {
    union() {
        body();
        translate([0,2,0]) gripper();
        translate([20,20,0]) grip_surface();
        //translate([9,23,-5]) rotate([0,90,0]) translate([-40,0,0]) hook(hookw,hookh,hookr,hookr_hook);
    }
    hole();
}





/**
 * The main blank shape
 */
module body() {
        roundedRect([mainw+wall,mainw+wall,mainl], 5);
}

module hole() {
    translate([wall/2,wall/2,wall]) roundedRect([mainw,mainw,mainl], 2);   
}

// gripper
module gripper() {
    
    translate([0,wall/2,1]) rotate([90,0,0]) roundedRect([studw,studh,studl], 2);
    translate([mainw,wall/2,1]) rotate([90,0,0]) roundedRect([studw,studh,studl], 2);

    translate([0,wall/2,8]) rotate([90,0,0]) roundedRect([studw,studh,studl], 2);
    translate([mainw,wall/2,8]) rotate([90,0,0]) roundedRect([studw,studh,studl], 2);  

    translate([0,wall/2,16]) rotate([90,0,0]) roundedRect([studw,studh,studl], 2);
    translate([mainw,wall/2,16]) rotate([90,0,0]) roundedRect([studw,studh,studl], 2);     
}

module hook(w,h,r,r_hook) {
        
    block=h+h+r+r;
     
    difference() {
        hook_plain(w,h,r,r_hook);
        translate([-h-12,3,-block/2]) rotate([0,0,45]) cube([block,block,block]);
    }
    
    
}

module hook_plain(w,h,r,r_hook) {
        
    translate([0,r_hook-(r_hook/3),0]) rotate([0,0,90]) rotate_extrude(angle=90, convexity=10) 
        translate([r_hook/3,0,0] )
        hull() {
            translate([0,h]) circle(r);
            translate([0,-h]) circle(r);
        }
        
    translate([r_hook,0,0]) rotate([90,0,0]) linear_extrude(height = 10, convexity = 10) hull() {
        translate([0,h]) circle(r);
        translate([0,-h]) circle(r);
    }
     
    rotate_extrude(angle=90, convexity=10) 
        translate([r_hook,0,0] )
        hull() {
            translate([0,h]) circle(r);
            translate([0,-h]) circle(r);
        };
}

module grip_surface() {
    
    fontsize=5;
    
    translate([-6,-3.5,15]) rotate([90,0,180]) linear_extrude(2) scale([1/3,1/3,1/3]) {
        for ( i = [0:5] ) {
            translate([i*fontsize + (2/fontsize),0,0]) text("A",fontsize);
            translate([i*fontsize,-fontsize,0]) text("C",fontsize);
            translate([i*fontsize,-fontsize*2-(2/fontsize),0]) text("G",fontsize);
   
            translate([i*fontsize + (2/fontsize),-fontsize*3,0]) text("A",fontsize);
            translate([i*fontsize,-fontsize*4,0]) text("C",fontsize);
            translate([i*fontsize,-fontsize*5-(2/fontsize),0]) text("G",fontsize);  
   
            translate([i*fontsize + (2/fontsize),-fontsize*6,0]) text("A",fontsize);
            translate([i*fontsize,-fontsize*7,0]) text("C",fontsize);
            translate([i*fontsize,-fontsize*8-(2/fontsize),0]) text("G",fontsize);
        }
    }   
}




