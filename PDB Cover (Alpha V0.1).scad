boxX = 65;
boxY = 65;
boxZ = 8;
boxThick = 5;

slitWidth = 42.5;
slitHeight = 4;
distSlits = 2;

mountPatternX = 45;
mountPatternY = 45;
holeSize = 4.5;

numOfSlits = 1;
distPlates = 10;

sfn = 100;
mode = 2;

attachMountHoleX = 57.5;
attachMountHoleY = 57.5;

module slit() {
    cube([boxX, slitWidth, slitHeight], center=true);
}
module hole() {
    cylinder(r=holeSize/2, h = boxThick * 3, $fn = sfn);
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
module box() {
    difference() {
        cube([boxX, boxY, boxZ], center=true);
        cube([boxX-boxThick*2, boxY-boxThick*2, boxZ-boxThick*2],center=true);
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
    }
}

module topPlate() {
    rotate([0,180,0]) {
        difference() {
            box();
            translate([0,0,boxZ/-2]) {
                cube([boxX+1, boxY+1, boxZ], center=true);
            }
        }
    }
}

module plates() {
    translate([0, (distPlates+boxY)/2, 0]) {
        topPlate();
    }
    translate([0, (distPlates+boxY)/-2, 0]) {
        bottomPlate();
    }
}


module mode() {
    if(mode == 1) {
        box();
     }
     else if(mode == 2) {
        plates();
      }
      else {
      //Error
        }
}

mode();

