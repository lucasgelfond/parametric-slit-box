//The length of the box (mm).
boxX = 65;
//The width of the box (mm).
boxY = 65;
//The height of the box (mm).
boxZ = 15;

//The thickness of the inside pieces of the box.
boxThick = 6;

//The width of the slit(s).
slitWidth = 21.25;
//The height of the slit(s).
slitHeight = 8;
//The distance between slits.
distSlits = 7.5;

//The X size of the mounting pattern (the first one, ie what mounting pattern your PDB is)
mountPatternX = 45;
//The Y size of the mounting pattern (the first one, ie what mounting pattern your PDB is)
mountPatternY = 45;
//The size of all of the screw holes in the model.
holeSize = 4.25;


//The number of slits. This is fully customizable.
numOfSlits = 2;

//The distance of the plates before they print.
distPlates = 10;

//The detail of all spheres/cylinders in the shape. A value between 30 and 100 is fairly typical. 
sfn = 30;

//Mode changer. Mode 1 is what the box would look like put together (assembly mode), and mode 2 is the two plates separated (printing mode). 
mode = 2;


//The mounting pattern for attaching the two plates (x).
attachMountHoleX = 57.5;
//The mounting pattern for attaching the two plates (y).
attachMountHoleY = 57.5;

//The distance to countersink the screw holes.
countersinkDist =  3;

//The size of the countersunk hole.
countersunkHoleSize = 5.6;


module slit() {
    cube([boxX, slitWidth, slitHeight], center=true);
}
module hole() {
    cylinder(r=holeSize/2, h = boxZ*2, $fn = sfn, center=true);
}


module countersunkHole() {
    cylinder(r=countersunkHoleSize/2, h = countersinkDist, $fn = sfn, center=true);
}


module slits() {
    if (numOfSlits == 1) {
        translate([boxX/2,0,0]) {
            slit();
        }
    }
    else if(numOfSlits == 2) {
        translate([boxX/2, (slitWidth+distSlits)/2, 0]) {
                slit();
            }
            translate([boxX/2, (slitWidth+distSlits)/-2, 0]) {
                slit();
            }
    }
    else if(numOfSlits % 2 > 0) {     //If the number of slits is an odd number:
        translate([boxX/2,0,0]) { //Put one slit in the middle.
            slit();
        }
        for (numOfSlits = [1:(numOfSlits-1)/2]) { //Then, put half the sits on one side of middle slit, and half on the other. 
            translate([boxX/2, (slitWidth+distSlits)*-numOfSlits, 0]) { //Move the slits on the edge of the middle slit, then move them more based on the user-set distance of slits. This is one side of slits.
                slit();
            }
            translate([boxX/2, (slitWidth+distSlits)*numOfSlits, 0]) { //Move the slits on the edge of the middle slit, then move them more based on the user-set distance of slits. This is one side of slits.
                slit();
            }
        }
    }
    else if(numOfSlits % 2 == 0) { //If the number of slits is even
        //Creating the two middle pieces
        translate([boxX/2, (slitWidth+distSlits)/-2, 0]) {
            slit();
        }
        translate([boxX/2, (slitWidth+distSlits)/2, 0]) {
            slit();
         }
         //Make half of the amount of slits that exist, minus the first two:
         for(numOfSlits = [2:numOfSlits/2]) {
             //The 0.5 in both of these is in reference to above, compensating for it negatively. For the negative one, the value is positive, for the positive one, the value is negative. 
             translate([boxX/2, (slitWidth+distSlits)*(numOfSlits-0.5), 0]) {
                    slit();
             }
             translate([boxX/2, (slitWidth+distSlits)*(0.5-numOfSlits), 0]) {
                 slit();
             }
         }
    }
    else {
        //Something went wrong
     }
 } 
    


module mountHoles() {
    translate([mountPatternX/2, mountPatternY/2,(boxZ+boxThick)/-2]) {
        hole();
    }
    translate([mountPatternX/-2, mountPatternY/2, (boxZ+boxThick)/-2]) {
        hole();
    }
    translate([mountPatternX/2, mountPatternY/-2, (boxZ+boxThick)/-2]) {
        hole();
    }
    translate([mountPatternX/-2, mountPatternY/-2, (boxZ+boxThick)/-2]) {
        hole();
    }
}

module attachementHoles() {
    translate([attachMountHoleX/2, attachMountHoleY/2,(boxZ+boxThick)/-2]) {
        hole();
    }
        translate([attachMountHoleX/-2, attachMountHoleY/2,(boxZ+boxThick)/-2]) {
        hole();
    }
        translate([attachMountHoleX/2, attachMountHoleY/-2,(boxZ+boxThick)/-2]) {
        hole();
    }
        translate([attachMountHoleX/-2, attachMountHoleY/-2,(boxZ+boxThick)/-2]) {
        hole();
    }
}
module countersunkHoles2() {
    translate([attachMountHoleX/2, attachMountHoleY/2, (boxZ-countersinkDist)/2]) {
          countersunkHole();
    }
    translate([attachMountHoleX/-2, attachMountHoleY/2, (boxZ-countersinkDist)/2]) {
          countersunkHole();
    }
    translate([attachMountHoleX/2, attachMountHoleY/-2, (boxZ-countersinkDist)/2]) {
          countersunkHole();
    }
    translate([attachMountHoleX/-2, attachMountHoleY/-2, (boxZ-countersinkDist)/2]) {
          countersunkHole();
    }

}
module countersunkHoles1() {
    translate([attachMountHoleX/2, attachMountHoleY/2, (boxZ-countersinkDist)/-2]) {
          countersunkHole();
    }
    translate([attachMountHoleX/-2, attachMountHoleY/2, (boxZ-countersinkDist)/-2]) {
          countersunkHole();
    }
    translate([attachMountHoleX/2, attachMountHoleY/-2, (boxZ-countersinkDist)/-2]) {
          countersunkHole();
    }
    translate([attachMountHoleX/-2, attachMountHoleY/-2, (boxZ-countersinkDist)/-2]) {
          countersunkHole();
    }

}




module box() {
    difference() {
        cube([boxX, boxY, boxZ], center=true);
        cube([boxX-boxThick*2, boxY-boxThick*2, boxZ-boxThick*2],center=true);
        cube([boxX-boxThick*2, boxY-boxThick*2, slitWidth/2],center=true);
        rotate([0,0,0]) {
            slits();
        }
        rotate([0,0,90]) {
            slits();
        }
        rotate([0,0,180]) {
            slits();
        }
        rotate([0,0,270]) {
            slits();
        }
        
        rotate([0,0,0]) {
            attachementHoles();
        }
        rotate([0,180,0]) {
            attachementHoles();
        
        }  
    }
}





module bottomPlate() {
    difference() {
        box();
        mountHoles();
        translate([0,0,boxZ/2]) {
            cube([boxX+1, boxY+1, boxZ], center=true);
        }
        translate([0,0,0]) {
            countersunkHoles1();
        }
    }
}

module topPlate() {
    rotate([0,180,0]) {
        difference() {
            box();
            translate([0,0,boxZ/-2]) {
                cube([boxX+1, boxY+1, boxZ], center=true);
            }
           countersunkHoles2();
        }
    }
}



module plates() {
    difference() {
        union() {
            translate([0, (distPlates+boxY)/2, 0]) {
                topPlate();
            }
            translate([0, (distPlates+boxY)/-2, 0]) {
                bottomPlate();
            }
        }
    }
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


