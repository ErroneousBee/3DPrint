// Adapts a Hope bike light to an Electron Nano 9 bar mount.
$fn=50;
include <libs/nutsnbolts/cyl_head_bolt.scad>;
include <libs/nutsnbolts/materials.scad>;
include <libs/nwh_utils.scad>;






sloth = 2.7;
slotl = 43.3-1.5;
middw = 9.35;

mainw = 13.5;
mainl = 60;
mainh = 2.5;

slotw = (mainw-middw)/2;

topw = 18;
topl = 60;
toph = 5;

pitw=8;
pitl=4.1;
pith=1.5;

module slider_body ( slidesize ) {
    w=slidesize[0];
    l=slidesize[1];
    h=slidesize[2];
 
    // Slider ( Slides into the mount )
	roundedRect([w,l,h+sloth], 2);
    
    // Top section ( screw the devices onto this surface ) 
	translate([(w-topw)/2,0,mainh+sloth]) roundedRect([topw,topl,toph], 2);
    
    // Stops the slider running off the end 
	translate([(w-topw)/2,slotl,0]) roundedRect([topw,topl-slotl,h+sloth], 2);
}


module slider() { 
    difference() {
    
        #slider_body([mainw,mainl,mainh]);
    
        // Side slots
        translate([0,0,2.51]) cube([slotw,slotl,sloth]);	
        translate([mainw-slotw,0,2.51]) cube([slotw,slotl,sloth]);
    
        // Pit
        translate([(mainw-pitw)/2,1.7,0]) cube([pitw,pitl,pith]);
    
        // Small M3 hole and nut trap in case you fancy doing extra bolty things
        nut_and_hole(xlate=[mainw/2,18,-0.01],type="M3");
        nut_and_hole(xlate=[mainw/2,33,-0.01],type="M3");
        nut_and_hole(xlate=[mainw/2,48,-0.01],type="M3",length=60);
    
        // Where the Hope light screws to the bracket
        //translate([mainw/2,49,-0.01]) rotate([0,180,0]) hole_through(name="M5", l=50, cld=0.1, h=6, hcld=0.1);
	}
}
    
    



module mount() {
    
    
 
}


slider();
//mount(); 