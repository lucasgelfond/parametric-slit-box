boxX = 45;
boxY = 45;
boxZ = 10;
boxThick = 2.5;

slitWidth = 10;
slitHeight = 2.5;
distSlits = 2;

numOfSlits = 6;

difference() {
    cube([boxX, boxY, boxZ], center=true);
    cube([boxX-boxThick*2, boxY-boxThick*2, boxZ-boxThick*2],center=true);
}


module slit() {
    #cube([boxThick*2, slitWidth, slitHeight], center=true);
}

module slits() {
    if (numOfSlits == 1) {
        translate([boxX/2,0,0]) {
            slit();
        }
    }
    else if(numOfSlits % 2 > 0) {     //If the number of slits is an odd number:
        translate([boxX/2,0,0]) { //Put one slit in the middle.
            slit();
        }
        for (numOfSlits = [1:(numOfSlits-1)/2]) { //Then, put half the sits on one side of middle slit, and half on the other. 
            translate([boxX/2, (slitWidth+distSlits/2)*-numOfSlits, 0]) { //Move the slits on the edge of the middle slit, then move them more based on the user-set distance of slits. This is one side of slits.
                slit();
            }
            translate([boxX/2, (slitWidth+distSlits/2)*numOfSlits, 0]) { //Move the slits on the edge of the middle slit, then move them more based on the user-set distance of slits. This is one side of slits.
                slit();
            }
        }
    }
    else if(numOfSlits % 2 == 0) { //If the number of slits is even
        for(numOfSlits = [1:numOfSlits/2]) {
            translate([boxX/2, (slitWidth/2+distSlits/2), 0]) {
                slit();
            }
            translate([boxX/2, (slitWidth/2+distSlits/2)*numOfSlits, 0]) {
                slit();
            }
        }
    }
    else {
        //Something went wrong
     }
 } 
    

slits();