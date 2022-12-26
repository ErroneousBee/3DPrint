$fn=150;

// Measured Dimentions
od1=56; // Spool flance diameter
od2=52; // Spool body diameter
id1=12; // Spindle hole main diameter
id2=7.6; // Spindle stop plate hole diameter
h=26; // duh.
flange_h=2; // Sppol flange height
inner_stop_h=3; // Spindle stop plate height

clearance=1; // Fudge factor to allow the metal bits to slide in

spoggot_r = od2/9;
spoggot_h = h-10;
spoggot_z = h-spoggot_h+1;
spoggot_x = od2/3;


// Calcuated dimentions
outer_r1 = od1/2;
outer_r2 = od2/2;
inner_r1 = (id1+clearance)/2;
inner_r2 = (id2+clearance)/2;

module mainbody() {
    translate([0,0,0]) cylinder(flange_h,outer_r1,outer_r1);
    translate([0,0,h-flange_h]) cylinder(flange_h,outer_r1,outer_r1);
    cylinder(h,outer_r2,outer_r2);
}

module spindlehole() {
    translate([0,0,-1]) cylinder(inner_stop_h+2,inner_r2,inner_r2);
    translate([0,0,inner_stop_h]) cylinder(h,inner_r1,inner_r1);
}



difference() {
    mainbody();
    spindlehole();
    rotate([0,0,0]) translate([spoggot_x,0,spoggot_z]) cylinder(r1=spoggot_r,r2=spoggot_r,h=spoggot_h);
    rotate([0,0,60]) translate([spoggot_x,0,spoggot_z]) cylinder(r1=spoggot_r,r2=spoggot_r,h=spoggot_h);
    rotate([0,0,120]) translate([spoggot_x,0,spoggot_z]) cylinder(r1=spoggot_r,r2=spoggot_r,h=spoggot_h);
    rotate([0,0,180]) translate([spoggot_x,0,spoggot_z]) cylinder(r1=spoggot_r,r2=spoggot_r,h=spoggot_h);
    rotate([0,0,240]) translate([spoggot_x,0,spoggot_z]) cylinder(r1=spoggot_r,r2=spoggot_r,h=spoggot_h);
    rotate([0,0,300]) translate([spoggot_x,0,spoggot_z]) cylinder(r1=spoggot_r,r2=spoggot_r,h=spoggot_h);
}


