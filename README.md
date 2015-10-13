# Particle Simulator
This program simulates charged particles in an environment with electromagnetic forces at play. 
Written in the Processing platform. 

# Download & Run
To run the simulator (in its current, primitive form) clone the repository into a local directory and navigate
into the app directory. Select one of the files labelled with your OS (Mac OSX, Windows 32-bit, or Windows 64-bit)
and unzip it. In the uncompressed directory, locate and run the file named 'simulator'. Enjoy the mesmerizing particles!

# Science Behind the Curtain

There are three special concepts of physics that are implemented in this simulation. 
    
1) Charge interaction
- Particles of the same charge repel and of differing charges attract. The force is given and
modeled by the equation: Force = k(charge1 * charge2) / radius.
- Because the electric force is SO much larger than gravitational force, mass doesn't need to be taken into account
        when calculating the interactionary forces
- Mass of the particle factors in to calculating its acceleration due to a given force: F = mass * acceleration = k(charge1 * charge2) / radius

2) Electric fields
- This program simulates constant electric fields by creating an even potential difference accross a distance. 
- In the electric field, positive charges are accelerated linearly and move toward the point of lower potential.
- Negative charges are accelerated in the direction of the lower potential.
- The force on the charge is given and modeled by the equation: F = m * a = E * q, where E is the strength of the electric field and q is the charge of the particle.
    
3) Magnetic fields
- This program simulates constant magnetic fields with a vector perpendicular to the plane of the screen given by vector indicator (x)
- Magnetic fields exert a force on a charged particle perpendicular to its velocity vector.
- The force is given and modeled by the equation, F = m * a = q * v x B, where q is the charge and q x B is the cross product of the velocity and magnetic field (B) vectors.
- Because the acceleration of a charged particle under magnetic force is always perpendicular to the velocity, the magnetic force only changes the direction, 
        but not the magnitude, of the particle's velocity.

# License
The MIT License (MIT)
 
Copyright (c) 2015 [Ryan Brigden] (http://github.com/rbrigden)


