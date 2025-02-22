Physics is the study of movement, momentum and change.

# Position, Velocity and Speed
---
Position is just the location of an object, it is a Vector3 which you will learn in [[Linear Algebra]], which denotes the location of an object in space. It can be [13.0, 3.14, 0.34], for example.

Velocity is the direction in where an object is heading towards, if it's even moving. It's a Vector3 which measures how quickly an object is moving and in what direction. It is computed by this formula: change in position divided by change in time.
So let's say that an object moved 10 units in the x-axis from [0, 0, 0]. This is how we would get the object's velocity: $[10, 0, 0]-[0, 0, 0]/0.016$
The 0.016 would be the change in time or delta time, if the object is static then the position vector would be 0, since it's subtracted by itself and division of zero by any number will result in zero, so the velocity will be zero.

Speed measures how quickly a distance is travelled, it can just be computed with the magnitude of velocity, and the magnitude of a vector is it's length.

## Acceleration
Acceleration measures how quickly velocity changes, just as how velocity measures how position changes. It is a Vector3. The formula for it is: change in velocity divided by change in time. 
When an object speeds up, its acceleration increases and points towards the velocity, but when the velocity is constant, acceleration is zero, since there's no change in velocity happening, and when the velocity decreases then the acceleration points opposite to the velocity because:
currentVel = [9, 0, 0] - previousVel = [10, 0, 0] would be negative!

### Quick note:
Let's say that a car is travelling at constant speed in a circle; does the acceleration change? The intuitive thing would be to say no because the velocity stays constant. But the direction of velocity changes so it would cause a difference in acceleration.

# Forces
---
A force is just a push or pull, when something affects the position of an object, that's a force.
An applied force is a force that we impose on an object, like a push with a hand, or a push with a cube.
Let's say you're pulling a chair with a rope, you pull the rope, that's the applied force, but what's pulling on the chair? Well, it's the rope, and the rope is pulling the chair with tension force, a tension force will always be a pulling force, that will be along a rope or a string.

A gravitational force is the force that the earth's gravity imposes on all objects on earth. It's a pulling force. A chair is affected by gravity, but why doesn't it fall down? It's because the floor stops it from falling down, and it imposes another force up onto the chair, this is called a normal force. Normal means perpendicular in math, which is why surface normals are given their name.

Let's take a very rough surface cube, and try to push it along the floor, you will notice that it's very hard to do so, because the rough surface of the cube has small irregularities that make it collide with the small irregularities with the floor, which impose another force onto them called the frictional force.

Take a submarine in water, what makes it float and not fall to the ocean floor? It's because the water pushes the submarine upwards. If there was no submarine in the water, water would immediately rush in to fill the gap left by the submarine, but the submarine is there so the water just pushes on the submarine counteracting gravity. This is called a buoyant force. Air also has a tiny bit of buoyancy since it acts the same as water, it would rush in to fill a gap. It's why balloons float, they're so light that the buoyancy of the air can counteract the gravity imposed on the balloon.

And a net force is just the vector sum of all the forces.

# Newton's Laws
---

## First law:
Let's say I kick a chair on grass, I am imposing an applied force onto the chair and it will obviously move the chair in the direction of this force, but once my feet stop colliding with the chair, why does it still move? My main man Newton once wondered about this and came up with this:
An object at rest stays at rest and an object in motion stays in motion.
But the chair comes to a stop at some point, so why does that happen? It's because the frictional force overpowered the chair, since it acts upon the chair for a longer duration than my kick does.
If you kick the chair on ice, then it will stop in a much longer duration because ice has less friction.
If you kick a chair in space, it will move forever through the endless void, because there's no friction or air resistance there. This natural tendency is called inertia.

## Second law:
Take a hockey puck and wack it to the left across the ice floor, it will accelerate to the left, its net force will point towards the left, because a large force has struck it to the left, and this force is overpowering. If you wack it to the right, the net force will be to the right, and acceleration will also be to the right. So this means that there is a correlation between net force and acceleration. And the puck will glide across quickly, but if you take a bowling ball and try to wack it left and then right, you can imagine that that would be much harder to do since its mass is much greater than the puck.
This can be neatly put into an equation: a = netforce/mass.

