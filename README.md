Here comes another multicopter file. In the process of making my multicopter, more specifically making it look better, I decided to design a case for my PDB (power distribution board).

Frankly this can be used for anything in which you need a box with some slits in it. 

This file is super problematic. Coming from knowing basic Java and good OpenSCAD, I've been relying heavily on the OpenSCAD documentation for this project. Currently, the only thing that is SUPER flawed is the "numOfSlits" variable, or the number of slits per side. My issue has been figuring out the math for positioning even numbers of slits greater than two.

So, currently, the program works with 1 slit, 2 slits, any odd number of slits, but no other even numbers. It will GIVE you something if you enter in an even number, it's just not going to be correct and the spacing WILL be off. I've tried multiple things and all of them have issues, I'm still looking into this. Hence why the .scad file is labeled "ALPHA" and there is no STL. 

This is experimental and my second time ever using a for loop (in OpenSCAD) , being my first time using an else-if ladder (in OpenScad). Most things work, but proceed at your own risk and customize it to your liking, hence why there is no STL here.

I also need to add mounting holes as this will be for the PDB, separate this into two pieces that can be assembled, and figure out how the two will go together (likely will be epoxy). 

Proceed at your own risk. More updates will come as I improve this little by little. 

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>. Do as you please, and if you want to do things outside of the license restrictions, feel free to contact me and I might make an exception.

Enjoy yourself. 

Lucas
