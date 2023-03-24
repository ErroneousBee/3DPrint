/**
 * Bagpipe extra bits.
 */
 
$fn=180;

// Measured from the bagpipe
plug_inner_r=15/2;
plug_len1=25;
reed_len1=65;
plug_len2=34;
reed_len2=82;
plug_outer_r=34/2;
drone_outer_r=28/2;

// Calculated or arbitary sizes
lip=0.25;
plug_cap_l=20;

drone_reed_guard(plug_len1+reed_len1, plug_inner_r, drone_outer_r);
//drone_reed_guard(plug_len2+reed_len2,plug_inner_r, drone_outer_r);
//drone_plug(plug_len1, plug_cap_l, plug_inner_r, plug_outer_r, lip);

/**
 * Basic plug to replace a drone with silence
 */
module drone_plug(plug_l, cap_l, plug_r, cap_r, lip) {

    cylinder(plug_l+cap_l, plug_r, plug_r );
    cylinder(cap_l, cap_r, cap_r);
    translate([0,0,plug_l+cap_l-3]) cylinder(3, plug_r + lip, plug_r + lip );
    translate([0,0,cap_l]) cylinder(3, plug_r + lip, plug_r + lip );

}

/**
 * A cover for an exposed reed for transport of drones in cases
 */
module drone_reed_guard(length, inner_r, outer_r) {
    
    hole_r = inner_r+0.5; // bit more clearance

    difference() {
        union() {
            cylinder(length, outer_r, hole_r+3);
            translate([0,0,length]) sphere(hole_r+3);
        }
        drone_reed_hole(length, hole_r);
    }
}

module drone_reed_hole(length, radius) {
    cylinder(length, radius, radius);
    translate([0,0,length]) sphere(radius);
    cylinder(3, radius+2, radius);
    
}

