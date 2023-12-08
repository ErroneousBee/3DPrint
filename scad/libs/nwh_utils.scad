// Neils utility functions

//include <nutsnbolts/cyl_head_bolt.scad>;
//include <nutsnbolts/materials.scad>;
//examples();

module examples() {
    
    // Countersonk holes with notcatch for attaching halves of a thing together
    translate([0,20,0]) countersink_with_nutcatch(type="M3", catch_clearance=1, length=10 );    
    translate([20,20,0]) countersink_with_nutcatch(type="M4", catch_clearance=1, length=20 );    
    translate([40,20,0]) countersink_with_nutcatch(type="M6", catch_clearance=1, length=30 );    

    // Socket head bolts 
    translate([0,40,0]) nut_and_hole(type="M3", catch_clearance=1, length=10, head_depth=4, head_clearance=0.1);
    translate([20,40,0]) nut_and_hole(type="M4", catch_clearance=1, length=20, head_depth=5, head_clearance=0.1);
    translate([40,40,0]) nut_and_hole(type="M6", catch_clearance=1, length=30, head_depth=5, head_clearance=0.1); 

}



// 1/4 tube to round edges with.
module roundel(l=40, r=3) {
	r2 = r*2;
	// Round the edge by 3
	rotate([-90,0,0]) rotate([0,90,0]) difference() {
		cylinder(r1=r2,r2=r2,h=l);
		cylinder(r1=r,r2=r,h=l);
		translate([-r2,0,0]) cube([r2*2,r2,l]);
		translate([0,-r2,0]) cube([r2,r2*2,l]);
	}
}

// Create a 1/4 tube to round edges with. length centered on 
// the origin, and the corner edge running down an axis throgh the origin.
module corner_rounder(l=40, r=3, align="x", quadrant=1) {
    
    rx = (align=="x")?90:0;
    ry = (align=="y")?90:0;
    rz=90*quadrant;

	rotate([ry,rx,0]) rotate([0,0,rz]) difference() {
		translate([-0.1,-0.1,-l/2])cube([r+0.2,r+0.2,l]);
		translate([r,r,(-l/2)-1]) cylinder(r1=r,r2=r,h=l+2);
	}

}

// A rectangle with rounded corners extruded up in z direction
// roundedRect([30,20,10], 5);
module roundedRect(size, r) {

	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z) hull() {
    	// place 4 circles in the corners, with the given radius
    	translate([r,r,0])     circle(r=r);    translate([0,20,0]) nut_and_hole(type="M3", catch_clearance=1, length=50, head_depth=5, head_clearance=0.1);

    	translate([r,y-r,0])   circle(r=r);
    	translate([x-r,y-r,0]) circle(r=r);
    	translate([x-r,r,0])   circle(r=r);

	}

}

// A long block with round ends extruded up in z direction
module block(w=10,h=10,l=30) {
    hull() {
        cylinder(d=w,h=h);
        translate([l,0,0]) cylinder(d=w,h=h);
        
    }
}

module tube(r=20,wall=3,h=5) {
	difference() {
		cylinder(r1=r+wall,r2=r+wall,h=h);
		cylinder(r1=r,r2=r,h=h);
	}
}

module tubesector(r=20,wall=3,h=5,angle=45) {
	cube_side=(wall+r)*2;
	difference() {
		tube(r=r,wall=wall,h=h);
		rotate([0,0,angle]) translate([-cube_side/2,0,0]) cube([cube_side,cube_side,h]);
		rotate([0,0,-angle]) translate([-cube_side/2,0,0]) cube([cube_side,cube_side,h]);
	}

}

//=================================================
// Neils standard holes for attaching

// Countersink,
// M4 = 4.2,2.7
// M3 = 2.7,1.5
module countersink_simple(r1,r2) {
	cylinder(r2,r1,r2);
	translate([0,0,0.1-r1]) cylinder(r1,r1,r1);
}

/**
 * Countersunk hole, Sizes from:
 * https://www.sciencedirect.com/topics/engineering/countersunk-hole
 */
module countersink_iso(size="M4") { 	

    // convert size name to diameter
    sizes=[ 
        ["M3",6.72],
        ["M4",8.96],
        ["M5",11.2],
        ["M6",13.44],
        ["M8",17.92],
        ["M10",22.4],
        ["M12",26.88],
        ["M16",33.6],
        ["M20",40.32]
    ];

    match=search([size], sizes, num_returns_per_match=1)[0];
    d=sizes[match][1];
    
    cylinder(r1=d/2,r2=0,h=d/2);
    translate([0,0,-d/4]) cylinder(r1=d/2,r2=d/2,h=d/4);
}

// A standard M3 countersunk hole with extra clearance
module m3_hole(x=12,radius,angle=0) {
		translate([0,radius,x]) {
		 	//rotate([270+angle,0,0]) countersink_simple(r1=2.75, r2=1.5, h1=1.5, h2=1.5);
		 	rotate([270+angle,0,0]) countersink_simple(r1=2.75, r2=1.5);
			rotate([90+angle,0,0]) hole_through(name="M3", l=30, cl=0.1, h=0, hcl=0.1);	
		}
}

// A standard Metric countersunk hole with extra clearance above
module countersink_with_nutcatch(type="M3" , length=50 ,catch_clearance=1) {
    
    rotate([180,0,0]) nutcatch_parallel(type,clh=catch_clearance);
    translate([0,0,length]) rotate([180,0,0]) countersink_iso(size=type);
	rotate([180,0,0]) hole_through(name=type, l=length, cld=0.1, h=0, hcld=0.1);	
		
}