## Third law:
Kick a football, the football will move towards the direction you kicked it in, but the football also imposes a force on you, if you kick the ball harder, then your foot will hurt because the force that the ball is exerting on you is greater than the ligher kick. So whenever an object imposes a force on another object, the other object also imposes an equal but opposite force on the first object. The Earth imposes a force (gravity) upon an apple, but the apple also imposes an equal but opposite force upon the earth. But wait, the earth should move towards the apple right? Well, the forces are equal but it's much harder to accelerate an object with larger mass due to Newton's second law.
Also these forces happen at the same time.

# Momentum
---
Momentum is mass times velocity. The net force is the acceleration multiplied by the mass, and the acceleration is the rate of change of velocity with respect to time, but it can be rewritten like this:
F = Δp / Δt
The p is the momentum, F is net force and t is time and Δ is the change: (new - initial).
So the net force now calculates the rate of change of momentum, when something isn't moving, it doesn't have any momentum. And if something with little mass is moving, it won't have a lot of momentum, but take something with greater mass and move it, and it will have a lot of momentum.
Momentum is also a vector quantity because it's velocity (vector) divided by mass (scalar).

# Newton's Law of Gravitation
---
Gravity is a force* that attracts bodies together, anything with mass has gravity, even a baseball but its mass is so tiny that its gravity is negligible. But Earth's mass is so grat that it overpowers every single thing on the planet and pulls it closer to its center of mass. Things with greater mass bend the fabric of spacetime harder.
And the farther you go from a body, the effect that the gravity has on you becomes weaker and weaker.
The force of gravity between two bodies can be computed with this formula:
Gravity = (G * m1 * m2) / radius squared
What is G you may ask? It's the gravitational constant, we figured out that it was 6.6743×10⁻¹¹ with experimentation. 
And if you're measuring the gravitational force of Earth on any other body then G, m1 and the radius squared stay constant, the radius would just be the radius of the Earth, Earth is just so big that you wouldn't be able to get high enough for the distance to be significant.
We can sum up all these constants into a letter: g, it's different than big G.
g is approximately 9.8m/s².
Gravitational force affects objects with larger mass more than it does stutff with tiny mass.

# Impulse
---
Impulse is a vector quantity which represents change in momentum. If an object comes to a stop, it experiences a change in momentum (mass * velocity), so it will experience an impulse.

# Falling Objects
---
Let's say a bowling ball and a feather are both falling, and they started with the exact same conditions. Which one will fall first? Well obviously the bowling ball, but that's with air and the atmostphere. So let's remove the atmosphere and make these two objects fall in a vacuum and they will fall to the ground at the exact same time; why is this?
Take Newton's second law: F = m * a
The force of gravity will be: Fg = m * g
Gravity will be the only force acting on the objects so gravity is the net force.
So this means that: F = m * g = m * a
The *m*'s cancel out so we're just let with the gravity/acceleration. So this means that mass doesn't matter when an object is in free fall.

But there is indeed an atmosphere on Earth and air exists, so why does the feather fall slower in air?
There is a smaller force of gravity on the feather than on the ball, and when the feather speeds up, air resistance will increase as the feather is passing through more and more air, and eventually the air resistance will become large enough to cancel out the force of gravity on the feather so the net force becomes zero, and the feather will fall down at a constant low rate.
But with bowling ball, air resistance will take a much much longer time to become large enough to cancel out the gravitational force because the force of gravity on the ball is much larger than the feather, so it has to speed up a lot more before it reaches its terminal velocity (when air resistance cancels gravity), and then it falls down at a constant rate.

# Centripetal force
---
When object velocity straight, apply force perpendicular to velocity and object go spin, this called centripetal force.

