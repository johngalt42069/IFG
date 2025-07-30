include <util/rounded_cube.scad>
include <util/picatinny_rail.scad>

$fn = 128;

height = 76;
mount_height = 4;

grip_radius = 15;
pressure_pad_thickness = 14;

difference() {
	union() {
		//main body
		intersection() {
			cylinder(height, grip_radius, grip_radius);
			//cut out for pressure pad
			translate([-grip_radius + pressure_pad_thickness / 2 - 4, 0, height / 2]) cube([pressure_pad_thickness,
					grip_radius * 2,
				height], center = true);
		}
		//pic rail
		translate([-9, 0, 0])rotate([90, 0, 90]) picatinny_rail(height);
		//mlok mount surface
		rotate([0, 0, 90]) translate([0, 0, height + mount_height / 2])rounded_cube(54, 30, mount_height, 15);
		//mlok bulges
		rotate([0, 0, 90]) translate([0, 0, height + mount_height + 1]) mlok_bulge_solid();
		rotate([0, 0, 90]) translate([20, 0, height + mount_height + 1]) mlok_bulge_with_hole();
		rotate([0, 0, 90]) translate([-20, 0, height + mount_height + 1]) mlok_bulge_with_hole();
		//ramp
		hull() {
			translate([-8, 0, height]) cube([12, 32, 0.01], center = true);
			translate([-15, 0, height - 20]) cube([0.01, 0.01, 40], center = true);
		}
		hull(){
			translate([-14, 0, height-4]) cube([0.01, 20, 8], center = true);
			translate([14, 0, height]) cube([0.01, 30, 0.01], center = true);
		}
	}
	//mlok screw holes
	rotate([0, 0, 90]) translate([20, 0, height + mount_height / 2]) cylinder(mount_height, 2.8, 2.8, center = true);
	rotate([0, 0, 90]) translate([-20, 0, height + mount_height / 2]) cylinder(mount_height, 2.8, 2.8, center = true);
	translate([0, -20, height - 30]) cylinder(30, 5, 5);
	translate([0, 20, height - 30]) cylinder(30, 5, 5);
	//round off the bottom
	translate([-15, 0, 0]) rotate([0, 45, 0]) cube([8, 30, 8], center = true);
	translate([0, 15, 0]) rotate([45, 0, 0]) cube([30, 8, 8], center = true);
	translate([0, -15, 0]) rotate([45, 0, 0]) cube([30, 8, 8], center = true);
	//texture for extra grip
	for (i = [0:1:7])
	translate([0, 0, i * 4 + 10]) ring(15.01, 14.5, 2);
}

module ring(outer, inner, height) {
	difference() {
		cylinder(height, outer, outer, center = true);
		cylinder(height, inner, inner, center = true);
		translate([10, 0, 0]) cube([10, outer * 2, height], center = true);
	}
}