// hole for cylinder head bolt and hex nutcatch in line with hole
module nut_and_hole(xlate=[0,0,0],type="M3", catch_clearance=1, length=50, head_depth=0, head_clearance=0.1) {
	translate(xlate) rotate([0,180,0]) {
			nutcatch_parallel(type,clh=catch_clearance);
			translate([0,0,-length]) rotate([0,180,0]) hole_through(name=type, l=length-head_depth, cld=0.1, h=head_depth, hcld=head_clearance);
	}
}

// Bolt with hex nutcatch in line. ( deprecated )
module bolthole(name="M4", l=10,nutcatch_h=10,nutcatch_d=4) {
	union() {
			hole_through(name=name, l=l, cld=.5, h=0, hcl=0.5); // small hole
			
            hole_through(name=name, l=0, cld=0, h=4, hcl=0.5); // bolt head
			
            translate([0,0,-nutcatch_h+nutcatch_d])
            nutcatch_parallel(name,l=nutcatch_d); // nutcatch
	}
}

// Tapping hole for 3/8 to 1/4 inch tripod mount converter
module recess_hole(x=12,diameter=8,radius=20,angle=0) {
		translate([0,radius,x]) {
			rotate([90+angle,0,0]) {
                cylinder(h = 50, r1=diameter/2, r2=diameter/2, center = false);	
                cylinder(h = 1.5,  r1=(diameter+2)/2, r2=(diameter+2)/2, center = false);	
                
            }
		}
}

/**
 * A grid to rest soap bars on, that can rest inside the dish. 
 * Suggested use is to use difference() with the container its in.
 * @parm w width of trivet in mm
 * @parm d depth or length in mm
 * @parm h height of bars in mm
 * @parm bar width of an individual bar  in mm
 * @parm grid[x,y] size of a single cell in the grid in mm
 */
module trivet_grid(w,d,h,bar=2,grid=[12,12]) {
      
    // How many bars on the x and y axes
    xbars=abs(w/(2*grid[0]));
    ybars=abs(d/(2*grid[1]));


    if ( xbars > 0 && xbars < 10000) {
        for ( i=[0:xbars]) {
            translate([w/2-(bar/2)+(i*grid[0]),0,0]) rounded_bar([bar,d,h]);
            translate([w/2-(bar/2)-(i*grid[0]),0,0]) rounded_bar([bar,d,h]);
        }
    }
    if ( ybars > 0 && ybars < 10000) {
        for ( i=[0:ybars]) {
            translate([0,d/2-(bar/2)+(i*grid[1]),0]) rounded_bar([w,bar,h]);
            translate([0,d/2-(bar/2)-(i*grid[1]),0]) rounded_bar([w,bar,h]);
        }
    }
    
}

/**
 * A mesh grid on legs to go in bottom of pot. 
 * @parm w width of trivet in mm
 * @parm d depth or length in mm
 * @parm h height of bars in mm. Caller is under an obligation to difference() the dish 
 *         so that the trivet fits in the dish bottom
 * @parm bar width of an individual bar  in mm
 * @parm grid[x,y] number of bars in each direction
 */
module trivet_mesh(w,d,h,bar=2,grid=[12,12]) {
    
    module bar(l,r) {
        cylinder(l,r,r,center=false);
        translate([0,0,0]) sphere(r);
        translate([0,0,l]) sphere(r);
    }
        
      
    // How many bars on the x and y axes
    x_gap=w/(grid[0]-1);
    y_gap=d/(grid[1]-1);
   
    for ( i=[0:x_gap:w] ) {
            translate([i,0,0]) rotate([270,0,0]) bar(d,bar/2);
    }
    for ( i=[0:y_gap:d] ) {
        translate([0,i,0]) rotate([0,90,0]) bar(w,bar/2);
    }
    
    for ( i=[1:grid[0]-2] ) {
        for ( j=[1:grid[1]-2] ) {
            translate([i*x_gap,j*y_gap,0]) bar(h,bar/2);
        }
    }
    
}

/**
 * Four pegs in the base of the dish, to stop the trivet rising when the soap is lifted.
 * @parm w width of trivet in mm
 * @parm d depth or length in mm
 * @parm h height of bars in mm. Caller is under an obligation to difference() the dish 
 *         so that the trivet fits in the dish bottom
 * @parm bar width of an individual bar  in mm
 * @parm grid[x,y] size of a single cell in the grid in mm
 */
module trivet_grid_holder(w,d,h,bar=2,grid=[12,12]) {
    
    xbars=abs(w/(2*grid[0]));
    ybars=abs(d/(2*grid[1]));
    
    x1=(w/2) - (1*grid[0]) + bar/2;
    y1=(d/2) - (1*grid[1]) + bar/2;
    x2=(w/2) + (1*grid[0]) - bar/2*3;
    y2=(d/2) + (1*grid[1]) - bar/2*3;
      
    translate([x1,y1,0]) rounded_bar([bar,bar,h]);
    translate([x1,y2,0]) rounded_bar([bar,bar,h]);
    translate([x2,y1,0]) rounded_bar([bar,bar,h]);
    translate([x2,y2,0]) rounded_bar([bar,bar,h]);
}

/**
 * A rounded wall peice that we use to create the trivet and holder pegs. 
 */
module rounded_bar(dim) {
    w=dim[0];
    d=dim[1];
    h=dim[2];
    
    r=(min(w,d)/2);
    tx=( w<d ) ? r : w-r;
    ty=( w<d ) ? d-r : r;
    
    hull() {
        translate([r,r,0]) {
            cylinder(r1=r,r2=r,h=h-r);
            translate([0,0,h-r]) sphere(r=r);
        }
        translate([tx,ty,0]) {
            cylinder(r1=r,r2=r,h=h-r);
            translate([0,0,h-r]) sphere(r=r);
        }
    }
}