# Orbital Motion
---
The way that a planet stays in orbit around a star is that the gravity of the star applies a centripetal force to the planet and makes it spin around the star.
But planets go into orbit around stars quite messily, and don't make a perfect circular orbit.
Their velocity might be higher than the centripetal force acting upon it (gravity of the star),
and this makes an elliptical orbit around the star.

## Ellipses
An ellipse happens when a circle gets smushed out, take two thumb tacks and put a string around them, then use a pencil/pen and draw as far as you can within the string, you will get an ellipse.
But the farther apart you put the two thumb tacks, the more elliptical the ellipse will get; this is called the ellipse's eccentricity. If you smush it out so much that the ellipse looks like a straight line then the eccentricity is 1. Also these thumb tacks are called the focci (focus) of the ellipse.
A circle is just a special case of an ellipse only having one focus.

## Kepler's Laws
Kepler was a cool dude, he had some laws he had to share.

### First law:
All planets must revolve around the sun with the sun as one of the orbital ellipse's focci.

# Coulomb's Law
---
On the micro scale of atoms, there exists protons, neutrons and electrons. All of which are particles and have something called charge, protons have a positive charge, neutrons have a neutral charge (0 charge), and electrons have a negative charge. Positives repel positives, negatives repel negatives and positives attract negatives and vice versa.
This is called electrostatic force, it is measured in coloumbs and there is a formula for calculating the amount of electrostatic force a particle has:
force = K * (particle 1's charge * particle 2's charge) / distance between them squared
The K is a universal constant much similar to the gravitational constant, we figured it out with experimentation and it is 8.99 × 109 N⋅m2/C2.

# Static Electricity
---
Take someone's head and a balloon, rub the balloon on the hair, and eventually the hair strands will repel each other and become attracted to the balloon, why is this?
Both the balloon and the hair have neutral charges since atoms have a neutral charge, since their protons, neutrons and electrons balance out. But when you rub the balloon on the hair, particles and charge move between the two objects, all the electrons jump to the balloon, why do they jump to the balloon and vice versa? Well, it's because certain materials have certain properties that attract/repel particles. And why electrons and not protons or neutrons? It's because protons and neutrons are held very tightly together in the nucleaus of an atom, and electrons are loose in the electon field of an atom.
And when the balloon gets more electric (more electrons added to it), its charge becomes negative, and the hair gets less electric, its charge becomes positive, and these two charges attract.

But take that balloon and hold it close to pieces of paper, the pieces of paper will be attracted towards the balloon, why is this? The pieces of paper should be neutral right?
Indeed they are neutral, but the electrons inside the atoms of the paper will be repelled slightly because they are more free to move around, this makes the positive nucleus of the atom closer towards the negative charged balloon, attracting the nucleus' towards the balloon.
And when the electrons and nucleus get displaced like this, it's called being polarized.

Now, you might be wondering: why doesn't static electricity last very long? This is because the particles will go away to other conductive surfaces or be taken away by the elements.
And when a tremendous amount of charge goes away, it's called a spark, and it happens when you touch a metal and it makes a somewhat loud noise and slightly hurts your finger.
There's a lot of charge build up in the metal, and when your finger touched it, it dissipated and created a spark, and when a monstrous amount of charge build up dissipates, a lightning strike is born, the lightning strike quickly hurries towards the ground since it's looking to dissipate to the closest surface.

# Kinetic Energy
---
Before we understand kinetic energy, let's define energy first, in the context of physics, energy is a scalar quantity which is measured in joules. Energy can either be kinetic energy (energy based on motion), potential energy (energy based on location) or electromagnetic radiation energy.
The kinetic energy of any object can be described with this equation:
K = (1/2)(ms²)
m is mass, s is speed, and K is the kinetic energy.

# Tips and Tricks
---
Change in momentum (impulse) can be written as:
Impulse = m * (v - u)
So velocity can be found with:
v = (Impulse / m) + u
This is good for when you need to find the final velocity when you know the mass, impulse and initial velocity.

For when you need to know final value with knowledge of rate of change and initial value:
rate of change - initial value
