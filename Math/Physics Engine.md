In this file, I will be taking notes and simplifying the process of building a physics engine for a game.
## Symbols
---
$Δ$  is used to represent a change in a value ($x1 - x2$), $Δt$ would be the change in time, it's called deltatime.
$d$ and a value next to it represents the tiniest amount of change of that value (infinitely small).
$p′$ with the little exclamation mark represents the updated position after a time interval
## Velocity
---
An object's velocity is just its change in position divided by deltatime.
$v = (p1 - p2) / deltatime$
p1 and p2 are its first and second positions. p1 would be the object's position in the first frame, and p2 would its position in the second frame.
$p•$ is the velocity of p, that's the notation I'm gonna use here.
And $p••$ is the acceleration of p.
## Acceleration
---
Acceleration is the rate at which an object's velocity is changing. A positive acceleration means the velocity is increasing, a negative acceleration means the velocity is decreasing, a 0 acceleration means the velocity is not changing.
$a = Δv / Δt$ 
## Vector Differential Calculus
---
A vector, $x•$ would be $[x•, y•, z•]$. And $x••$ would be $[x••, y••, z••]$. 
## Speed
---
The speed of an object is the magnitude of its velocity vector. 
## Integral calculus
---
In math, integration is the accumulation of small quantities over time. We can use integration to 'integrate' or update the positions of all the rigidbodies in a scene with this formula
$p′ = p + p•t$
This equation only works for an object that is not accelerating. This could be turned into this piece of code:

```cpp
position += velocity * deltatime
```
## Newton's laws
---
Newton is the top G of physics, so we have to hear him out on his laws.
#### Newton's first law

An object's will stay in motion until it's disrupted by a force.
This means that a ball when pushed will keep moving, the ball's velocity stays constant.
This seems a little weird to us because things slow down and decelerate in the real world.
The reason this happens is because of drag and friction, the closest we can get to simulating this law is by pushing an object in outer space, where there is no drag, forces or friction.
#### Newton's Second Law

$F = ma$ is Newton's second law, $F$ is all the forces that are being applied to the object, gravity, friction, tension, etc. The force acting upon the object is inversely proportional to the object's mass.
This means if a force is 1.0, then if the force acts upon an object with a mass of 10.0, then it won't do much, but on an object with a mass of 0.1, it will affect it greatly.

The third law doesn't really matter here.
## Hook's law
---
Hook discovered how springs work, he said this:
$f = -kΔl$
$f$ is the net force of the spring, $k$ is the stiffness of the string, and $Δl$ is the distance the spring is extended. A spring has a natural length when it's at rest. This length is called $l⁰$.
This formula only works for a one dimensional spring, for a spring in 3d space:
$f = -k(|d| - l⁰)d$
$d$ is the end of the spring attached to an object, $d$ is obtained from this formula:
$d = xa - xb$
$xa$ is the position at the end of spring, and $xb$ is the position at the other end of the spring.
## Angular velocity
---
We'll need a way to represent rotations for rigidbodies so we'll use [[Quaternions]], because they don't fall into the traps of representations such as euler angles which introduce gimbal lock.
The way we find an object's angular velocity is with this formula:
$θ• = ra$
$r$ is the rate at which the object is spinning, and and $a$ is the axis on which the object is spinning.
To update the object's quaternion by the angular velocity (which is a vector), we have this formula:
$$θ′ = θ + (Δt / 2) * w * θ$$
$w$ is the quaternion.
## Torque
---
A torque is a twisting force, it needs to have an axis and a force.
Twisting a bottle cap for example, is a torque.
## Moment of Inertia
---
The moment of inertia is a measure of how much force you have to put to rotate an object.
And it depends on how you spin the object. If you're holding a broomstick like a sword, then you have to put a reasonable amount of effort to spin it. If you set the broomstick on the ground however, it becomes a lot easier to just twirl it with your fingers. Modulus modulus