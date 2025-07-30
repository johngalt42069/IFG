include <util/rounded_cube.scad>
include <util/picatinny_rail.scad>

$fn = 128;

height = 106;
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
		translate([-7, 0, 0])rotate([90, 0, 90]) picatinny_rail(height);
		//mlok mount surface
		translate([0, 0, height + mount_height / 2])rounded_cube(54, 30, mount_height, 15);
		//mlok bulges
		translate([0, 0, height + mount_height + 1]) mlok_bulge_solid();
		translate([20, 0, height + mount_height + 1]) mlok_bulge_with_hole();
		translate([-20, 0, height + mount_height + 1]) mlok_bulge_with_hole();
		//forward ramp
		hull() {
			translate([-26, 0, height]) cube([0.01, 10, 0.01], center = true);
			translate([-5, 0, height - 20]) cube([0.01, 28, 40], center = true);
		}
	}
	//mlok screw holes
	translate([20, 0, height + mount_height / 2]) cylinder(mount_height, 2.8, 2.8, center = true);
	translate([-20, 0, height + mount_height / 2]) cylinder(mount_height, 2.8, 2.8, center = true);
	translate([-20, 0, height - 24]) cylinder(24, 5, 5);
	//round off the bottom
	translate([-15, 0, 0]) rotate([0, 45, 0]) cube([8, 30, 8], center = true);
	translate([0, 15, 0]) rotate([45, 0, 0]) cube([30, 8, 8], center = true);
	translate([0, -15, 0]) rotate([45, 0, 0]) cube([30, 8, 8], center = true);
	//texture for extra grip
	for (i = [0:1:15])
	translate([0, 0, i * 4 + 10]) ring(15.01, 14.5, 2);
}

module ring(outer, inner, height) {
	difference() {
		cylinder(height, outer, outer, center = true);
		cylinder(height, inner, inner, center = true);
		translate([10, 0, 0]) cube([10, outer * 2, height], center = true);
	}
}