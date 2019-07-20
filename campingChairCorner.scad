width = 41.5;
sideWidth = 21;
baseHeight = 3;
height = 19.5;
crossWidth = 6.2;
crossXLineOffset = 15;

cutoutWidth = 17;
cutoutSphereZRadius = 6;
// width added to the sphere to close the hole
cutoutFillerSize = 2;

holeDia = 5;
holesHeight = 12;
hole1Offset = 3;
hole2Offset = 5;
hole3Offset = 5.5;

cornerWidth = (width - sideWidth) / 2;

difference() {
    union() {
        base();
        crossSign();
        cutoutFiller();
    }
    cutout();
    
}

module base() {
    hull() {
        translate([0, cornerWidth, 0])
            cube([width, sideWidth, baseHeight]);
        translate([cornerWidth, 0, 0])
            cube([sideWidth, width, baseHeight]);
    }
}

module crossSign() {
    difference() {
        union() {
            translate([0, crossXLineOffset, 0]) {
                cube([width, crossWidth, height]);
            }
            translate([cornerWidth, 0, 0]) {
                cube([crossWidth, crossXLineOffset, height]);
            }
                
            translate([cornerWidth + crossWidth / 2, crossWidth + crossXLineOffset, 0]) {
                cube([crossWidth, width - (crossWidth + crossXLineOffset), height]);
            }
        }
        
        // Hole 1
        translate([cornerWidth-1, hole1Offset + holeDia/2, holesHeight])
            rotate([0, 90, 0])
                cylinder(h=crossWidth+2, d=holeDia, $fs=0.4, $fa=0.6);
        
        // Hole 2
        translate([width - hole2Offset - holeDia/2, crossXLineOffset + crossWidth + 1, holesHeight])
            rotate([90, 0, 0])
                cylinder(h=crossWidth+2, d=holeDia, $fs=0.4, $fa=0.6);
        
        // Hole 3
        translate([cornerWidth + crossWidth / 2-1, width - hole3Offset - holeDia/2, holesHeight])
            rotate([0, 90, 0])
                cylinder(h=crossWidth+2, d=holeDia, $fs=0.4, $fa=0.6);
    }
}

module cutout() {
    translate([cornerWidth + crossWidth *1.5, cutoutWidth/2 + crossXLineOffset + crossWidth, 0])
    rotate([0, 0, 90])
    scale([cutoutWidth, cutoutWidth, cutoutSphereZRadius*2]) {
        sphere(d=1, $fs=0.04, $fa=0.06);
        rotate([90, 0, 0])
            translate([-1 / 2, -1 / 2, 0])
            cube([1, 1, width / (cutoutSphereZRadius*2)]);
    }
}

module cutoutFiller() {
    difference() {
        translate([cornerWidth + crossWidth *1.5 + -cutoutFillerSize, cutoutWidth/2 + crossXLineOffset + crossWidth, cutoutFillerSize])
        rotate([0, 0, 90])
        scale([cutoutWidth, cutoutWidth, cutoutSphereZRadius*2]) {
            sphere(d=1, $fs=0.04, $fa=0.06);
        }
        translate([cornerWidth + crossWidth / 2, crossWidth + crossXLineOffset, -height]) {
            cube([cutoutWidth, width - (crossWidth + crossXLineOffset), height*2]);
        }
        translate([cornerWidth + crossWidth / 2 - cutoutWidth, crossWidth + crossXLineOffset, -height]) {
            #cube([cutoutWidth, width - (crossWidth + crossXLineOffset), height]);
        }
    }
}