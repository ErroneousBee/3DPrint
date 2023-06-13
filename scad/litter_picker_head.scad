$fn=50;
include <libs/nutsnbolts/cyl_head_bolt.scad>;
include <libs/nutsnbolts/materials.scad>;
include <libs/nwh_utils.scad>;


// Size of the internal slot
innerw = 12.2;
outerw = 13+6;
mainl = 40;
wall = (outerw-innerw)/2;

// gripper studs
studw=5;
studh=3;
studl=7;

// Slidy slot for hooks, prongs, etc
dock_inner_w=8;
dock_inner_d=3;
dock_wall = 2;
dock_slot_w=4;
dock_outer_w = dock_inner_w+ dock_wall+dock_wall;
dock_outer_d = dock_inner_d+ dock_wall+dock_wall;

// Hook
hookw=3;
hookh=(innerw/2)-3;
hookr=5;
hookr_hook=30;

difference() {
    union() {
        body();
        
        translate([0,5,0]) gripper_1();
        translate([0,6,studh]) gripper_2();
        
        translate([-1,0,0]) rotate([0,0,90]) gripper_1();
        translate([-2,0,studh]) rotate([0,0,90]) gripper_2();

        translate([dock_outer_d + outerw -dock_wall,dock_outer_w + (outerw/2) - (dock_outer_w/2) ,0]) rotate([0,0,180]) dock();
        translate([21,21,0]) grip_surface();

        //translate([9,23,-5]) rotate([0,90,0]) translate([-40,0,0]) hook(hookw,hookh,hookr,hookr_hook);
    }
    hole();
}
dimples();


//hook();






/**
 * The main blank shape
 */
module body() {
        roundedRect([outerw,outerw,mainl], 5);
}

module hole() {
    translate([wall,wall,wall]) roundedRect([innerw,innerw,mainl], 2);   
}

// interlocking studs in a row as a gripping surface
module gripper_1() {
    
    off=outerw-studw;
    
    translate([0,0,1]) rotate([90,0,0]) roundedRect([studw,studh,studl], 2);
    translate([off,0,1]) rotate([90,0,0]) roundedRect([studw,studh,studl], 2);

    translate([0,0,8]) rotate([90,0,0]) roundedRect([studw,studh,studl], 2);
    translate([off,0,8]) rotate([90,0,0]) roundedRect([studw,studh,studl], 2);  

    translate([0,0,16]) rotate([90,0,0]) roundedRect([studw,studh,studl], 2);
    translate([off,0,16]) rotate([90,0,0]) roundedRect([studw,studh,studl], 2);     
}

module gripper_2() {
    off = (outerw-studw)/2;
    translate([off,0,1]) rotate([90,0,0]) roundedRect([studw,studh,studl], 2);
    translate([off,0,8]) rotate([90,0,0]) roundedRect([studw,studh,studl], 2);
    translate([off,0,16]) rotate([90,0,0]) roundedRect([studw,studh,studl], 2);
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

// Plain of raised text as a rough surface
module grip_surface() {
    
    fontsize=8;
    
    translate([-6,-3.5,23]) rotate([90,0,180]) linear_extrude(2) scale([1/3,1/3,1/3]) {
        for ( i = [0:3] ) {
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

// Some traction pimples for holding us onto the stick
module dimples() {
   
    plink_r=1;
    translate([wall-(plink_r/2),outerw/2,wall+10]) sphere(plink_r);
    translate([wall-(plink_r/2),outerw/2,wall+20]) sphere(plink_r);
    translate([wall-(plink_r/2),outerw/2,wall+30]) sphere(plink_r);

    translate([outerw/2,wall-(plink_r/2),wall+10]) sphere(plink_r);
    translate([outerw/2,wall-(plink_r/2),wall+20]) sphere(plink_r);
    translate([outerw/2,wall-(plink_r/2),wall+30]) sphere(plink_r);
    
    translate([outerw/2,outerw-wall+(plink_r/2),wall+10]) sphere(plink_r);
    translate([outerw/2,outerw-wall+(plink_r/2),wall+20]) sphere(plink_r);
    translate([outerw/2,outerw-wall+(plink_r/2),wall+30]) sphere(plink_r);
    
    translate([outerw-wall+(plink_r/2),outerw/2,wall+10]) sphere(plink_r);
    translate([outerw-wall+(plink_r/2),outerw/2,wall+20]) sphere(plink_r);
    translate([outerw-wall+(plink_r/2),outerw/2,wall+30]) sphere(plink_r);

}

module dock() {
          
    difference() {
        roundedRect([dock_outer_w,dock_outer_w,mainl], 2);
        translate([dock_wall*2+dock_inner_d,0,-1]) cube([dock_outer_w,dock_outer_w,mainl+2]);
        translate([dock_wall,dock_wall,3]) cube([dock_inner_d,dock_inner_w,mainl]);
        translate([0,dock_slot_w,6]) cube([dock_wall,dock_slot_w,mainl]);
    }
    
    // Some traction pimples for slide in bits
    plink_r=1;
    translate([dock_wall+dock_inner_d+(plink_r/2), dock_outer_w/2 ,13])  sphere(plink_r);
    translate([dock_wall+dock_inner_d+(plink_r/2), dock_outer_w/2 ,23])  sphere(plink_r);
    translate([dock_wall+dock_inner_d+(plink_r/2), dock_outer_w/2 ,33])  sphere(plink_r);
  
}

module hook() {
    
    dock_clear_d = dock_inner_d - 0.2;
    dock_clear_w = dock_inner_w - 0.2;
    
    translate([dock_wall,dock_wall,0]) cube([dock_clear_d,dock_clear_w,mainl]);
    translate([0,dock_slot_w,3]) cube([dock_wall,dock_slot_w,mainl-3]);

    translate([-20,dock_slot_w,3]) cube([20,dock_slot_w,dock_slot_w]);    
    
    l=dock_slot_w;
    w=dock_slot_w*2;
    h=dock_slot_w;
    translate([-20,dock_slot_w,3+dock_slot_w]) polyhedron(
              points=[[0,0,0], [w,0,0],  [w,l,0],  [0,l,0], [0,l,h], [0,0,h]],
              faces= [[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4], [5,2,1]]
              );
    
    translate([-dock_slot_w,dock_slot_w,3+dock_slot_w]) polyhedron(
              points=[[0,0,0],  [l,0,0],  [l,l,0],  [0,l,0], [l,l,h], [l,0,h]],
              faces= [[0,1,2,3],[0,3,4,5],[2,1,5,4],[3,2,4],[1,0,5] ]
              );
        
    
    
        
}