include <nutsnbolts/cyl_head_bolt.scad>;
include <nutsnbolts/materials.scad>;
include <libs/utils.scad>;
include <libs/nwh_utils.scad>;


// Measured off the pole head
ph_height_total=82;
ph_height_base=15;
ph_base_d=27;
ph_top_d=20;

// Main attachment outer dimensions
height=ph_height_total+ph_top_d+ph_top_d;
top_radius=26;
bot_radius=30;

attach_radius=24;
attach_height=30;

lug_width=10;
lug_radius=15;
lug_gap=15;

gripper_pad_length=20;
arm_width=30;
arm_length=200;
attach_wall=10;


lower_cut_length=(arm_length/2)-gripper_pad_length-attach_radius-attach_wall;
upper_arm_width=arm_width;
upper_arm_height=45;

module lug( width, radius ) {
translate([0,width/2,radius*2])
    rotate([90,0,0])
    cylinder(r1=radius,r2=radius,h=width);

translate([-radius,-width/2,0])
    cube([radius*2,width,radius*2]);
}


// ===============================
// Main attachment


module mainshape() {
	cylinder(r1=bot_radius,r2=top_radius,h=height);
	//translate([0,0,height]) sphere(r=top_radius);
    
    translate([0,lug_gap,height-5])
    lug( lug_width, lug_radius); 

    translate([0,-lug_gap,height-5])
    lug( lug_width, lug_radius); 
  
        

    
}

module hollow(dtop,dbot,hbase,htot) {
    throw=5; // A little room for jamming it on harder
	cylinder(r1=dbot/2,r2=dbot/2,hbase);
	translate([0,0,hbase]) cylinder(r1=dbot/2,r2=dtop/2,h=htot-hbase);
  	translate([0,0,htot]) cylinder(r1=dtop/2,r2=dtop/2,h=throw);
	translate([0,0,htot+throw]) sphere(r=dtop/2);
    
   
}

module main_attachment() {
    difference() {
        
        mainshape();

        hollow(ph_top_d, ph_base_d, ph_height_base, ph_height_total);
        
        
    }
}

main_attachment();

// ==============================
// The Lower Arm

module la_solid() {
    cylinder(r1=attach_radius+attach_wall,r2=attach_radius+attach_wall,h=attach_height);   
    translate([0,0,attach_height/2]) cube([arm_width,arm_length,attach_height],true);
}

module la() {
    difference() {
        la_solid();
    
        // Mount onto body    
        cylinder(r1=attach_radius,r2=attach_radius,h=attach_height);
        
        // Remove flesh from arms
        translate([-arm_width,(-arm_length/2)+gripper_pad_length,attach_height/2])
        rotate([90,0,90]) 
        roundedRect([lower_cut_length,attach_height,2*arm_width],5);

        translate([-arm_width,lower_cut_length-gripper_pad_length,attach_height/2])
        rotate([90,0,90]) 
        roundedRect([lower_cut_length,attach_height,2*arm_width],5);
        
    }
        
}

//translate([100,0,0]) la();



        

// ==========================
// The Upper Arm

module ua() {
    difference() {
        translate([0,0,upper_arm_height/2])
        cube([upper_arm_width,arm_length,upper_arm_height],true);
    
        translate([-arm_width,-(arm_length/2)+gripper_pad_length,attach_height*1.7]) 
        rotate([0,90,0])
        roundedRect([attach_height,arm_length-gripper_pad_length-gripper_pad_length,2*arm_width],5);
        
    }
    
    difference() {
        union() {
           rotate([0,0,90]) lug(10,20);
           translate([20,0,0])  rotate([0,0,90]) lug(10,20);
           translate([-20,0,0]) rotate([0,0,90]) lug(10,20);
           cylinder(r1=35,r2=35,h=attach_height*0.7);
        }
        
        // Nut catch and hole
       	translate([-30,0,40])
        rotate([0,90,0])
        nut_and_hole(xlate=[0,0,0],type="M4",lh=80,lx=8);

        // Countersink
        translate([20+5-0.5,0,40]) rotate([0,-90,0]) countersink_iso(size="M4");
        
        
        
    }
}

//translate([200,0,0]) ua();

