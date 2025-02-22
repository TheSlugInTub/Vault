This is going to be a study on how Rain World handles the procedural animation of the slugcat.

First we have to talk about the BodyPart class, the BodyPart class is a class that handles the simulation of a physics body, with a position, velocity, and a radius, because it is treated like a circle and has a few functions to push it out of terrain if it detects that it is colliding with it.
The BodyPart acts as a spring-like joint, it has a ConnectToPoint function which is used to bring it back to a certain position while keeping a distance constraint from it acting like a segment in a rope or a tail.

There is also a class called TailSegment which inherits BodyPart.
It has a connectedSegment variable, I do not know if this is the segment ahead of it or behind it.
In it's update function, if the distance from its connected segment is more than a certain threshold, it pulls itself towards the connected segment and if a flag is true, it pulls the connected segment towards itself too.

TODO: Add limbs and hand segments

There is a class called PlayerGraphics which on its construction spawns a list of BodyParts and a list of four TailSegments, and it then adds the list of TailSegments to the list of BodyParts. It then makes two SlugcatHands. The head is created as a GenericBodyPart which is just a BodyPart except it detects and resolves collisions every frame.
Strangely, there is a variable called legs which is just a singular GenericBodyPart.
There is also a variable called lookDirection.

Basic idea: Use a lot of spring-joints to act as a player body, that way when one of the spring-joints is pushed back by a collision all of them are since they're all connected to each other.
This also acts as a soft-body for the player which makes it feel much more natural than a rigidbody which is just a static collider that doesn't deform like an actual organic creature would.