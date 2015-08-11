//The length of the box (mm).
boxX = 57.5;
//The width of the box (mm).
boxY = 57.5;
//The height of the box (mm).
boxZ = 15;

//The thickness of the inside pieces of the box.
boxThick = 2.5;

//The width of the slit(s).
slitWidth = 42.5;
//The height of the slit(s).
slitHeight = 7.5;
//The distance between slits.
distSlits = 7.5;

//The X size of the mounting pattern (the first one, ie what mounting pattern your PDB is)
mountPatternX = 45;
//The Y size of the mounting pattern (the first one, ie what mounting pattern your PDB is)
mountPatternY = 45;
//The size of all of the screw holes in the model.
holeSize = 3.5;

//The cutoff for the bottom part.
bottomCutoff = 4;

//The number of slits. This is fully customizable.
numOfSlits = 1;

//The distance of the plates before they print.
distPlates = 10;

//The detail of all spheres/cylinders in the shape. A value between 30 and 100 is fairly typical. 
sfn = 50;

//Mode changer. Mode 1 is what the box would look like put together (assembly mode), and mode 2 is the two plates separated (printing mode). 
mode = 2;


//The mounting pattern for attaching the two plates (x).
attachMountHoleX = 52.5;
//The mounting pattern for attaching the two plates (y).
attachMountHoleY = 52.5;

//The distance to countersink the screw holes.
countersinkDist =  4;

//The size of the countersunk hole.
countersunkHoleSize = 4.75;

//Overlap for cut holes
overlap = 1;

//The amount that the holes should go out from the middle, additionally from being centered with the screw (not countersunk) holes.
csOut = 0;

module slit() {
    cube([boxX, slitWidth, slitHeight], center=true);
}
module hole() {
    cylinder(r=holeSize/2, h = boxZ*2, $fn = sfn, center=true);
}

module slits() {
    if (numOfSlits == 1) {
        //If the number of slits = 1, add one slit to the middle.
        translate([boxX/2,0,0]) slit();
    }
    //If the number of slits is two, move them to be back to back in the middle, then move them both half the slit distance, making a full slit distance in between them. -1 and 1 are for each side (left and right slit). 
    else if(numOfSlits == 2) {
        for(i = [-1, 1]) translate([boxX/2, (slitWidth+distSlits)/2, 0]) slit();
    }
    else if(numOfSlits % 2 > 0) {     //If the number of slits is an odd number:
        //Put one slit in the middle.
        translate([boxX/2,0,0]) slit();
        //Subtract one from the # of slits, giving you an even #os, then put half on one side of the middle and half on the other (n = [1, -1]).
        for (i = [1:(numOfSlits-1)/2], n = [1, -1])  translate([boxX/2, (slitWidth+distSlits)*i*n, 0]) slit();
     }
    else if(numOfSlits % 2 == 0) { //If the number of slits is even
        //Two middle pieces, evenly spaced, one on each side.
        for(i = [-1, 1]) translate([boxX/2, (slitWidth+distSlits)/2*i, 0]) slit();
         //Subtract two from the amount of slits, and make this many slits. But half on one side and half on the other (hence n = [1, -1]).
        for(i = [2:numOfSlits/2], n=[-1, 1]) translate([boxX/2, (slitWidth+distSlits)*(i-0.5)*n, 0]) slit();
    }
    else {
        //Something went wrong
     }
 } 
    


module mountHoles() {
    //Separate variables so that four holes are created, one on each side (four plus/negative combos). 
    for(i = [-1, 1], n = [-1, 1]) translate([mountPatternX/2*n, mountPatternY/2*i,(boxZ+boxThick)/-2]) hole();
}

module attachementHoles() {
    //Separate variables so that four holes are created, one on each side (four plus/negative combos).
    for(i = [-1, 1], n = [-1, 1]) translate([attachMountHoleX/2*n, attachMountHoleY/2*i,(boxZ+boxThick)/-2]) hole();
}
module countersunkHoles(val) {
     //Separate variables (n and i) so that four holes are created, one on each side (four plus/negative combos). Variable val is so that they can be put on top of on bottom without the need for a separate module.
    for(i = [-1, 1], n =[-1, 1]) translate([(attachMountHoleX/2+csOut)*i, (attachMountHoleY/2+csOut)*n, (boxZ-countersinkDist+overlap*2)/2*val]) cylinder(r=countersunkHoleSize/2, h = countersinkDist+overlap, $fn = sfn, center=true);

}





module box() {
    difference() {
        cube([boxX, boxY, boxZ], center=true);
        cube([boxX-bottomCutoff*2, boxY-bottomCutoff*2, boxZ-boxThick*2],center=true);
        //Rotate the slits in each direction.
        for(i = [0:90:270]) rotate([0,0,i]) slits();
        //Rotate the attachment holes on each side.
        for(i = [0, 180]) rotate([0,i,0]) attachementHoles();
    }
}





module bottomPlate() {
    difference() {
        box();
        mountHoles();
        translate([0,0,boxZ/2]) cube([boxX+1, boxY+1, boxZ], center=true);
        translate([0,0,0]) countersunkHoles(-1);
    }
}

module topPlate() {
    rotate([0,180,0]) {
        difference() {
            box();
            translate([0,0,boxZ/-2]) cube([boxX+1, boxY+1, boxZ], center=true);
            countersunkHoles(1);
        }
    }
}



module plates() {
    translate([0, (distPlates+boxY)/2, 0]) topPlate();
    translate([0, (distPlates+boxY)/-2, 0]) bottomPlate();
}


module mode() {
    if(mode == 1) {
        bottomPlate();
        rotate([0,180,0]) {
            topPlate();
        }
     }
     else if(mode == 2) {
        plates();
      }
      else {
      //Error
        }
}

mode();


